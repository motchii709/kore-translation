import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'secure_storage_web.dart' if (dart.library.io) 'secure_storage_stub.dart';

part 'secure_storage_provider.g.dart';

@riverpod
FlutterSecureStorage secureStorage(Ref ref) {
  if (kIsWeb) {
    // On web, use the custom implementation with PBKDF2
    SecureStorageWeb.registerWith(null);
    return FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
      mOptions: MacOsOptions(usesDataProtectionKeychain: false),
    );
  }
  
  return const FlutterSecureStorage(
    mOptions: MacOsOptions(usesDataProtectionKeychain: false),
  );
}
