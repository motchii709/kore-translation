import 'dart:convert';

/// Extracts `data:` payloads from a Server-Sent Events byte stream.
///
/// The APIs used here send one `data:` line per event, so a line-based
/// implementation is sufficient.
Stream<String> sseDataEvents(Stream<List<int>> bytes) {
  // `Stream<Uint8List>.transform(utf8.decoder)` fails at runtime because
  // StreamTransformer is invariant, hence bind.
  return utf8.decoder.bind(bytes).transform(const LineSplitter()).where((line) => line.startsWith('data:')).map((line) {
    // Per the SSE spec, strip at most one leading space from the value.
    // https://html.spec.whatwg.org/multipage/server-sent-events.html
    final value = line.substring('data:'.length);
    return value.startsWith(' ') ? value.substring(1) : value;
  });
}
