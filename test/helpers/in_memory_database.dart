// In-memory Drift database fixture for unit tests.
//
// Opens an AppDatabase backed by NativeDatabase.memory() — no encryption,
// no file I/O. Safe to call in any unit test without a device or real storage.
//
// All unit tests that need database access should call openTestDatabase() in
// their setUp() and close the returned AppDatabase in tearDown():
//
//   late AppDatabase db;
//   setUp(() async { db = await openTestDatabase(); });
//   tearDown(() async { await db.close(); });

import 'package:autofill/data/database/app_database.dart';
import 'package:drift/native.dart';

/// Opens an in-memory Drift database for testing.
///
/// No encryption, no file I/O — safe to call in any unit test.
Future<AppDatabase> openTestDatabase() async {
  return AppDatabase(NativeDatabase.memory());
}
