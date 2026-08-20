# Task: API Key Storage & Encryption Audit

## Context
API keys stored in localStorage with Web Crypto AES-GCM encryption. Keys: OpenAI, Anthropic, Google, Groq, Mistral, DeepSeek, etc.

## Requirements
Check for:
1. **Key derivation** - PBKDF2/Scrypt parameters, salt handling, iteration count
2. **Encryption** - AES-GCM nonce/IV generation (must be random, never reused), authentication tag verification
3. **Key storage** - master key protection, whether derived from user password or device-bound
4. **Memory handling** - keys cleared after use, no lingering in Dart heap
5. **Web Crypto API usage** - correct `subtle.encrypt/decrypt`, `importKey`, `deriveKey`
6. **Fallback/legacy** - old unencrypted keys migration, cleartext remnants

## Files to audit
- `lib/app/providers/secure_storage_provider.dart`
- `lib/app/providers/app_database_provider.dart` (if keys in DB)
- `lib/app/pages/settings/sections/*_config_section.dart` (save/load flow)

## Deliverable
Report: `task-crypto-report.md` with findings, crypto implementation review, attack scenarios (localStorage theft, XSS key extraction).