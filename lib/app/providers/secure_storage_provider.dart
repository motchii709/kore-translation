import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage_provider.g.dart';

@riverpod
FlutterSecureStorage secureStorage(Ref ref) {
  return const FlutterSecureStorage(
    // The data protection keychain requires a keychain-access-groups
    // entitlement, which needs a development certificate; the app is ad-hoc
    // signed, so use the legacy file-based keychain instead.
    mOptions: MacOsOptions(usesDataProtectionKeychain: false),
  );
}
