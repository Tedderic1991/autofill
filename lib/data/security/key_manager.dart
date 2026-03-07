// Key management for the encrypted Drift database.
//
// SEC-04: Generates and persists a cryptographically random 32-byte key in
// Android Keystore via flutter_secure_storage. The key is base64url-encoded
// and passed as a passphrase to the Drift NativeDatabase PRAGMA key callback.
//
// Source: drift.simonbinder.eu/platforms/encryption/
//        pub.dev/packages/flutter_secure_storage
import 'dart:convert';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Manages the encryption key for the Drift SQLite database.
///
/// The key is a base64url-encoded 32-byte random value stored in Android
/// Keystore via [FlutterSecureStorage]. On first launch, the key is generated
/// using [Random.secure()] (cryptographically random). On subsequent launches,
/// the stored key is returned unchanged.
///
/// On reinstall, the Keystore entry is wiped. [hasKey] returns false and
/// [getOrCreateKey] generates a fresh key, resulting in a new empty database.
/// This is the correct behavior — the old encrypted DB file is unreadable
/// without the original key.
class KeyManager {
  static const _keyAlias = 'autofill_db_key_v1';
  final FlutterSecureStorage _storage;

  const KeyManager(this._storage);

  /// Returns the existing database key, or generates and stores a new one.
  ///
  /// The returned string is a base64url encoding of 32 cryptographically
  /// random bytes, suitable for use as a SQLite PRAGMA key passphrase.
  ///
  /// This method is idempotent: calling it multiple times returns the same
  /// key as long as the Keystore entry exists.
  Future<String> getOrCreateKey() async {
    final existing = await _storage.read(key: _keyAlias);
    if (existing != null) return existing;

    // Generate 32 cryptographically random bytes.
    // MUST use Random.secure() — Random() is NOT cryptographically secure.
    final random = Random.secure();
    final keyBytes = List<int>.generate(32, (_) => random.nextInt(256));
    final key = base64UrlEncode(keyBytes);
    await _storage.write(key: _keyAlias, value: key);
    return key;
  }

  /// Returns true iff the database key exists in secure storage.
  ///
  /// Returns false on first launch and after reinstall (Keystore is cleared).
  Future<bool> hasKey() async {
    return (await _storage.read(key: _keyAlias)) != null;
  }
}
