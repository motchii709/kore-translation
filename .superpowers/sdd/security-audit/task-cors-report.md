# CORS & API Communication Security Audit Report

**Project:** kore-translation
**Date:** 2026-08-19
**Scope:** Direct browser-to-LLM API calls (OpenAI, Anthropic, Google Gemini, DeepSeek, OpenAI-compatible)

---

## Executive Summary

**Overall Risk: MEDIUM**

The implementation correctly uses HTTPS endpoints and Authorization headers for API keys. Critical gaps exist in: (1) web platform timeout enforcement (absent), (2) SSE streaming DoS protections (no limits on event size, chunk count, or stream duration), (3) error body exposure in exceptions, and (4) parity gap between web/native timeout handling.

---

## 1. CORS Preflight Verification

| Provider | Endpoint | CORS Status |
|----------|----------|-------------|
| OpenAI | `https://api.openai.com/v1/chat/completions` | ✅ Supports CORS (browser-ready) |
| Anthropic | `https://api.anthropic.com/v1/messages` | ✅ Supports CORS (browser-ready) |
| Google Gemini | `https://generativelanguage.googleapis.com/v1beta/models/*:streamGenerateContent` | ✅ Supports CORS (browser-ready) |
| DeepSeek | `https://api.deepseek.com/chat/completions` | ✅ Supports CORS (browser-ready) |
| OpenAI-compatible | User-configured | ⚠️ Unknown (depends on deployment) |

**Finding:** All default providers are major LLM APIs with documented CORS support for direct browser access. The `fetch` API in `streaming_http_client_web.dart` automatically triggers preflight for cross-origin requests. No CORS misconfiguration detected in code.

**Risk:** LOW

---

## 2. API Key Exposure

| Provider | Header Used | Location | Risk |
|----------|-------------|----------|------|
| OpenAI | `Authorization: Bearer <key>` | Header | ✅ Safe |
| OpenAI-compatible | `Authorization: Bearer <key>` (conditional) | Header | ✅ Safe |
| Anthropic | `x-api-key: <key>` | Header | ✅ Safe |
| Google Gemini | `x-goog-api-key: <key>` | Header | ✅ Safe |
| DeepSeek | `Authorization: Bearer <key>` | Header | ✅ Safe |

**Finding:** All providers transmit API keys in HTTP headers, never in URL query parameters. The Google client uses `queryParameters: {'alt': 'sse'}` for SSE format negotiation only — no credentials in query string.

**Risk:** LOW

---

## 3. Request/Response Validation

### Request Validation
- **JSON Schema:** Implicit via freezed `fromJson` / `toJson` serialization. Malformed requests caught at serialization time.
- **Size Limits:** **MISSING** — No request body size limits enforced before sending.
- **Input Sanitization:** User-provided `systemPrompt`/`userText` passed directly to API without length validation or sanitization.

### Response Validation
- **JSON Parsing:** `tryJsonDecode` catches `FormatException`, returns `null` on invalid JSON.
- **Schema Validation:** Freezed `fromJson` throws `CheckedFromJsonException` on schema mismatch — handled by skipping event.
- **API Error Envelope:** `throwIfApiError` parses standard `{"error": {"message": ...}}` envelope across all providers.
- **Size Limits:** **MISSING** — No response body size limits. Error bodies fully materialized in memory (`_readAllBytes` on web, `utf8.decodeStream` on native).

**Risk:** MEDIUM — Missing request/response size limits could enable DoS via oversized payloads.

---

## 4. Error Handling & Sensitive Data Leakage

### Current Behavior
```dart
// streaming_http_client_web.dart:34-36
final errorBytes = await _readAllBytes(readable);
final errorText = utf8.decode(errorBytes);
throw StreamingHttpException(status, 'HTTP $status', body: errorText);

// streaming_http_client_io.dart:43-52
errorBody = await utf8.decodeStream(b.stream);
throw StreamingHttpException(..., body: errorBody);
```

