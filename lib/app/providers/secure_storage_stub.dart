// Stub implementation for non-web platforms.
// The actual implementation is in secure_storage_web.dart for web,
// and the default flutter_secure_storage is used for native platforms.

import 'package:flutter_secure_storage_platform_interface/flutter_secure_storage_platform_interface.dart';

/// Stub implementation for non-web platforms.
/// The actual implementation is in secure_storage_web.dart for web.
class SecureStorageWeb extends FlutterSecureStoragePlatform {
  @override
  Future<bool> containsKey({
    required String key,
    required Map<String, String> options,
  }) {
    throw UnsupportedError('Use flutter_secure_storage on native platforms');
  }

  @override
  Future<void> delete({
    required String key,
    required Map<String, String> options,
  }) {
    throw UnsupportedError('Use flutter_secure_storage on native platforms');
  }

  @override
  Future<void> deleteAll({
    required Map<String, String> options,
  }) {
    throw UnsupportedError('Use flutter_secure_storage on native platforms');
  }

  @override
  Future<String?> read({
    required String key,
    required Map<String, String> options,
  }) {
    throw UnsupportedError('Use flutter_secure_storage on native platforms');
  }

  @override
  Future<Map<String, String>> readAll({
    required Map<String, String> options,
  }) {
    throw UnsupportedError('Use flutter_secure_storage on native platforms');
  }

  @override
  Future<void> write({
    required String key,
    required String value,
    required Map<String, String> options,
  }) {
    throw UnsupportedError('Use flutter_secure_storage on native platforms');
  }
}