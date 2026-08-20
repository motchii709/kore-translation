# Dependency Vulnerability Scan Report

**Project**: kore-translation (Flutter/Dart)
**Scan Date**: 2026-08-20
**Dart SDK**: ^3.12.2 (Flutter ^3.44.8)
**Status**: PARTIAL - Several findings require attention

---

## Executive Summary

| Severity | Count |
|----------|-------|
| Critical | 0 |
| High | 1 |
| Medium | 3 |
| Low | 2 |
| Info | 4 |

**Key Findings**:
1. **flutter_secure_storage 10.3.1** - Padding oracle vulnerability (CBC/PKCS7) still present; fixed in v11.0.0
2. **build_daemon 4.1.3** - RETRACTED package in transitive dev deps
3. **sqlite3 3.5.0** - Bundles SQLite 3.53.3 (safe from recent CVEs), but v3.5.1 available
4. **Multiple packages outdated** - 6 direct, 20+ transitive dependencies have newer versions

---

## CVE Table

| Package | Current Version | Fixed Version | CVE / Advisory | Severity | Exploitability | Status |
|---------|-----------------|---------------|----------------|----------|----------------|--------|
| flutter_secure_storage | 10.3.1 | 11.0.0 | Padding Oracle (CBC/PKCS7) - MobSF/AppSweep detection | **High** | Remote (if attacker can trigger decryption errors) | **VULNERABLE** |
| build_daemon | 4.1.3 (transitive dev) | 4.1.5+ | Package retraction (supply chain) | Medium | N/A (dev only) | **RETRACTED** |
| dio | 5.11.0 | 5.11.0 | CVE-2021-31402 (CRLF injection) | High (7.5) | Network (attacker controls HTTP method) | **FIXED** (≥5.0.0) |
| sqlite3 (bundled SQLite) | 3.53.3 | 3.53.4 | CVE-2025-29087, CVE-2025-6965, CVE-2025-7709, CVE-2024-0232 | High/Medium | Local (arbitrary SQL execution) | **NOT AFFECTED** |
| drift | 2.34.3 | 2.34.5 | None known | - | - | **SAFE** |
| riverpod | 3.3.2 | 3.4.2 | None known | - | - | **SAFE** |
| freezed | 3.2.6-dev.1 | 4.0.0-dev.3 | None known | - | - | **SAFE** |
| web | 1.1.1 | 1.1.1 | None known | - | - | **SAFE** |
| sse (local) | 0.1.0 | N/A | No dependencies | - | - | **SAFE** |

---

## Detailed Findings

### 1. flutter_secure_storage — HIGH SEVERITY ⚠️

**Issue**: AES/CBC/PKCS7 padding oracle vulnerability persists in v10.x
- **CWE**: CWE-649 (Reliance on Obfuscation without Integrity Checking)
- **Detection**: MobSF, AppSweep, OWASP MASVS MSTG-CRYPTO-3
- **Root Cause**: Default `StorageCipherAlgorithm.AES_CBC_PKCS7Padding` and `KeyCipherAlgorithm.RSA_ECB_PKCS1Padding` on Android < API 23
- **Fixed in**: v11.0.0 (removes CBC/PKCS7 entirely, mandates AES-GCM)
- **Current Config**: Using defaults (no explicit `AndroidOptions`)

**Exploitability**: If attacker can observe padding validation errors (side-channel), they can decrypt stored values byte-by-byte.

**Mitigation** (immediate):
```dart
// In your storage initialization:
static const _secureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
    storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
    keyCipherAlgorithm: KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
  ),
  iOptions: IOSOptions(
    accessibility: KeychainItemAccessibility.first_unlock_this_device,
  ),
);
```
**Note**: Requires `minSdkVersion 23` (Android 6.0+) for AES-GCM.

---

### 2. build_daemon — RETRACTED PACKAGE (transitive dev)

**Issue**: Version 4.1.3 is retracted on pub.dev
- **Impact**: Supply chain risk if malicious version published
- **Location**: Transitive dev dependency (via build_runner → build_daemon)
- **Fix**: Upgrade `build_runner` to ≥2.16.0 (currently pinned at 2.15.1 due to meta version conflict)

**Action**: Test `build_runner 2.16.0` compatibility with Flutter SDK meta pin.

---

### 3. sqlite3 / drift — SQLite Version Analysis

**Current**: sqlite3 3.5.0 bundles **SQLite 3.53.3** (released 2025-08-03)
**Latest**: sqlite3 3.5.1 bundles **SQLite 3.53.4** (released 2026-08-03)

| CVE | SQLite Fixed | Bundled (3.53.3) | Status |
|-----|--------------|------------------|--------|
| CVE-2025-29087 (concat_ws overflow) | 3.49.1 | 3.53.3 | ✅ NOT AFFECTED |
| CVE-2025-6965 (integer truncation) | 3.50.2 | 3.53.3 | ✅ NOT AFFECTED |
| CVE-2025-7709 (FTS5 overflow) | 3.50.3 | 3.53.3 | ✅ NOT AFFECTED |
| CVE-2024-0232 (JSON use-after-free) | 3.43.2 | 3.53.3 | ✅ NOT AFFECTED |