### Findings
| Issue | Location | Severity |
|-------|----------|----------|
| Full error response body included in exception `body` field | Both platforms | **HIGH** — May contain API keys, PII, or internal error details |
| `StreamingHttpException.toString()` exposes body in logs | `streaming_http_client.dart:20` | **HIGH** — `toString()` includes `body` |
| Dio error materialization mutates response data | `anthropic_llm_client.dart:74-78`, `deep_seek_llm_client.dart:63-70` | MEDIUM — Error body replaces stream, could leak in logs |
| No sanitization of error messages before logging | N/A | MEDIUM |

**Risk:** HIGH — Error bodies from LLM APIs can contain sensitive context, user data, or partial API keys in error messages.

---

## 5. Streaming Safety (SSE DoS Protections)

### Current Implementation
```dart
// sse/src/sse.dart — line-based, no limits
Stream<String> sseDataEvents(Stream<List<int>> bytes) {
  return utf8.decoder.bind(bytes).transform(const LineSplitter())
      .where((line) => line.startsWith('data:'))
      .map((line) => ...);
}
```

### Missing Protections
| Protection | Status | Impact |
|------------|--------|--------|
| Max event size limit | ❌ **MISSING** | Single `data:` line could be unlimited → OOM |
| Max events/chunks per stream | ❌ **MISSING** | Infinite stream → resource exhaustion |
| Per-chunk timeout | ❌ **MISSING** | Slowloris-style attack: trickle bytes indefinitely |
| Total stream duration timeout | ⚠️ PARTIAL | Native: 120s receive timeout; Web: **NONE** |
| Connection idle timeout | ❌ **MISSING** | No enforcement on either platform |

### Platform Parity Gap
| Feature | Native (Dio) | Web (fetch) |
|---------|--------------|-------------|
| Connect timeout | 10s (configurable) | **Ignored** (param accepted, unused) |
| Receive/stream timeout | 120s (configurable) | **Ignored** (param accepted, unused) |
| Request timeout | Via Dio options | **Not implemented** |

**Risk:** HIGH — Web platform has zero timeout enforcement. Both platforms lack SSE-level DoS protections (event size, count, duration).

---

## 6. HTTPS Enforcement / Mixed Content

### Default Base URLs (all HTTPS)
| Provider | Default Base URL |
|----------|------------------|
| OpenAI | `https://api.openai.com/v1` |
| Anthropic | `https://api.anthropic.com` |
| Google Gemini | `https://generativelanguage.googleapis.com` |
| DeepSeek | `https://api.deepseek.com` |
| OpenAI-compatible | **Empty string** (user-configured) |

### Findings
- **All default endpoints use HTTPS** ✅
- **OpenAI-compatible** allows empty `baseUrl` — user could configure HTTP endpoint for local Ollama/LM Studio ⚠️
- No code-level enforcement preventing HTTP URLs
- No HSTS or certificate pinning (not applicable for Flutter web/native HTTP clients)

**Risk:** LOW for defaults, MEDIUM for user-configured OpenAI-compatible endpoints.

---

## 7. StreamingHttpClient Implementation Parity

| Aspect | Native (Dio) | Web (fetch) | Gap |
|--------|--------------|-------------|-----|
| Timeout enforcement | ✅ 10s connect, 120s receive | ❌ Params accepted, **ignored** | **CRITICAL** |
| Error body materialization | `utf8.decodeStream` | `_readAllBytes` (manual) | Different code paths |
| Stream cancellation | Via Dio cancel token | Reader.cancel() not exposed | Partial |
| Resource cleanup | `dio.close()` | No-op | OK |

**Finding:** Web implementation completely ignores timeout parameters. This is a significant parity gap — web users have no protection against hung connections.

---

## Summary of Findings by Severity

### CRITICAL
1. **Web platform has no timeout enforcement** — `connectTimeout`/`receiveTimeout` parameters accepted but unused in `FetchStreamingHttpClient`.

