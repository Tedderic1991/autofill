// Drift AppDatabase — encrypted SQLite database for the autofill app.
//
// Encryption strategy:
// - sqlite3mc (SQLite3MultipleCiphers) is bundled by drift_flutter ^0.3.0
// - The NativeDatabase setup callback runs synchronously before any table
//   access; it verifies cipher is loaded and sets the PRAGMA key.
// - The passphrase comes from KeyManager (flutter_secure_storage + Keystore).
//
// Source: drift.simonbinder.eu/platforms/encryption/
//        drift.simonbinder.eu/dart_api/
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:sqlite3/sqlite3.dart';

import 'tables/custom_fields_table.dart';
import 'tables/profiles_table.dart';

// Drift generates _$AppDatabase into this file via build_runner.
part 'app_database.g.dart';

/// Opens an encrypted SQLite database file using SQLite3MultipleCiphers.
///
/// The [passphrase] should be the base64url-encoded 32-byte key returned by
/// [KeyManager.getOrCreateKey()]. It is passed to PRAGMA key before any
/// table access.
///
/// The setup callback asserts that `PRAGMA cipher;` returns a non-empty
/// result, which confirms that sqlite3mc (not plain sqlite3) is loaded.
/// This assertion runs in debug builds only — in release builds, a missing
/// cipher would silently open an unencrypted database.
///
/// Usage (via Riverpod in lib/providers/database_provider.dart):
/// ```dart
/// final passphrase = await KeyManager(secureStorage).getOrCreateKey();
/// final db = AppDatabase(openEncryptedDatabase(passphrase, dbFile));
/// ```
QueryExecutor openEncryptedDatabase(String passphrase, File dbFile) {
  return NativeDatabase.createInBackground(
    dbFile,
    setup: (rawDb) {
      // Verify SQLite3MultipleCiphers is loaded, not plain sqlite3.
      // If the hooks configuration in pubspec.yaml is incorrect, this
      // assertion will catch it at development time.
      assert(
        rawDb.select('PRAGMA cipher;').isNotEmpty,
        'SQLite3MultipleCiphers not loaded — encryption unavailable. '
        'Check the sqlite3mc hooks configuration in pubspec.yaml. '
        'See: drift.simonbinder.eu/platforms/encryption/',
      );

      // Escape single quotes in the passphrase to prevent SQL injection.
      // The base64url alphabet only contains A-Z, a-z, 0-9, -, _, =
      // so this escape is a safety measure, not a practical concern.
      final escaped = passphrase.replaceAll("'", "''");
      rawDb.execute("PRAGMA key = '$escaped';");
    },
  );
}

/// The main Drift database for the autofill app.
///
/// Contains [profiles] and [customFields] tables. Schema version 1.
///
/// Obtain an instance via the `appDatabaseProvider` Riverpod provider
/// (defined in lib/providers/database_provider.dart), which handles
/// key retrieval and file path resolution.
///
/// For tests, use [NativeDatabase.memory()] directly:
/// ```dart
/// final db = AppDatabase(NativeDatabase.memory());
/// ```
@DriftDatabase(tables: [Profiles, CustomFields])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
      );
}
