import 'dart:convert';

/// Attempts to decode [text] as JSON, returning null on failure.
Object? tryJsonDecode(String text) {
  try {
    return jsonDecode(text);
  } on FormatException {
    return null;
  }
}
