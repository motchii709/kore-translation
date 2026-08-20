# Task: Content Security Policy & Security Headers

## Context
Flutter web app on GitHub Pages. Need proper CSP to mitigate XSS, control resource loading.

## Requirements
1. **Current CSP** - check `web/index.html` for `<meta http-equiv="Content-Security-Policy">`
2. **Required directives**:
   - `default-src 'self'`
   - `script-src 'self' 'wasm-unsafe-eval'` (Flutter needs WASM eval)
   - `style-src 'self' 'unsafe-inline'` (Flutter inline styles)
   - `worker-src 'self' blob:` (Web Workers for drift)
   - `connect-src 'self' https://api.openai.com https://api.anthropic.com https://generativelanguage.googleapis.com https://api.groq.com https://api.mistral.ai https://api.deepseek.com` (LLM APIs)
   - `font-src 'self' data:`
   - `img-src 'self' data: blob:`
   - `frame-ancestors 'none'`
   - `base-uri 'self'`
   - `form-action 'none'`
3. **Headers** - `X-Content-Type-Options: nosniff`, `X-Frame-Options: DENY`, `Referrer-Policy: strict-origin-when-cross-origin`
4. **GitHub Pages** - check if headers can be set via `_headers` file or only meta tags
5. **Flutter bootstrap** - `flutter_bootstrap.js` loading, `flutter.js` integrity

## Files to audit
- `web/index.html`
- `web/manifest.json`
- Build output `build/web/` headers

## Deliverable
Report: `task-csp-report.md` with recommended CSP, missing headers, GitHub Pages limitations.