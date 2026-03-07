// In-memory Drift database fixture for unit tests.
//
// TODO: import 'package:autofill/data/database/app_database.dart';
//
// Once AppDatabase is implemented in Wave 1, replace the stub below with:
//
//   import 'package:drift/native.dart';
//   import 'package:autofill/data/database/app_database.dart';
//
//   Future<AppDatabase> openTestDatabase() async {
//     return AppDatabase(NativeDatabase.memory());
//   }
//
// For now this file establishes the path and import contract so all test
// files can reference it with a stable import.

/// Opens an in-memory Drift database for testing.
///
/// No encryption, no file I/O — safe to call in any unit test.
/// Replace the body with the real implementation once AppDatabase exists (Wave 1).
Future<Never> openTestDatabase() {
  return Future.error(
    UnimplementedError(
      'openTestDatabase: AppDatabase not yet implemented. '
      'This stub will be replaced in Wave 1.',
    ),
  );
}
