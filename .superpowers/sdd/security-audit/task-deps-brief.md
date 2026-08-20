# Task: Dependency Vulnerability Scan

## Context
Flutter/Dart project with many dependencies. Check for known CVEs, unmaintained packages, supply chain risks.

## Requirements
1. **Run `dart pub outdated --prereleases`** and check for vulnerable versions
2. **Check `flutter pub deps`** for transitive vulnerabilities
3. **Key packages**: `dio`, `drift`, `drift_flutter`, `sqlite3`, `freezed`, `riverpod`, `flutter_secure_storage`, `web`, `sse`
4. **GitHub Advisory Database** / `dart pub deps --style=compact` cross-ref with OSV
5. **Web-specific**: `web` package, `js` interop, WASM dependencies (`sqlite3.wasm` from drift releases)
6. **License/compliance** - GPL/AGPL contamination check

## Tools
- `dart pub outdated --mode=null-safety`
- `dart pub deps --style=compact`
- GitHub `Dependabot` alerts (if enabled)
- `osv-scanner` or `govulncheck` equivalent for Dart

## Deliverable
Report: `task-deps-report.md` with CVE table (package, current version, fixed version, severity, exploitability).