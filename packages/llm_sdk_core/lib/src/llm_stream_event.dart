import 'package:llm_sdk_core/src/llm_client.dart';
import 'package:partial_json/partial_json.dart';

/// One streamed fragment of a turn — the provider packages' common currency
/// for assembling [LlmSession.streamObject]'s snapshot stream (see
/// [LlmSnapshotStream.decodeSnapshots]).
sealed class LlmStreamEvent {
  const LlmStreamEvent();
}

/// A fragment of the reply text.
final class LlmTextDelta extends LlmStreamEvent {
  const LlmTextDelta(this.text);

  final String text;
}

/// A fragment of the model's (summarized) thinking.
final class LlmThinkingDelta extends LlmStreamEvent {
  const LlmThinkingDelta(this.text);

  final String text;
}

/// Folds a fragment stream into [LlmSession.streamObject]'s snapshot stream:
/// each fragment extends the accumulated thinking text or the incrementally
/// decoded JSON reply (see [PartialJsonDecoder]), and yields the decoder's
/// view of the turn so far. Both sides stay null until they first exist,
/// and cut points that resist completion keep the last decodable object, so
/// the reply never regresses.
extension LlmSnapshotStream on Stream<LlmStreamEvent> {
  Stream<T> decodeSnapshots<T>(T Function(String? thinking, Map<String, dynamic>? reply) decoder) {
    StringBuffer? thinking;
    final partial = PartialJsonDecoder();
    Map<String, dynamic>? reply;
    return map((event) {
      switch (event) {
        case LlmThinkingDelta(text: final delta):
          (thinking ??= StringBuffer()).write(delta);
        case LlmTextDelta(text: final delta):
          partial.add(delta);
          if (partial.decode() case final Map<String, dynamic> decoded) {
            reply = decoded;
          }
      }
      return decoder(thinking?.toString(), reply);
    });
  }
}
