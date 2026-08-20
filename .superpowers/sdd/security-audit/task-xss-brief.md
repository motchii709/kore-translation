# Task: XSS/Injection Vulnerability Audit

## Context
Flutter web app deployed to GitHub Pages. Attack surface: user inputs (translation text, API keys, settings), URL parameters, localStorage data.

## Requirements
Check for:
1. **XSS vectors** - user-controlled data rendered without sanitization (translation results, history entries, error messages)
2. **HTML/JS injection** - `innerHTML` usage, `dangerouslySetInnerHTML` equivalents in Flutter
3. **URL parameter handling** - base-href, deep links, query params used in UI
4. **localStorage/sessionStorage** - data read and rendered without validation
5. **Flutter-specific** - `SelectableText`, `Text.rich`, `Html` widget usage, custom renderers

## Files to audit
- `lib/app/pages/translate/sections/translation_result_section.dart` (results rendering)
- `lib/app/pages/translate/sections/history_result_section.dart`
- `lib/app/pages/translate/widgets/history_list.dart`
- `lib/app/pages/settings/sections/*_config_section.dart` (API key inputs)
- `web/index.html` (CSP, meta tags)

## Deliverable
Report file: `task-xss-report.md` with findings (Critical/High/Medium/Low), code locations, PoC if possible.