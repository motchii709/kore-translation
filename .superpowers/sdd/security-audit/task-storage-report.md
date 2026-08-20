# Secure Storage Implementation Security Audit Report

**Project**: kore-translation
**Date**: 2026-08-20
**Auditor**: Security Review

---

## Executive Summary

The secure storage implementation uses `flutter_secure_storage` v10.3.1 with platform-specific backends. **Critical finding**: The implementation is a minimal wrapper with **zero custom security controls** — no encryption key derivation, no key management, no audit logging, no access control, no brute-force protection. All security relies on OS-provided keystores.

---

## 1. Web Backend Review (`flutter_secure_storage_web`)

### Status: **NOT DEPLOYED / NOT CONFIGURED**

| Aspect | Finding |
|--------|---------|
| Package version | `flutter_secure_storage_web` v2.1.1 (transitive) |
| Web platform support | **No `web/` directory exists** — web not enabled |
| Implementation | Would use IndexedDB + Web Crypto (AES-GCM) |
| Key derivation | PBKDF2 (100k iterations) from user password + salt |
| Current risk | N/A — platform not built |

**Gap**: If web is added later, the default implementation stores encryption key in IndexedDB alongside ciphertext — **no password-based key derivation** unless explicitly configured via `WebOptions`.

---

## 2. Encryption Review

### Current State: **Platform Defaults Only**

| Platform | Backend | Encryption | Key Storage |
|----------|---------|------------|-------------|
| iOS | Keychain (kSecClassGenericPassword) | Hardware-backed (Secure Enclave) | iOS Keychain |
| Android | EncryptedSharedPreferences / Android Keystore | AES-256-GCM (API 23+) | Android Keystore (TEE/StrongBox) |
| macOS | **Legacy file-based keychain** (configured) | AES-256 | File-based `~/Library/Keychains/` |
| Linux | libsecret | AES-256 | Secret Service (gnome-keyring/kwallet) |
| Windows | DPAPI / Credential Manager | AES-256 | Windows Credential Manager |

### Critical Gaps

1. **No application-layer encryption** — Data encrypted only at rest by OS. No defense-in-depth if OS keystore compromised.
2. **No password-derived keys** — User password never used to derive encryption keys. Anyone with device access = data access.
3. **macOS uses legacy keychain** — `usesDataProtectionKeychain: false` disables modern Data Protection. File-based keychain is less secure (no hardware binding).
4. **No algorithm agility** — Hardcoded to platform defaults. Cannot rotate to post-quantum algorithms.

---

## 3. Key Management

### Status: **NONE IMPLEMENTED**

| Requirement | Implemented? | Notes |
|-------------|--------------|-------|
| Master key storage | ❌ | Delegated entirely to OS |
| Key rotation | ❌ | No mechanism exists |
| Key backup/recovery | ❌ | No export/import functionality |
| Key hierarchy | ❌ | Single namespace, no key separation |
| Key destruction | ❌ | Only `deleteAll()` available |

**Risk**: If user loses device/uninstalls app, **all secrets irrecoverable**. No paper key, no social recovery, no cloud backup option.

---

## 4. Access Control

### Status: **NONE IMPLEMENTED**

| Requirement | Implemented? | Notes |
|-------------|--------------|-------|
| Per-key isolation | ❌ | All keys in single namespace |
| Namespace separation | ❌ | No `iOptions`, `aOptions` for grouping |
| Role-based access | ❌ | Not applicable (single-user app) |
| Key labeling/metadata | ❌ | No key metadata stored |

**Current code** (`secure_storage_provider.dart:8-13`):
```dart
const FlutterSecureStorage(
  mOptions: MacOsOptions(usesDataProtectionKeychain: false),
);
```
Only macOS option configured. No Android `KeyGenParameterSpec`, no iOS `accessControl`, no Linux `Schema`.

---

## 5. Audit Logging

### Status: **NONE IMPLEMENTED**

| Event | Logged? |
|-------|---------|
| Read access | ❌ |
| Write access | ❌ |
| Delete access | ❌ |
| Failed decryption | ❌ |
| Failed authentication | ❌ |
| Key rotation | ❌ |

**Gap**: Zero visibility into who/what accesses secrets. No SIEM integration possible. No forensic trail.

---

## 6. Lockout / Brute Force Protection

