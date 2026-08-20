Task 1: Anthropic SDK
- Check `packages/llm_sdk_anthropic/lib/src/anthropic_client.dart` and `anthropic_llm_client.dart`
- Verify `StreamingHttpClient` usage, no leftover `dio` field
- Verify test `anthropic_client_test.dart` uses `DioStreamingHttpClient` properly
- Run any available tests
- Report back with status and any issues found
