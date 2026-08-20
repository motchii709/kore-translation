# XSS/Injection Vulnerability Audit Report

**Project:** Kore Translation (Flutter Web App)
**Date:** 2026-08-19
**Auditor:** Security Audit

---

## Executive Summary

**Overall Risk Level: LOW**

The codebase demonstrates strong security practices for a Flutter web application. All user-controlled data is rendered through safe Flutter widgets (`SelectableText`, `Text`) that output plain text, not HTML. No HTML/JS injection vectors were found in the Dart code. The primary risk is the **absence of a custom `web/index.html` with Content Security Policy (CSP) headers**, relying on Flutter's default template which may not provide adequate protection against injection attacks in the browser context.

---

## Findings Classification

| Severity | Count |
|----------|-------|
| Critical | 0 |
| High     | 0 |
| Medium   | 1 |
| Low      | 3 |
| Info     | 2 |

---

## Detailed Findings

### MEDIUM: Missing Content Security Policy (CSP) in Web Build
**File:** `web/index.html` (not present in source — Flutter generates default at build time)  
**Location:** N/A — generated during `flutter build web`

**Description:**  
The project does not include a custom `web/index.html` file. Flutter generates a default template at build time that **lacks a Content Security Policy**. Without CSP, the deployed GitHub Pages site has no defense-in-depth against:
- Injected scripts from compromised CDN dependencies
- Malicious browser extensions
- Data exfiltration via `fetch`/`XMLHttpRequest` to attacker-controlled domains
- Clickjacking (no `frame-ancestors` directive)

**Impact:**  
If an attacker compromises a third-party dependency or injects content via another vector (e.g., malicious browser extension), scripts can execute freely in the app's origin.

**Proof of Concept:**  
```bash
# After flutter build web, inspect build/web/index.html:
# No <meta http-equiv="Content-Security-Policy"> tag present
```

**Remediation:**  
Create `web/index.html` with a strict CSP:
```html
<meta http-equiv="Content-Security-Policy" content="
  default-src 'self';
  script-src 'self' 'wasm-unsafe-eval';
  style-src 'self' 'unsafe-inline';
  img-src 'self' data:;
  font-src 'self' data:;
  connect-src 'self' https://generativelanguage.googleapis.com https://api.openai.com https://api.anthropic.com https://api.deepseek.com;
  frame-ancestors 'none';
  base-uri 'self';
  form-action 'self';
">
```
Adjust `connect-src` to match actual API endpoints used by configured LLM providers.

---

### LOW: LLM Response Data Rendered Without Sanitization (Defense-in-Depth)
**File:** `lib/app/pages/translate/sections/translation_result_section.dart:222-225, 256, 266`  
**Widget:** `TranslationResultView`

**Description:**  
Translation results (`translation.translation`, `translation.explanation`, `translation.proofread`, `alternative.text`, `alternative.nuance`) come directly from LLM API responses and are rendered via `SelectableText`. While `SelectableText` outputs plain text (not HTML), the LLM could return:
- Markdown/HTML-like content that users might misinterpret
- Unicode control characters (e.g., RTL overrides, zero-width spaces)
- Extremely long strings causing UI DoS (layout overflow)

**Code Locations:**
- Line 222-225: `SelectableText(translation.translation ?? '')`
- Line 256: `SelectableText(notes)` (explanation/proofread)
- Line 266: `SelectableText(alternative.text ?? '')`

**Impact:**  
Low — Flutter's text rendering is safe from code execution. Risk is primarily UX deception or layout disruption.

**Remediation:**  
- Add max-length validation on `TranslationResult.fromJson` (in `kore_client` package)
- Consider stripping/normalizing Unicode control characters
- Truncate extremely long responses with "Show more" affordance

---

### LOW: Error Messages Rendered Without Sanitization
**File:** `lib/app/pages/translate/sections/translation_result_section.dart:284-301`  
**Widget:** `_ErrorCard`

**Description:**  
Error messages from `KoreClientException`, `LlmApiException`, `DioException`, and `StreamingHttpException` are rendered via `SelectableText(message)`. These messages may contain:
- Server response bodies (API error details)
- Stack traces
- Network-level error details

While rendered as plain text, verbose error messages could leak sensitive information (internal paths, API keys in URLs, stack traces) to end users.

**Code Location:** Line 291-294 — `DioException` and `StreamingHttpException` include response bodies directly.

**Remediation:**  
- Sanitize error messages before display (strip URLs, tokens, stack traces)
- Show user-friendly messages; log detailed errors to console only
- Consider a dedicated `ErrorFormatter` utility

---

### LOW: JSON Parsing of Stored Data Without Validation
**File:** `lib/app/pages/translate/sections/history_result_section.dart:20`  
**Widget:** `HistoryResultSection`

