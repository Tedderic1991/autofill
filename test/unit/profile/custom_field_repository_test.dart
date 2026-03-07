// Tests for CustomFieldRepository — CRUD on custom_fields table.
//
// Requirements covered: PROF-07, PROF-08, PROF-09
//
// TODO: import 'package:autofill/data/database/app_database.dart';
// TODO: import 'package:autofill/data/repositories/custom_field_repository.dart';
// TODO: import '../../helpers/in_memory_database.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CustomFieldRepository', () {
    // PROF-07: Add a custom field linked to a profile.
    test(
      'addCustomField creates row in custom_fields table linked to profile',
      () => markTestSkipped('stub'),
      skip: 'Wave 0 stub — implement after Wave 1',
    );

    // PROF-08: Edit label, type, and value of an existing custom field.
    test(
      'editCustomField updates label, fieldType, value, and updatedAt',
      () => markTestSkipped('stub'),
      skip: 'Wave 0 stub — implement after Wave 1',
    );

    // PROF-08: Soft delete custom field — sets deletedAt.
    test(
      'deleteCustomField sets deletedAt (soft delete)',
      () => markTestSkipped('stub'),
      skip: 'Wave 0 stub — implement after Wave 1',
    );

    // PROF-09: Read profile returns built-in fields combined with custom fields.
    test(
      'getProfileWithFields returns built-in fields and custom fields together',
      () => markTestSkipped('stub'),
      skip: 'Wave 0 stub — implement after Wave 1',
    );
  });
}
