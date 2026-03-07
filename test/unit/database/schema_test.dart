// Tests for database schema shape — UUID PKs, sync-ready fields, FK constraints.
//
// TODO: import 'package:autofill/data/database/app_database.dart';
// TODO: import '../../helpers/in_memory_database.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Schema shape', () {
    test(
      'profiles table has UUID TEXT primary key (no AUTOINCREMENT)',
      () => markTestSkipped('stub'),
      skip: 'Wave 0 stub — implement after Wave 1',
    );

    test(
      'profiles table has createdAt, updatedAt, deletedAt, synchronized columns',
      () => markTestSkipped('stub'),
      skip: 'Wave 0 stub — implement after Wave 1',
    );

    test(
      'custom_fields table has UUID TEXT primary key',
      () => markTestSkipped('stub'),
      skip: 'Wave 0 stub — implement after Wave 1',
    );

    test(
      'custom_fields table has profileId FK, label, fieldType, value columns',
      () => markTestSkipped('stub'),
      skip: 'Wave 0 stub — implement after Wave 1',
    );

    test(
      'custom_fields table has createdAt, updatedAt, deletedAt, synchronized columns',
      () => markTestSkipped('stub'),
      skip: 'Wave 0 stub — implement after Wave 1',
    );
  });
}
