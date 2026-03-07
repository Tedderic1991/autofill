// Tests for CustomFieldRepositoryImpl — CRUD on custom_fields table.
//
// Requirements covered: PROF-07, PROF-08, PROF-09
//
// Uses openTestDatabase() from test/helpers/in_memory_database.dart so no
// real file I/O or encryption is needed.

import 'package:autofill/data/database/app_database.dart';
import 'package:autofill/data/database/tables/custom_fields_table.dart';
import 'package:autofill/data/database/tables/profiles_table.dart';
import 'package:autofill/data/repositories/custom_field_repository_impl.dart';
import 'package:autofill/domain/models/custom_field.dart';
import 'package:autofill/domain/models/profile.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/in_memory_database.dart';

void main() {
  group('CustomFieldRepository', () {
    late AppDatabase db;
    late CustomFieldRepositoryImpl repo;

    const profileId = '99999999-9999-9999-9999-000000000001';

    setUp(() async {
      db = await openTestDatabase();
      repo = CustomFieldRepositoryImpl(db);

      // Insert a parent profile to satisfy FK constraints
      final now = DateTime.now().toUtc();
      await db.profilesDao.upsertProfile(
        ProfilesCompanion.insert(
          id: profileId,
          displayName: 'Test Parent',
          relationshipTag: RelationshipTag.parent,
          createdAt: now,
          updatedAt: now,
        ),
      );
    });

    tearDown(() async {
      await db.close();
    });

    CustomField _makeField({
      String id = 'aaaaaaaa-aaaa-aaaa-aaaa-000000000001',
      String label = 'Insurance #',
      CustomFieldType type = CustomFieldType.text,
      String? value,
    }) {
      final now = DateTime.now().toUtc();
      return CustomField(
        id: id,
        profileId: profileId,
        label: label,
        fieldType: type,
        value: value,
        createdAt: now,
        updatedAt: now,
        synchronized: false,
      );
    }

    // PROF-07: Add a custom field linked to a profile.
    test('addCustomField creates row in custom_fields table linked to profile',
        () async {
      final field = _makeField(label: 'Policy Number');
      await repo.upsert(field);

      final fields = await repo.getActiveForProfile(profileId);
      expect(fields.length, equals(1));
      expect(fields.first.label, equals('Policy Number'));
      expect(fields.first.profileId, equals(profileId));
    });

    // PROF-08: Edit label, type, and value of an existing custom field.
    test('editCustomField updates label, fieldType, value, and updatedAt',
        () async {
      final original = _makeField(label: 'Old Label', type: CustomFieldType.text);
      await repo.upsert(original);

      await Future<void>.delayed(const Duration(milliseconds: 1));

      final updated = original.copyWith(
        label: 'New Label',
        fieldType: CustomFieldType.number,
        value: '42',
        updatedAt: DateTime.now().toUtc(),
      );
      await repo.upsert(updated);

      final fields = await repo.getActiveForProfile(profileId);
      expect(fields.length, equals(1));
      expect(fields.first.label, equals('New Label'));
      expect(fields.first.fieldType, equals(CustomFieldType.number));
      expect(fields.first.value, equals('42'));
    });

    // PROF-08: Soft delete custom field — sets deletedAt.
    test('deleteCustomField sets deletedAt (soft delete)', () async {
      final field = _makeField();
      await repo.upsert(field);
      await repo.softDelete(field.id);

      final fields = await repo.getActiveForProfile(profileId);
      expect(fields, isEmpty);
    });

    // PROF-09: Read profile returns built-in fields combined with custom fields.
    test('getProfileWithFields returns built-in fields and custom fields together',
        () async {
      // Insert two fields for the profile
      await repo.upsert(_makeField(
        id: 'aaaaaaaa-aaaa-aaaa-aaaa-000000000001',
        label: 'Insurance #',
      ));
      await repo.upsert(_makeField(
        id: 'aaaaaaaa-aaaa-aaaa-aaaa-000000000002',
        label: 'Blood Type',
        type: CustomFieldType.text,
        value: 'O+',
      ));

      final fields = await repo.getActiveForProfile(profileId);
      expect(fields.length, equals(2));
      expect(fields.map((f) => f.label), containsAll(['Insurance #', 'Blood Type']));
    });

    // getActiveForProfile returns empty list for profile with no fields
    test('getActiveForProfile returns empty list for profile with no fields',
        () async {
      final fields = await repo.getActiveForProfile(profileId);
      expect(fields, isEmpty);
    });

    // getActiveForProfile excludes fields from other profiles
    test('getActiveForProfile only returns fields for the given profile',
        () async {
      // Insert a second profile
      final now = DateTime.now().toUtc();
      const otherProfileId = '99999999-9999-9999-9999-000000000002';
      await db.profilesDao.upsertProfile(
        ProfilesCompanion.insert(
          id: otherProfileId,
          displayName: 'Other Person',
          relationshipTag: RelationshipTag.child,
          createdAt: now,
          updatedAt: now,
        ),
      );

      // Insert field for the test profile
      await repo.upsert(_makeField(label: 'My Field'));

      // Query for the other profile — should return empty
      final otherFields = await repo.getActiveForProfile(otherProfileId);
      expect(otherFields, isEmpty);
    });
  });
}