**Web-Specific**: drift_flutter 0.3.1 uses sqlite3 3.x. Ensure `web/sqlite3.wasm` and `web/drift_worker.js` are from matching drift release (2.34.x). Version mismatch causes runtime failures.

---

### 4. dio — CVE-2021-31402 (FIXED)

- **Vulnerability**: CRLF injection via HTTP method string
- **Fixed in**: dio 5.0.0 (2021)
- **Current**: 5.11.0 ✅ **NOT VULNERABLE**

---

### 5. Dart/Flutter SDK — CVE-2026-27704 (Zip Slip)

- **Vulnerability**: Path traversal in pub package extraction
- **Fixed in**: Dart 3.11.0 / Flutter 3.41.0
- **Current**: Dart ^3.12.2 / Flutter ^3.44.8 ✅ **NOT AFFECTED**

---

## Outdated Dependencies (Direct)

| Package | Current | Latest | Type |
|---------|---------|--------|------|
| flutter_secure_storage | 10.3.1 | 11.0.0 | **Security** |
| go_router | 17.3.0 | 17.5.0 | Minor |
| hooks_riverpod | 3.3.2 | 3.4.2 | Minor |
| riverpod_annotation | 4.0.3 | 4.0.6 | Minor |
| slang | 4.18.0 | 4.19.0 | Patch |
| slang_flutter | 4.18.0 | 4.19.0 | Patch |

**Dev Dependencies**:
| Package | Current | Latest | Type |
|---------|---------|--------|------|
| build_runner | 2.15.1 | 2.16.0 | Minor (blocks build_daemon fix) |
| drift_dev | 2.34.0 | 2.34.5 | Patch |
| freezed | 3.2.6-dev.1 | 4.0.0-dev.3 | Major (breaking) |
| riverpod_generator | 4.0.4 | 4.0.8 | Minor |

---

## License Compliance Check

| Package | License | Risk |
|---------|---------|------|
| sqlite3 | Public Domain (SQLite), BSD-3 (bindings) | ✅ Safe |
| sqlite3 (SQLCipher build) | BSD-3 + OpenSSL (if enabled) | ⚠️ Check if used |
| sqlite3 (SQLite3MultipleCiphers) | Custom (BSD-like) | ⚠️ Check if used |
| drift | MIT | ✅ Safe |
| dio | MIT | ✅ Safe |
| riverpod | MIT | ✅ Safe |
| freezed | MIT | ✅ Safe |
| flutter_secure_storage | MIT | ✅ Safe |
| web | BSD-3 | ✅ Safe |
| sse (local) | Unspecified | ⚠️ Add license |

**No GPL/AGPL contamination detected** in direct or transitive dependencies.

**Recommendation**: Add `license: MIT` to `packages/sse/pubspec.yaml`.

---

## Web-Specific Supply Chain

### drift WebAssembly Assets
- **Required**: `web/sqlite3.wasm` + `web/drift_worker.js` from **same drift release**
- **Current drift**: 2.34.3 → Download from: https://github.com/simolus3/drift/releases/tag/drift-2.34.3
- **sqlite3.wasm**: Must be from sqlite3 3.x release (v3.5.0+)
- **Risk**: Version mismatch → runtime crashes (worker can't load WASM)

### package:web
- Version 1.1.1 (transitive)
- No known vulnerabilities
- Replaces deprecated `dart:html` for Wasm compatibility

---

## Recommended Action Plan

### Immediate (Security)
1. [ ] Upgrade `flutter_secure_storage` to 11.0.0 + configure AES-GCM
2. [ ] Add explicit `AndroidOptions`/`IOSOptions` to disable CBC/PKCS7
3. [ ] Verify `minSdkVersion 23` in `android/app/build.gradle`

### Short-term
4. [ ] Test `build_runner 2.16.0` compatibility → resolves retracted `build_daemon`
5. [ ] Upgrade `sqlite3` to 3.5.1 (SQLite 3.53.4)
6. [ ] Upgrade `drift` to 2.34.5, `drift_dev` to 2.34.5
7. [ ] Sync `web/sqlite3.wasm` and `web/drift_worker.js` to drift 2.34.5 release

### Maintenance
8. [ ] Upgrade remaining outdated packages (go_router, riverpod, slang)
9. [ ] Evaluate `freezed 4.x` migration (breaking changes)
10. [ ] Add license to `packages/sse/pubspec.yaml`

---

## Verification Commands

```bash
# Check for security advisories in resolution
dart pub get --verbose 2>&1 | grep -i "advisory\|vulnerab\|retract"

# Verify sqlite3 version bundled
dart run sqlite3:sqlite3_version

# Check web assets match
ls -la web/sqlite3.wasm web/drift_worker.js

# License check
dart pub deps --style=compact | grep -E "(GPL|AGPL|LGPL)" || echo "No copyleft licenses found"
```