// Tests for ProfileRepository — CRUD operations on profiles table.
//
// Requirements covered: PROF-01, PROF-02, PROF-03, PROF-05
//
// TODO: import 'package:autofill/data/database/app_database.dart';
// TODO: import 'package:autofill/data/repositories/profile_repository.dart';
// TODO: import '../../helpers/in_memory_database.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProfileRepository', () {
    // PROF-01: Create profile with all built-in fields persisted.
    test(
      'createProfile writes all built-in fields to DB',
      () => markTestSkipped('stub'),
      skip: 'Wave 0 stub — implement after Wave 1',
    );

    // PROF-02: Update profile — changes persist and updatedAt increments.
    test(
      'updateProfile persists changes and increments updatedAt',
      () => markTestSkipped('stub'),
      skip: 'Wave 0 stub — implement after Wave 1',
    );

    // PROF-03: Soft delete — sets deletedAt, row not hard-deleted.
    test(
      'deleteProfile sets deletedAt (soft delete), not hard delete',
      () => markTestSkipped('stub'),
      skip: 'Wave 0 stub — implement after Wave 1',
    );

    // PROF-03: Deleted profiles excluded from active count query.
    test(
      'deleted profile excluded from countActive()',
      () => markTestSkipped('stub'),
      skip: 'Wave 0 stub — implement after Wave 1',
    );

    // PROF-05: Relationship tag (parent/child/guardian) persisted correctly.
    test(
      'relationshipTag persisted and retrieved for parent/child/guardian',
      () => markTestSkipped('stub'),
      skip: 'Wave 0 stub — implement after Wave 1',
    );
  });
}
