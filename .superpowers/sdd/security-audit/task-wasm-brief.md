# Task: WebAssembly / Drift SQLite Security

## Context
Uses `drift_flutter` with `sqlite3.wasm` and `drift_worker.js` downloaded from drift GitHub releases. Runs SQLite in browser via WASM.

## Requirements
1. **WASM integrity** - verify `sqlite3.wasm` and `drift_worker.js` hashes match drift releases (subresource integrity)
2. **Worker isolation** - `drift_worker.js` runs in dedicated Web Worker, check `worker-src` CSP
3. **Memory safety** - WASM memory limits, OOM handling, no unbounded allocations
4. **OPFS/IndexedDB** - database storage permissions, data isolation, clear on logout
5. **WASM compilation** - `--no-wasm-dry-run` flag in production build, AOT vs JIT
6. **Supply chain** - `sqlite3.wasm` from `https://github.com/simolus3/drift/releases/download/drift-2.34.3/sqlite3.wasm` - verify no tampering

## Files to audit
- `.github/workflows/pages_deploy.yml` (download step)
- `lib/app/providers/app_database_provider.dart` (`DriftWebOptions` config)
- `web/` folder for downloaded files

## Deliverable
Report: `task-wasm-report.md` with integrity verification, worker isolation, memory limits, supply chain recommendations.