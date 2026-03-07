// Tests for ProfilesDao and CustomFieldsDao — DAO layer behaviors.
//
// Requirements covered: PROF-01, PROF-02, PROF-03, PROF-07, PROF-08, PROF-09
//
// TDD RED: These tests reference ProfilesDao and CustomFieldsDao which do not
// exist yet. They will fail to compile until Task 1 GREEN phase creates them.

import 'package:autofill/data/database/app_database.dart';
import 'package:autofill/data/database/tables/custom_fields_table.dart';
import 'package:autofill/data/database/tables/profiles_table.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/in_memory_database.dart';

void main() {
  group('ProfilesDao', () {
    late AppDatabase db;

    setUp(() async {
      db = await openTestDatabase();
    });

    tearDown(() async {
      await db.close();
    });

    String _makeId(String suffix) =>
        '12345678-1234-1234-1234-${suffix.padLeft(12, '0')}';

    Future<void> _insertProfile(
      AppDatabase db, {
      required String id,
      String displayName = 'Test Person',
      RelationshipTag tag = RelationshipTag.parent,
    }) async {
      final now = DateTime.now().toUtc();
      await db.profilesDao.upsertProfile(
        ProfilesCompanion.insert(
          id: id,
          displayName: displayName,
          relationshipTag: tag,
          createdAt: now,
          updatedAt: now,
        ),
      );
    }

    // PROF-01: Active profiles stream includes non-deleted rows.
    test('watchActiveProfiles emits inserted profile', () async {
      final id = _makeId('1');
      await _insertProfile(db, id: id);

      final profiles = await db.profilesDao.watchActiveProfiles().first;
      expect(profiles.any((p) => p.id == id), isTrue);
    });

    // PROF-03: countActive returns 0 when no profiles.
    test('countActive returns 0 on empty DB', () async {
      final count = await db.profilesDao.countActive();
      expect(count, equals(0));
    });

    // PROF-03: countActive returns correct count after insert.
    test('countActive returns 1 after one insert', () async {
      await _insertProfile(db, id: _makeId('2'));

      final count = await db.profilesDao.countActive();
      expect(count, equals(1));
    });

    // PROF-03: softDelete sets deletedAt; profile excluded from watchActive.
    test('softDelete sets deletedAt and excludes from watchActiveProfiles',
        () async {
      final id = _makeId('3');
      await _insertProfile(db, id: id);

      await db.profilesDao.softDelete(id);

      final profiles = await db.profilesDao.watchActiveProfiles().first;
      expect(profiles.any((p) => p.id == id), isFalse);
    });

    // PROF-03: countActive excludes soft-deleted profiles.
    test('countActive excludes soft-deleted profile', () async {
      final id = _makeId('4');
      await _insertProfile(db, id: id);
      await db.profilesDao.softDelete(id);

      final count = await db.profilesDao.countActive();
      expect(count, equals(0));
    });

    // PROF-01: getProfileById returns the profile by id.
    test('getProfileById returns the correct profile', () async {
      final id = _makeId('5');
      await _insertProfile(db, id: id, displayName: 'Alice');

      final profile = await db.profilesDao.getProfileById(id);
      expect(profile, isNotNull);
      expect(profile!.displayName, equals('Alice'));
    });

    // PROF-01: getProfileById returns null for nonexistent id.
    test('getProfileById returns null for missing id', () async {
      final profile = await db.profilesDao.getProfileById('nonexistent-id');
      expect(profile, isNull);
    });
  });

  group('CustomFieldsDao', () {
    late AppDatabase db;

    setUp(() async {
      db = await openTestDatabase();
    });

    tearDown(() async {
      await db.close();
    });

    String _makeProfileId() => '99999999-9999-9999-9999-000000000001';
    String _makeFieldId(String suffix) =>
        'aaaaaaaa-aaaa-aaaa-aaaa-${suffix.padLeft(12, '0')}';

    Future<void> _insertTestProfile(AppDatabase db) async {
      final now = DateTime.now().toUtc();
      await db.profilesDao.upsertProfile(
        ProfilesCompanion.insert(
          id: _makeProfileId(),
          displayName: 'Test Parent',
          relationshipTag: RelationshipTag.parent,
          createdAt: now,
          updatedAt: now,
        ),
      );
    }

    Future<void> _insertField(
      AppDatabase db, {
      required String id,
      CustomFieldType type = CustomFieldType.text,
      String label = 'Test Field',
      String? value,
    }) async {
      final now = DateTime.now().toUtc();
      await db.customFieldsDao.upsertField(
        CustomFieldsCompanion.insert(
          id: id,
          profileId: _makeProfileId(),
          label: label,
          fieldType: type,
          value: value == null ? const Value.absent() : Value(value),
          createdAt: now,
          updatedAt: now,
        ),
      );
    }

    // PROF-07: getActiveForProfile returns fields linked to profile.
    test('getActiveForProfile returns only fields for the given profile',
        () async {
      await _insertTestProfile(db);
      final id = _makeFieldId('1');
      await _insertField(db, id: id, label: 'Insurance #');

      final fields =
          await db.customFieldsDao.getActiveForProfile(_makeProfileId());
      expect(fields.any((f) => f.id == id), isTrue);
    });

    // PROF-07: getActiveForProfile returns empty list for profile with no fields.
    test('getActiveForProfile returns empty list for profile with no fields',
        () async {
      await _insertTestProfile(db);

      final fields =
          await db.customFieldsDao.getActiveForProfile(_makeProfileId());
      expect(fields, isEmpty);
    });

    // PROF-08: softDeleteField sets deletedAt; field excluded from getActiveForProfile.
    test('softDeleteField excludes field from getActiveForProfile', () async {
      await _insertTestProfile(db);
      final id = _makeFieldId('2');
      await _insertField(db, id: id);

      await db.customFieldsDao.softDeleteField(id);

      final fields =
          await db.customFieldsDao.getActiveForProfile(_makeProfileId());
      expect(fields.any((f) => f.id == id), isFalse);
    });
  });
}