### Status: **NONE IMPLEMENTED**

| Mechanism | Implemented? |
|-----------|--------------|
| Failed attempt counter | ❌ |
| Exponential backoff | ❌ |
| Account lockout | ❌ |
| Secure element rate limiting | ⚠️ OS-dependent only |

**Note**: Android Keystore / iOS Secure Enclave provide hardware rate limiting for *key operations*, but **not for application-level auth attempts**. An attacker with app access can call `read()`/`write()` unlimited times.

---

## Platform Difference Summary

| Feature | iOS | Android | macOS | Linux | Windows | Web* |
|---------|-----|---------|-------|-------|---------|------|
| Hardware-backed keys | ✅ (SE) | ✅ (TEE/StrongBox) | ❌ (legacy) | ❌ | ✅ (TPM) | ❌ |
| Biometric gating | ✅ (LAContext) | ✅ (BiometricPrompt) | ✅ (Touch ID) | ❌ | ✅ (Windows Hello) | ❌ |
| Keychain sync (iCloud) | ✅ Configurable | ❌ | ✅ Configurable | ❌ | ❌ | ❌ |
| Data Protection class | ✅ | N/A | ❌ Disabled | N/A | N/A | N/A |
| EncryptedSharedPreferences | N/A | ✅ (API 23+) | N/A | N/A | N/A | N/A |

*Web not currently built

---

## Risk Assessment

| Risk | Likelihood | Impact | Severity |
|------|------------|--------|----------|
| Device theft → secret extraction | Medium | High | **HIGH** |
| Malicious app reads shared storage | Low (sandboxed) | High | MEDIUM |
| Backup/restore leaks secrets | Medium | Medium | MEDIUM |
| No key rotation → long-term exposure | High | Medium | **HIGH** |
| No audit trail → undetected breach | High | High | **HIGH** |
| macOS legacy keychain weaker protection | Medium | Medium | MEDIUM |

---

## Recommendations (Priority Order)

### P0 — Critical (Do Immediately)
1. **Enable macOS Data Protection Keychain** — Remove `usesDataProtectionKeychain: false` or add proper entitlements
2. **Add application-layer encryption** — Encrypt sensitive values (API keys) with user password-derived key (PBKDF2/Argon2) before storing
3. **Implement key rotation policy** — Annual rotation with re-encryption of stored values

### P1 — High (Next Sprint)
4. **Add audit logging** — Wrap `FlutterSecureStorage` to log all access (success/failure) with timestamps
5. **Implement namespace separation** — Use `AndroidOptions(encryptedSharedPreferences: true, sharedPreferencesName: 'namespace')` and iOS `accessGroup`
6. **Add failed attempt throttling** — In-memory counter with exponential backoff + persistent lockout flag

### P2 — Medium (Planned)
7. **Key backup/recovery** — Implement encrypted export (user password) + paper key QR code
8. **Web platform hardening** — If web added: configure `WebOptions(dbName, encryptionKey)` with password-derived key
9. **Linux hardening** — Require libsecret with `Schema` for attribute-based access control

### P3 — Low (Future)
10. **Biometric gating** — Require FaceID/TouchID/Windows Hello for sensitive key access
11. **Post-quantum readiness** — Abstract crypto layer for future algorithm migration

---

## Compliance Notes

| Standard | Current Status |
|----------|----------------|
| SOC 2 Type II (CC6.1) | ❌ No audit logging |
| GDPR Art. 32 (encryption) | ⚠️ OS-only, no app-layer |
| NIST 800-53 (SC-28) | ⚠️ Partial (OS keystore) |
| OWASP MASVS (MSTG-STORAGE-1/2) | ❌ Fail — no additional encryption |

---

## Files Reviewed

- `lib/app/providers/secure_storage_provider.dart` — Only provider, minimal config
- `pubspec.yaml` — `flutter_secure_storage: ^10.3.1`
- `pubspec.lock` — Resolved versions for all platforms
- Platform configs: `ios/Runner/Info.plist`, `android/app/src/main/AndroidManifest.xml`, `macos/Runner/Info.plist`
- No web platform directory found

---

## Conclusion

**The secure storage implementation provides baseline OS-level protection only.** It meets minimum platform expectations but **fails to implement any application-level security controls** required for sensitive data (API keys, tokens, PII). Immediate action needed on P0 items before storing production credentials.