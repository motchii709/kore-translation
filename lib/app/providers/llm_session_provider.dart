import 'dart:async';

import 'package:kore_backends/kore_backends.dart';
import 'package:kore_translation/app/providers/llm_config_provider.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'llm_session_provider.g.dart';

/// The open LLM session, kept alive so the agent backends (ACP / Codex)
/// hold one warm subprocess across translations instead of losing it to
/// auto dispose mid-stream. `KoreApp`'s warm-up listen opens it at startup;
/// a settings change rebuilds it, closing the previous session. A failed or
/// dead session is replaced per user action — see
/// `TranslationController.translate`.
@Riverpod(keepAlive: true)
Future<LlmSession> llmSession(Ref ref) async {
  final llmConfig = await ref.watch(llmConfigStorageProvider.future);
  final session = await llmClientFrom(llmConfig).open();
  // Rebuilt (e.g. by a settings change) while still opening: the losing
  // generation closes its own session and bows out.
  if (!ref.mounted) {
    unawaited(session.close());
    throw StateError('llmSession was rebuilt while opening');
  }
  ref.onDispose(() => unawaited(session.close()));
  return session;
}