**Description:**  
Stored history entries are parsed with `jsonDecode(entry.resultJson) as Map<String, dynamic>` then passed to `TranslationResult.fromJson`. If the stored JSON is malformed or contains unexpected types, this throws a `FormatException` or `CheckedFromJsonException`, crashing the view (per "beta policy: no migrations").

**Code Location:** Line 20

**Impact:**  
Availability impact only — corrupted DB entries crash the detail view. No code execution.

**Remediation:**  
- Wrap parsing in try/catch; show "Corrupted entry" UI instead of crashing
- Add schema versioning to history entries for future migrations

---

### INFO: URL Parameter Handling — Safe by Design
**File:** `lib/app/router/app_router.g.dart:99`  
**Route:** `HistoryEntryRoute`

**Description:**  
The route parameter `id` is parsed via `int.parse(state.pathParameters['id']!)`. Invalid integers throw `FormatException` at route matching time, before widget build. No injection possible.

**Code Location:** Line 99

---

### INFO: Database Operations — Parameterized Queries
**File:** `lib/app/data/app_database.dart:58-78`  
**Methods:** `insertEntry`, `updateEntry`, `deleteEntry`

**Description:**  
Drift (SQLite) uses parameterized queries via `HistoryEntriesCompanion`. No string interpolation in SQL. SQL injection not possible.

---

## Flutter-Specific Rendering Analysis

| Widget / Pattern | Usage in Codebase | Risk |
|------------------|-------------------|------|
| `SelectableText` | Translation results, source text, thinking, errors, alternatives | **Safe** — plain text only |
| `Text` | History list items, labels, UI chrome | **Safe** — plain text only |
| `Text.rich` | Not used | N/A |
| `Html` widget (flutter_html) | Not used | N/A |
| Custom renderers | Not used | N/A |
| `dangerouslySetInnerHTML` equivalent | Not used | N/A |
| `innerHTML` via `dart:html` | Not used | N/A |

---

## Data Flow Summary

```
User Input (TextField)
    → translate() in translation_jobs_provider.dart
    → LlmSession.streamObject() (LLM SDK)
    → TranslationEvent.stream → TranslationResult
    → SelectableText (translation_result_section.dart)
    → Stored in Drift DB (parameterized)
    → HistoryResultSection → jsonDecode → TranslationResult.fromJson → SelectableText
```

**All render paths terminate in `SelectableText` or `Text` — no HTML interpretation.**

---

## Recommendations Priority Order

1. **HIGH PRIORITY:** Add `web/index.html` with strict CSP (Medium finding)
2. **MEDIUM PRIORITY:** Sanitize error messages in `_ErrorCard` (Low finding)
3. **LOW PRIORITY:** Add Unicode normalization/length limits on LLM responses (Low finding)
4. **LOW PRIORITY:** Graceful handling of corrupted history JSON (Low finding)

---

## Verification Checklist

- [ ] CSP header present in `build/web/index.html` after build
- [ ] Error messages don't leak stack traces or internal URLs
- [ ] LLM response length capped (e.g., 100KB per field)
- [ ] Corrupted history entries show friendly error, not crash
- [ ] `flutter build web` produces no console CSP violations

---

## Appendix: Files Audited

| File | Status |
|------|--------|
| `lib/app/pages/translate/sections/translation_result_section.dart` | ✅ Reviewed |
| `lib/app/pages/translate/sections/history_result_section.dart` | ✅ Reviewed |
| `lib/app/pages/translate/widgets/history_list.dart` | ✅ Reviewed |
| `lib/app/pages/settings/sections/gemini_config_section.dart` | ✅ Reviewed |
| `lib/app/pages/settings/sections/open_ai_config_section.dart` | ✅ Reviewed |
| `lib/app/pages/settings/sections/anthropic_config_section.dart` | ✅ Reviewed |
| `lib/app/pages/settings/sections/deep_seek_config_section.dart` | ✅ Reviewed |
| `lib/app/pages/settings/sections/open_ai_compatible_config_section.dart` | ✅ Reviewed |
| `lib/app/pages/settings/sections/acp_config_section.dart` | ✅ Reviewed |
| `lib/app/pages/settings/sections/codex_config_section.dart` | ✅ Reviewed |
| `lib/app/pages/settings/widgets/api_key_field.dart` | ✅ Reviewed |
| `lib/app/router/app_router.dart` / `.g.dart` / `app_route_paths.dart` | ✅ Reviewed |
| `lib/app/providers/*.dart` (history, translation_jobs, llm_config, secure_storage) | ✅ Reviewed |
| `lib/app/data/app_database.dart` | ✅ Reviewed |
| `web/index.html` | ⚠️ **MISSING** — generated by Flutter |