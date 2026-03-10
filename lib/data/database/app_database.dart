// Drift AppDatabase — encrypted SQLite database for the autofill app.
//
// Encryption strategy:
// - SQLCipher is provided by sqlcipher_flutter_libs.
// - The NativeDatabase setup callback runs synchronously before any table
//   access; it verifies SQLCipher is loaded and sets the PRAGMA key.
// - The passphrase comes from KeyManager (flutter_secure_storage + Keystore).
// - SQLCipher is initialised once in main.dart via open.overrideFor.
//
// Source: drift.simonbinder.eu/platforms/encryption/
//        drift.simonbinder.eu/dart_api/
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'daos/custom_fields_dao.dart';
import 'daos/profiles_dao.dart';
import 'tables/custom_fields_table.dart';
import 'tables/profiles_table.dart';

// Drift generates _$AppDatabase into this file via build_runner.
part 'app_database.g.dart';

/// Opens an encrypted SQLite database file using SQLCipher.
///
/// The [passphrase] should be the base64url-encoded 32-byte key returned by
/// [KeyManager.getOrCreateKey()]. It is passed to PRAGMA key before any
/// table access.
///
/// The setup callback asserts that `PRAGMA cipher_version;` returns a
/// non-empty result, confirming that SQLCipher (not plain sqlite3) is loaded.
/// This assertion runs in debug builds only.
///
/// Usage (via Riverpod in lib/providers/database_provider.dart):
/// ```dart
/// final passphrase = await KeyManager(secureStorage).getOrCreateKey();
/// final db = AppDatabase(openEncryptedDatabase(passphrase, dbFile));
/// ```
QueryExecutor openEncryptedDatabase(String passphrase, File dbFile) {
  return NativeDatabase(
    dbFile,
    setup: (rawDb) {
      // Verify SQLCipher is loaded, not plain sqlite3.
      assert(
        rawDb.select('PRAGMA cipher_version;').isNotEmpty,
        'SQLCipher not loaded — encryption unavailable. '
        'Check the sqlcipher_flutter_libs dependency in pubspec.yaml.',
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
@DriftDatabase(
  tables: [Profiles, CustomFields],
  daos: [ProfilesDao, CustomFieldsDao],
)
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