### HIGH
2. **Error response bodies exposed in exceptions** — `StreamingHttpException.body` contains full error response; `toString()` logs it.
3. **No SSE DoS protections** — No limits on event size, chunk count, stream duration, or per-chunk timing.
4. **Web platform has zero stream timeout** — Connection can hang indefinitely.

### MEDIUM
5. **No request/response size limits** — Oversized payloads could cause OOM.
6. **OpenAI-compatible allows HTTP** — User can configure insecure endpoint.
7. **Dio error handling mutates response** — Error body replaces stream, may leak in downstream logging.
8. **No input validation on prompts** — User-controlled `systemPrompt`/`userText` sent without length checks.

### LOW
9. **CORS** — All default providers support browser CORS.
10. **API key exposure** — Keys correctly in headers, not URLs.
11. **HTTPS defaults** — All default endpoints use HTTPS.

---

## Recommendations

### Immediate (Critical/High)
1. **Implement web timeouts** — Use `AbortController` with timeout in `FetchStreamingHttpClient.post()`.
2. **Sanitize error bodies** — Strip/redact sensitive fields before including in `StreamingHttpException`. Never include raw body in `toString()`.
3. **Add SSE parsing limits** — Max event size (e.g., 1MB), max events per stream (e.g., 10,000), per-chunk timeout (e.g., 30s), total stream timeout.
4. **Add request/response size limits** — Enforce max body size (e.g., 10MB) at HTTP client level.

### Short-term (Medium)
5. **Validate `baseUrl` scheme** — Reject non-HTTPS for production providers; warn for OpenAI-compatible.
6. **Add prompt length validation** — Enforce reasonable limits on `systemPrompt`/`userText`.
7. **Unify error handling** — Single error materialization path; never mutate response streams.
8. **Add streaming timeout to web** — Match native 120s receive timeout behavior.

### Long-term (Low)
9. **Consider certificate pinning** for high-value API keys (native only).
10. **Audit logging** — Ensure no `StreamingHttpException` or `LlmApiException` logged verbatim in production.

---

## Files Audited

- `packages/llm_sdk_http/lib/src/streaming_http_client_web.dart`
- `packages/llm_sdk_http/lib/src/streaming_http_client_io.dart`
- `packages/llm_sdk_http/lib/src/streaming_http_client.dart`
- `packages/llm_sdk_http/lib/src/streaming_http_client_stub.dart`
- `packages/llm_sdk_core/lib/src/llm_client.dart`
- `packages/llm_sdk_core/lib/src/llm_api_exception.dart`
- `packages/llm_sdk_core/lib/src/llm_stream_event.dart`
- `packages/llm_sdk_openai/lib/src/open_ai_llm_client.dart`
- `packages/llm_sdk_openai/lib/src/api_error.dart`
- `packages/llm_sdk_openai/lib/src/safe_json.dart`
- `packages/llm_sdk_openai_compatible/lib/src/open_ai_compatible_llm_client.dart`
- `packages/llm_sdk_openai_compatible/lib/src/api_error.dart`
- `packages/llm_sdk_openai_compatible/lib/src/safe_json.dart`
- `packages/llm_sdk_anthropic/lib/src/anthropic_llm_client.dart`
- `packages/llm_sdk_anthropic/lib/src/api_error.dart`
- `packages/llm_sdk_anthropic/lib/src/safe_json.dart`
- `packages/llm_sdk_google/lib/src/gemini_llm_client.dart`
- `packages/llm_sdk_google/lib/src/api_error.dart`
- `packages/llm_sdk_google/lib/src/safe_json.dart`
- `packages/llm_sdk_deep_seek/lib/src/deep_seek_llm_client.dart`
- `packages/llm_sdk_deep_seek/lib/src/api_error.dart`
- `packages/llm_sdk_deep_seek/lib/src/safe_json.dart`
- `packages/sse/lib/src/sse.dart`
- `packages/kore_config/lib/src/llm_client_config.dart`
- `lib/app/providers/translation_jobs_provider.dart`