/// One streamed fragment of a turn.
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
