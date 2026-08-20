# Content Security Policy & Security Headers Audit Report

**Project:** kore-translation (Flutter web, GitHub Pages)
**Date:** 2026-08-20
**Auditor:** Security Audit

---

## Executive Summary

The Flutter web project currently **has no CSP or security headers**. The `web/` directory is generated at build time via `flutter create . --platforms web` in CI. The default Flutter template does not include a CSP meta tag. Required directives for Flutter WASM, drift workers, and LLM API connectivity are missing.

---

## 1. Current State Analysis

### web/index.html (generated at build time)
- **CSP meta tag:** ❌ NOT PRESENT (default template lacks CSP)
- **Security headers via meta tags:** ❌ NONE
- **flutter.js integrity:** ❌ NOT CONFIGURED
- **Bootstrap method:** Uses async `<script src="flutter_bootstrap.js">` (Flutter 3.22+)

### web/manifest.json (generated at build time)
- Standard PWA manifest, no CSP-related fields

### build/web/ (output)
- No `_headers` file (GitHub Pages doesn't support server headers)
- No CSP headers in HTTP responses

---

## 2. Required CSP Directives

Based on Flutter 3.44.8 (WASM renderer default), drift SQLite WASM worker, and LLM API requirements:

```html
<meta http-equiv="Content-Security-Policy" content="
  default-src 'self';
  script-src 'self' 'wasm-unsafe-eval' https://www.gstatic.com;
  style-src 'self' 'unsafe-inline';
  worker-src 'self' blob:;
  connect-src 'self'
    https://api.openai.com
    https://api.anthropic.com
    https://generativelanguage.googleapis.com
    https://api.groq.com
    https://api.mistral.ai
    https://api.deepseek.com;
  font-src 'self' data: https://fonts.gstatic.com;
  img-src 'self' data: blob:;
  frame-ancestors 'none';
  base-uri 'self';
  form-action 'none';
">
```

### Directive Justification

| Directive | Value | Reason |
|-----------|-------|--------|
| `default-src` | `'self'` | Baseline restrict all resources to same origin |
| `script-src` | `'self' 'wasm-unsafe-eval' https://www.gstatic.com` | Flutter WASM requires `wasm-unsafe-eval`; canvaskit loads from gstatic |
| `style-src` | `'self' 'unsafe-inline'` | Flutter inlines styles for canvas rendering |
| `worker-src` | `'self' blob:` | drift SQLite WASM worker (`drift_worker.js` creates blob worker) |
| `connect-src` | `'self' + 6 LLM APIs` | Direct API calls to OpenAI, Anthropic, Google, Groq, Mistral, DeepSeek |
| `font-src` | `'self' data: https://fonts.gstatic.com` | Flutter Material fonts from Google Fonts |
| `img-src` | `'self' data: blob:` | App images, data URIs, blob URLs |
| `frame-ancestors` | `'none'` | Prevent clickjacking |
| `base-uri` | `'self'` | Prevent base tag injection |
| `form-action` | `'none'` | No form submissions in this app |

---

## 3. Required Security Headers (Meta Tags)

Since GitHub Pages **only supports meta tags** (no server headers via `_headers` file):

```html
<!-- Prevent MIME sniffing -->
<meta http-equiv="X-Content-Type-Options" content="nosniff">

<!-- Prevent framing (clickjacking) -->
<meta http-equiv="X-Frame-Options" content="DENY">

<!-- Control referrer information -->
<meta name="referrer" content="strict-origin-when-cross-origin">
```

> **Note:** `X-Frame-Options` via meta tag is **not reliably supported** by all browsers. The CSP `frame-ancestors 'none'` directive is the modern replacement and **is supported via meta tag**.

---

## 4. GitHub Pages Limitations

| Feature | Supported? | Workaround |
|---------|------------|------------|
| HTTP Response Headers | ❌ No | Use `<meta http-equiv>` only |
| `_headers` file (Netlify/Cloudflare style) | ❌ No | Not processed by GitHub Pages |
| Custom domain with headers | ❌ No | Same limitation |
| CSP via meta tag | ✅ Yes | Full CSP 2/3 support |
| `frame-ancestors` via meta | ✅ Yes | Replaces X-Frame-Options |
| `X-Content-Type-Options` via meta | ✅ Yes | Supported |
| `Referrer-Policy` via meta | ✅ Yes | Use `<meta name="referrer">` |

**Critical:** The `flutter build web` output goes to `build/web/` which is uploaded as Pages artifact. No server-side header injection possible.

---

## 5. Flutter Bootstrap Integrity

### Current (default template)
```html
<script src="flutter_bootstrap.js" async></script>
```
- No integrity hash
- Loads `flutter.js` and `main.dart.js` dynamically

### Recommended: Subresource Integrity (SRI)
Generate SRI hashes at build time for:
- `flutter.js` (stable, from Flutter SDK)
- `main.dart.js` (changes every build - requires build-time injection)
- `flutter_bootstrap.js` (generated at build time)

**Implementation approach:**
1. Use `flutter build web --release --csp` (generates nonce-friendly bootstrap)
2. Post-process `build/web/index.html` to inject SRI hashes for static assets
3. For `main.dart.js`, use a build script to compute hash and inject

### Minimal viable fix (no SRI for dynamic files):
```html
<!-- flutter.js from CDN - stable, can add SRI -->
<script src="https://www.gstatic.com/flutter-js/3.44.8/flutter.js" 
        integrity="sha384-..." 
        crossorigin="anonymous" 
        defer></script>
<!-- main.dart.js - no SRI (changes per build) -->
```

---

## 6. Recommended web/index.html Template

Replace the generated `web/index.html` with this version (commit to repo so it persists across `flutter create`):

```html
<!DOCTYPE html>
<html lang="ja">
<head>
  <base href="/kore-translation/">

  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=Edge">
  <meta name="description" content="Kore翻訳 — LLM translation app">

  <!-- Security Headers (GitHub Pages: meta tags only) -->
  <meta http-equiv="Content-Security-Policy" content="
    default-src 'self';
    script-src 'self' 'wasm-unsafe-eval' https://www.gstatic.com;
    style-src 'self' 'unsafe-inline';
    worker-src 'self' blob:;
    connect-src 'self'
      https://api.openai.com
      https://api.anthropic.com
      https://generativelanguage.googleapis.com
      https://api.groq.com
      https://api.mistral.ai
      https://api.deepseek.com;
    font-src 'self' data: https://fonts.gstatic.com;
    img-src 'self' data: blob:;
    frame-ancestors 'none';
    base-uri 'self';
    form-action 'none';
  ">
  <meta http-equiv="X-Content-Type-Options" content="nosniff">
  <meta name="referrer" content="strict-origin-when-cross-origin">

  <!-- PWA -->
  <link rel="manifest" href="manifest.json">
  <meta name="theme-color" content="#0175C2">

  <!-- iOS -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="Kore翻訳">
  <link rel="apple-touch-icon" href="icons/Icon-192.png">

  <title>Kore翻訳</title>
  <link rel="icon" type="image/png" href="favicon.png"/>

  <!-- Flutter bootstrap (async, modern) -->
  <script src="flutter_bootstrap.js" async></script>
</head>
<body>
  <!-- App mounts here -->
</body>
</html>
```

---

## 7. Drift SQLite WASM Worker Files

The CI workflow downloads these to `web/`:
- `web/sqlite3.wasm` - WASM binary (loaded via `fetch` → blob URL)
- `web/drift_worker.js` - Worker script (creates `Blob` worker)

**CSP impact:** Requires `worker-src 'self' blob:` and `connect-src 'self'` for the WASM fetch.

---

## 8. Verification Checklist

| Check | Status | Command |
|-------|--------|---------|
| CSP meta tag present | ❌ | `grep -c "Content-Security-Policy" web/index.html` |
| `wasm-unsafe-eval` in script-src | ❌ | `grep "wasm-unsafe-eval" web/index.html` |
| LLM APIs in connect-src | ❌ | `grep "api.openai.com" web/index.html` |
| `worker-src blob:` | ❌ | `grep "blob:" web/index.html` |
| `X-Content-Type-Options` | ❌ | `grep "X-Content-Type-Options" web/index.html` |
| `frame-ancestors 'none'` | ❌ | `grep "frame-ancestors" web/index.html` |
| No inline scripts without nonce | ⚠️ | Check bootstrap script |

---

## 9. Action Items

1. **Create custom `web/index.html`** with CSP and security headers (commit to repo)
2. **Add `web/manifest.json`** with proper metadata (commit to repo)
3. **Update CI** to NOT run `flutter create . --platforms web` (use committed web/ dir)
4. **Test CSP** locally with `flutter build web --release --csp` and serve `build/web/`
5. **Verify LLM API calls work** under CSP in browser devtools Network tab
6. **Verify drift worker loads** (check Console for WASM worker errors)
7. **Consider SRI** for `flutter.js` from CDN (optional hardening)

---

## 10. References

- [Flutter Web CSP Guide](https://docs.flutter.dev/platform-integration/web/initialization#content-security-policy)
- [MDN: CSP script-src wasm-unsafe-eval](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy/script-src#unsafe_webassembly_execution)
- [GitHub Pages: Custom Headers](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-custom-domains-for-your-github-pages-site#configuring-custom-headers) — **Not supported**
- [Drift WASM Worker](https://drift.simonbinder.eu/docs/advanced-features/web/)