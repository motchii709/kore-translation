import 'dart:convert';

/// Incrementally accumulates a JSON document that is still being generated
/// (e.g. streamed from an LLM) and produces decodable snapshots of it.
///
/// Feed text with [add]; read the current snapshot with [decode] or
/// [completedText]. Light repairs are applied on both ends of the document:
///
/// - Anything before the root `{` or `[` is skipped (prose, a
///   ```` ```json ```` fence line), and anything after the root value closes
///   is ignored (a closing fence, trailing prose).
/// - The truncated tail is completed: an unterminated string is closed, a cut
///   escape sequence or trailing comma is dropped, and the missing closing
///   brackets are appended.
///
/// This is deliberately a completer, not a full repair parser (single-quoted
/// strings, unquoted keys and the like stay broken): cut points that resist
/// completion — mid-key, a truncated literal like `tru` or `12.` — simply
/// make [decode] return null, and the next chunk heals them.
///
/// [add] scans only the added chunk; [decode] and [completedText] cost one
/// pass over the accumulated document.
final class PartialJsonDecoder {
  final _body = StringBuffer();
  final _closers = <String>[];
  var _started = false;
  var _done = false;
  var _inString = false;
  var _escaped = false;

  /// Appends the next chunk of the document, scanning only [chunk].
  void add(String chunk) {
    for (var i = 0; i < chunk.length && !_done; i++) {
      final char = chunk[i];
      if (!_started) {
        if (char != '{' && char != '[') {
          continue; // Leading yap before the root value.
        }
        _started = true;
      }
      if (_inString) {
        if (_escaped) {
          _escaped = false;
        } else if (char == r'\') {
          _escaped = true;
        } else if (char == '"') {
          _inString = false;
        }
      } else {
        switch (char) {
          case '"':
            _inString = true;
          case '{':
            _closers.add('}');
          case '[':
            _closers.add(']');
          case '}' || ']':
            // Never empty here: closing the root sets _done, which stops the
            // scan for good.
            _closers.removeLast();
            _done = _closers.isEmpty;
        }
      }
      _body.write(char);
    }
  }

  /// The document so far, completed so it can be decoded.
  String get completedText {
    var body = _body.toString();
    if (_escaped) {
      // Drop the cut escape sequence's backslash.
      body = body.substring(0, body.length - 1);
    } else if (!_inString) {
      final trimmed = body.trimRight();
      body = trimmed.endsWith(',') ? trimmed.substring(0, trimmed.length - 1) : trimmed;
    }
    return body + (_inString ? '"' : '') + _closers.reversed.join();
  }

  /// Decodes [completedText], or null when the current cut point resists
  /// completion (nothing arrived yet, mid-key, a truncated literal, ...).
  Object? decode() {
    try {
      return jsonDecode(completedText);
    } on FormatException {
      return null;
    }
  }
}
