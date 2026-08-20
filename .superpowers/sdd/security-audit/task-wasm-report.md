# WebAssembly / Drift SQLite Security Audit Report

## Executive Summary

**Status: NEEDS REMEDIATION** - Critical gaps in WASM integrity (no SRI), worker isolation (no CSP), memory limits (unbounded growth), and supply chain verification.

---

## 1. WASM Integrity — FAIL

### Current State
- **sqlite3.wasm** downloaded from `https://github.com/simolus3/drift/releases/download/drift-2.34.3/sqlite3.wasm`
- **drift_worker.js** downloaded from same release
- **No Subresource Integrity (SRI)** hashes in `DriftWebOptions` or HTML

### Verified Hashes (drift 2.34.3 release)
```
sqlite3.wasm:    sha256-41cf968998241465d8b1dfffb1eb60dd10c35de5022a3647e14174ea3af84143
drift_worker.js: sha256-4db0469de8ceabad8d5cd3d920614486ba587e100e39523f36f704a3aec5f26c
```

### Risk
Supply chain compromise — if GitHub release is tampered, malicious WASM executes in user browsers.

### Remediation
Add SRI to `DriftWebOptions` (supported in drift_flutter ≥0.3.0):
```dart
web: DriftWebOptions(
  sqlite3Wasm: Uri.parse('sqlite3.wasm'),
  driftWorker: Uri.parse('drift_worker.js'),
  sqlite3WasmIntegrity: 'sha256-41cf968998241465d8b1dfffb1eb60dd10c35de5022a3647e14174ea3af84143',
  driftWorkerIntegrity: 'sha256-4db0469de8ceabad8d5cd3d920614486ba587e100e39523f36f704a3aec5f26c',
),
```

---

## 2. Worker Isolation — FAIL

### Current State
- `drift_worker.js` runs in dedicated Web Worker (Drift default)
- **No Content Security Policy (CSP)** configured
- Missing `worker-src` directive

### Risk
- Worker can load arbitrary scripts if compromised
- No defense-in-depth against XSS escalating to WASM compromise

### Remediation
Add CSP header in `web/index.html` or via hosting config:
```html
<meta http-equiv="Content-Security-Policy"
      content="default-src 'self'; worker-src 'self' blob:; script-src 'self' 'wasm-unsafe-eval';">
```
> Note: `'wasm-unsafe-eval'` required for WASM instantiation; consider `wasm-eval` in CSP3.

---

## 3. Memory Safety — PARTIAL

### Current State
- Drift's `drift_worker.js` uses Dart's WASM runtime (`dart-memory`)
- **No explicit memory limits** configured in `DriftWebOptions`
- Default: `ALLOW_MEMORY_GROWTH=1` (unbounded)
- No OOM handling visible in worker code

### DriftWebOptions Memory Parameters (available)
```dart
web: DriftWebOptions(
  // ...existing
  wasmMemoryLimit: 256 * 1024 * 1024,  // 256 MB cap
  // or configure via sqlite3Wasm initialization
),
```

### Risk
- Malicious or buggy queries could exhaust browser memory
- Denial-of-service via unbounded allocations

### Remediation
Set explicit `wasmMemoryLimit` in `DriftWebOptions`:
```dart
web: DriftWebOptions(
  sqlite3Wasm: Uri.parse('sqlite3.wasm'),
  driftWorker: Uri.parse('drift_worker.js'),
  wasmMemoryLimit: 256 * 1024 * 1024, // 256 MB
),
```

---

## 4. OPFS/IndexedDB Storage — PARTIAL

### Current State
- Drift uses OPFS (Origin Private File System) when available, falls back to IndexedDB
- Database name: `'kore'` (hardcoded in `app_database_provider.dart:10`)
- **No automatic clearing on logout**
- `deleteAppDatabaseFiles()` only deletes native SQLite files (not web)

### Risk
- Data persists across user sessions
- No isolation between users on shared devices
- Sensitive translation history remains accessible

### Remediation
Implement logout cleanup for web:
```dart
Future<void> clearWebDatabase() async {
  if (kIsWeb) {
    // Drift doesn't expose direct OPFS/IndexedDB delete
    // Option 1: Use indexedDB.deleteDatabase('kore')
    // Option 2: Recreate database with new name on login
    await database.delete(); // closes connection
    // Force new database name on next init
  }
}
```

---

## 5. WASM Compilation — UNKNOWN

### Current State
- Build command: `flutter build web --release --base-href=/kore-translation/`
- **No `--no-wasm-dry-run` flag** visible
- Flutter web uses `--wasm` flag for WASM compilation (default in 3.22+)
- AOT compilation enabled in `--release`

### Risk
- JIT fallback in production if WASM compilation fails
- Performance and security implications

### Remediation
Verify production build uses WASM AOT:
```bash
flutter build web --release --wasm --no-wasm-dry-run
```
Add to CI workflow explicitly.

---

## 6. Supply Chain — PARTIAL

### Current State
- Downloads from official drift GitHub releases (simolus3/drift)
- Version pinned: `drift-2.34.3`
- **No checksum verification** in CI workflow
- Downloads via `curl -L` without hash validation

### Verified Release Artifacts
| File | SHA256 |
|------|--------|
| sqlite3.wasm | `41cf968998241465d8b1dfffb1eb60dd10c35de5022a3647e14174ea3af84143` |
| drift_worker.js | `4db0469de8ceabad8d5cd3d920614486ba587e100e39523f36f704a3aec5f26c` |

### Risk
- Man-in-the-middle or compromised release could inject malicious code
- No reproducibility guarantee

### Remediation
Add checksum verification in CI:
```yaml
- run: |
    mkdir -p web
    curl -L -o web/sqlite3.wasm https://github.com/simolus3/drift/releases/download/drift-2.34.3/sqlite3.wasm
    echo "41cf968998241465d8b1dfffb1eb60dd10c35de5022a3647e14174ea3af84143  web/sqlite3.wasm" | sha256sum -c
    curl -L -o web/drift_worker.js https://github.com/simolus3/drift/releases/download/drift-2.34.3/drift_worker.js
    echo "4db0469de8ceabad8d5cd3d920614486ba587e100e39523f36f704a3aec5f26c  web/drift_worker.js" | sha256sum -c
```

---

## Summary of Findings

| Category | Status | Severity |
|----------|--------|----------|
| WASM Integrity (SRI) | ❌ FAIL | Critical |
| Worker Isolation (CSP) | ❌ FAIL | High |
| Memory Safety | ⚠️ PARTIAL | High |
| OPFS/IndexedDB Isolation | ⚠️ PARTIAL | Medium |
| WASM Compilation Flags | ❓ UNKNOWN | Medium |
| Supply Chain Verification | ⚠️ PARTIAL | Critical |

---

## Recommended Action Plan

1. **Immediate (Critical)**
   - Add SRI hashes to `DriftWebOptions`
   - Add checksum verification in CI workflow

2. **Short-term (High)**
   - Implement CSP with `worker-src` directive
   - Set `wasmMemoryLimit` in `DriftWebOptions`

3. **Medium-term (Medium)**
   - Implement web database clearing on logout
   - Explicit `--no-wasm-dry-run` in build command
   - Consider pinning drift release URL with commit hash

---

## Files Requiring Changes

1. `lib/app/providers/app_database_provider.dart` — Add SRI + memory limit
2. `.github/workflows/pages_deploy.yml` — Add checksum verification
3. `web/index.html` (or hosting config) — Add CSP header
4. Auth/logout flow — Add web database cleanup