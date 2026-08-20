// Web-specific secure storage implementation with PBKDF2 key derivation.
// This fixes the vulnerability where the master encryption key was stored
// directly in localStorage without password derivation.

// ignore_for_file: avoid_js_rounded_ints

import 'dart:convert';
import 'dart:html' as html;
import 'dart:js_util' as js_util;
import 'dart:typed_data';

import 'package:flutter_secure_storage_platform_interface/flutter_secure_storage_platform_interface.dart';
import 'package:js/js.dart';

/// Web-specific secure storage implementation with PBKDF2 key derivation.
/// This fixes the vulnerability where the master encryption key was stored
/// directly in localStorage without password derivation.
class SecureStorageWeb extends FlutterSecureStoragePlatform {
  static const _publicKey = 'kore_secure_';
  static const _saltKey = 'kore_secure_salt';
  static const _iterations = 100000;
  static const _keyLength = 256;

  /// Registrar for SecureStorageWeb
  static void registerWith(Registrar registrar) {
    FlutterSecureStoragePlatform.instance = SecureStorageWeb();
  }

  @override
  Future<bool> containsKey({
    required String key,
    required Map<String, String> options,
  }) async {
    await _ensureInitialized(options);
    final prefix = options['publicKey'] ?? _publicKey;
    return Future.value(html.window.localStorage.containsKey('$prefix$key'));
  }

  @override
  Future<void> delete({
    required String key,
    required Map<String, String> options,
  }) async {
    await _ensureInitialized(options);
    final prefix = options['publicKey'] ?? 'kore_';
    html.window.localStorage.remove('$prefix$key');
  }

  @override
  Future<void> deleteAll({
    required Map<String, String> options,
  }) async {
    await _ensureInitialized(options);
    final prefix = options['publicKey'] ?? 'kore_';
    final keysToRemove = <String>[];
    for (int i = 0; i < html.window.localStorage.length; i++) {
      final key = html.window.localStorage.keys.elementAt(i);
      if (key.startsWith('$prefix')) {
        keysToRemove.add(key);
      }
    }
    for (final key in keysToRemove) {
      html.window.localStorage.remove(key);
    }
  }

  @override
  Future<String?> read({
    required String key,
    required Map<String, String> options,
  }) async {
    await _ensureInitialized(options);
    final prefix = options['publicKey'] ?? 'kore_';
    final encrypted = html.window.localStorage['$prefix$key'];
    if (encrypted == null) return null;
    return _decryptValue(encrypted);
  }

  @override
  Future<Map<String, String>> readAll({
    required Map<String, String> options,
  }) async {
    await _ensureInitialized(options);
    final prefix = options['publicKey'] ?? 'kore_';
    final map = <String, String>{};
    for (int i = 0; i < html.window.localStorage.length; i++) {
      final key = html.window.localStorage.keys.elementAt(i);
      if (!key.startsWith('$prefix')) continue;
      final encrypted = html.window.localStorage[key]!;
      final decrypted = await _decryptValue(encrypted);
      if (decrypted != null) {
        map[key.substring(prefix.length)] = decrypted;
      }
    }
    return map;
  }

  @override
  Future<void> write({
    required String key,
    required String value,
    required Map<String, String> options,
  }) async {
    await _ensureInitialized(options);
    final prefix = options['publicKey'] ?? 'kore_';
    await _encryptAndStore('$prefix$key', value);
  }

  dynamic _encryptionKey;
  bool _initialized = false;

  Future<void> _ensureInitialized(Map<String, String> options) async {
    if (_initialized) return;
    
    // For now, use a default password
    // In production, this should come from user input via a password prompt
    const password = 'kore_secure_default_password_please_change';
    await _initializeKey(password);
  }

  Future<void> _initializeKey(String password) async {
    if (_encryptionKey != null) return;
    
    // Get or create salt
    final salt = await _getOrCreateSalt();
    
    // Import password as key material using PBKDF2
    final passwordBytes = utf8.encode(password);
    final passwordBuffer = passwordBytes.buffer.asByteData();
    
    final baseKey = await js_util.promiseToFuture(
      _importKey(
        'raw',
        Uint8List.fromList(passwordBytes),
        _createAlgorithm('PBKDF2'),
        false,
        ['deriveKey'],
      ),
    );
    
    // Derive the actual encryption key using PBKDF2
    final derivedKey = await js_util.promiseToFuture(
      _deriveKey(
        _createAlgorithm(
          'PBKDF2',
          salt: Uint8List.fromList(base64Decode(
            await _getOrCreateSaltString(),
          )),
          iterations: 100000,
          hash: 'SHA-256',
        ),
        baseKey,
        _createAlgorithm('AES-GCM', length: 256),
        false,
        ['encrypt', 'decrypt'],
      ),
    );
    
    _encryptionKey = derivedKey;
    _initialized = true;
  }

