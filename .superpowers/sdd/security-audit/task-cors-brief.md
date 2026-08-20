# Task: CORS & API Communication Security

## Context
Direct browser-to-LLM API calls (no backend). APIs: OpenAI, Anthropic, Google Gemini, Groq, Mistral, DeepSeek. Uses custom `StreamingHttpClient` with `dio` (native) / `fetch` (web).

## Requirements
1. **CORS preflight** - verify all APIs allow browser requests, check `Access-Control-Allow-Origin`
2. **API key exposure** - keys in `Authorization` header, not URL/query params
3. **Request/response validation** - JSON schema validation, size limits, streaming timeout
4. **Error handling** - no sensitive data in error messages/logs
5. **Streaming safety** - SSE parsing limits, chunk size limits, connection timeouts
6. **Mixed content** - all HTTPS, no HTTP endpoints
6. **Custom `StreamingHttpClient`** - `dio` vs `fetch` implementation parity

## Files to audit
- `packages/llm_sdk_http/lib/src/streaming_http_client_web.dart`
- `packages/llm_sdk_http/lib/src/streaming_http_client_io.dart`
- `packages/llm_sdk_*/lib/src/*_llm_client.dart` (each provider)
- `lib/app/providers/translation_jobs_provider.dart` (request flow)

## Deliverable
Report: `task-cors-report.md` with findings on CORS, header leakage, streaming DoS, MITM risks.