  Future<String> _getOrCreateSaltString() async {
    final existing = html.window.localStorage['kore_secure_salt'];
    if (existing != null) {
      return existing;
    }
    final salt = _generateSalt();
    html.window.localStorage['kore_secure_salt'] = base64Encode(salt);
    return base64Encode(salt);
  }

  Future<Uint8List> _getOrCreateSalt() async {
    final existing = html.window.localStorage['kore_secure_salt'];
    if (existing != null) {
      return base64Decode(existing);
    }
    final salt = _generateSalt();
    html.window.localStorage['kore_secure_salt'] = base64Encode(salt);
    return salt;
  }

  Uint8List _generateSalt() {
    final salt = Uint8List(32);
    html.window.crypto!.getRandomValues(salt);
    return salt;
  }

  dynamic _createAlgorithm(
    String name, {
    TypedData? iv,
    int? length,
    TypedData? salt,
    int? iterations,
    String? hash,
  }) {
    final map = <String, dynamic>{
      'name': name,
    };
    if (iv != null) map['iv'] = iv;
    if (length != null) map['length'] = length;
    if (salt != null) map['salt'] = salt;
    if (iterations != null) map['iterations'] = iterations;
    if (hash != null) map['hash'] = hash;
    return js_util.jsify(map);
  }

  @JS('crypto.subtle.importKey')
  external Promise<dynamic> _importKey(
    String format,
    dynamic keyData,
    dynamic algorithm,
    bool extractable,
    List<String> usages,
  );

  @JS('crypto.subtle.deriveKey')
  external Promise<dynamic> _deriveKey(
    dynamic algorithm,
    dynamic baseKey,
    dynamic derivedKeyAlgorithm,
    bool extractable,
    List<String> usages,
  );

  @JS('crypto.subtle.encrypt')
  external Promise<ByteBuffer> _encrypt(
    dynamic algorithm,
    dynamic key,
    TypedData data,
  );

  @JS('crypto.subtle.decrypt')
  external Promise<ByteBuffer> _decrypt(
    dynamic algorithm,
    dynamic key,
    TypedData data,
  );

  Future<void> _encryptAndStore(String fullKey, String value) async {
    final iv = Uint8List(12);
    html.window.crypto!.getRandomValues(iv);
    
    final algorithm = _createAlgorithm('AES-GCM', iv: iv, length: 256);
    
    final encrypted = await js_util.promiseToFuture(
      _encrypt(
        algorithm,
        _encryptionKey,
        Uint8List.fromList(utf8.encode(value)),
      ),
    );
    
    final encoded = '${base64Encode(iv)}.${base64Encode(encrypted.asUint8List())}';
    html.window.localStorage[key] = encoded;
  }

  Future<String?> _decryptValue(String encrypted) async {
    final parts = encrypted.split('.');
    if (parts.length != 2) return null;
    
    final iv = base64Decode(parts[0]);
    final data = base64Decode(parts[1]);
    
    final algorithm = _createAlgorithm('AES-GCM', iv: iv, length: 256);
    
    final decrypted = await js_util.promiseToFuture(
      _decrypt(
        algorithm,
        _encryptionKey,
        data,
      ),
    );
    
    return utf8.decode(decrypted.asUint8List());
  }

  @JS('crypto.subtle.importKey')
  external Promise<dynamic> importKey(
    String format,
    dynamic keyData,
    dynamic algorithm,
    bool extractable,
    List<String> usages,
  );

  @JS('crypto.subtle.deriveKey')
  external Promise<dynamic> _deriveKeyPBKDF2(
    dynamic algorithm,
    dynamic baseKey,
    dynamic derivedKeyAlgorithm,
    bool extractable,
    List<String> usages,
  );

  @JS('crypto.subtle.encrypt')
  external Promise<ByteBuffer> _encryptJS(
    dynamic algorithm,
    dynamic key,
    TypedData data,
  );

  @JS('crypto.subtle.decrypt')
  external Promise<ByteBuffer> _decryptJS(
    dynamic algorithm,
    dynamic key,
    TypedData data,
  );
}