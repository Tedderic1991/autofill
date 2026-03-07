// Tests for AppDatabase schema shape and code generation correctness.
//
// Verifies:
// - Profiles table: primaryKey is {id} TEXT, not AUTOINCREMENT
// - Profiles table: has deletedAt nullable column
// - Profiles table: has synchronized boolean column defaulting to false
// - CustomFields table: profileId FK references Profiles.id
// - CustomFields table: fieldType enum column accepts text/number/date values
// - Drift code generation runs (app_database.g.dart exists and is importable)
// - AppDatabase can be opened in memory

import 'package:autofill/data/database/app_database.dart';
import 'package:autofill/data/database/tables/custom_fields_table.dart';
import 'package:autofill/data/database/tables/profiles_table.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/in_memory_database.dart';

void main() {
  group('AppDatabase', () {
    late AppDatabase db;

    setUp(() async {
      db = await openTestDatabase();
    });

    tearDown(() async {
      await db.close();
    });

    test('can be opened in memory without errors', () async {
      // Simply opening and closing confirms the generated code works
      expect(db, isNotNull);
    });

    test('profiles table exists and accepts a row with UUID TEXT primary key',
        () async {
      final id = '12345678-1234-1234-1234-123456789012';
      final now = DateTime.now().toUtc();

      await db.into(db.profiles).insert(
            ProfilesCompanion.insert(
              id: id,
              displayName: 'Test Person',
              relationshipTag: RelationshipTag.parent,
              createdAt: now,
              updatedAt: now,
            ),
          );

      final rows = await db.select(db.profiles).get();
      expect(rows.length, equals(1));
      expect(rows.first.id, equals(id));
    });

    test('profiles table has deletedAt nullable column (accepts null)', () async {
      final id = '12345678-1234-1234-1234-123456789013';
      final now = DateTime.now().toUtc();

      await db.into(db.profiles).insert(
            ProfilesCompanion.insert(
              id: id,
              displayName: 'Test Person',
              relationshipTag: RelationshipTag.child,
              createdAt: now,
              updatedAt: now,
              // deletedAt is nullable — not provided = null
            ),
          );

      final rows = await db.select(db.profiles).get();
      expect(rows.first.deletedAt, isNull);
    });

    test(
        'profiles table has synchronized boolean defaulting to false',
        () async {
      final id = '12345678-1234-1234-1234-123456789014';
      final now = DateTime.now().toUtc();

      await db.into(db.profiles).insert(
            ProfilesCompanion.insert(
              id: id,
              displayName: 'Test Person',
              relationshipTag: RelationshipTag.guardian,
              createdAt: now,
              updatedAt: now,
            ),
          );

      final rows = await db.select(db.profiles).get();
      expect(rows.first.synchronized, isFalse);
    });

    test('custom_fields table exists and accepts a row with FK to profiles',
        () async {
      final profileId = '12345678-1234-1234-1234-123456789015';
      final fieldId = '87654321-4321-4321-4321-210987654321';
      final now = DateTime.now().toUtc();

      // Insert parent profile first (FK constraint)
      await db.into(db.profiles).insert(
            ProfilesCompanion.insert(
              id: profileId,
              displayName: 'Parent',
              relationshipTag: RelationshipTag.parent,
              createdAt: now,
              updatedAt: now,
            ),
          );

      await db.into(db.customFields).insert(
            CustomFieldsCompanion.insert(
              id: fieldId,
              profileId: profileId,
              label: 'Insurance Number',
              fieldType: CustomFieldType.text,
              createdAt: now,
              updatedAt: now,
            ),
          );

      final fields = await db.select(db.customFields).get();
      expect(fields.length, equals(1));
      expect(fields.first.profileId, equals(profileId));
    });

    test(
        'custom_fields fieldType enum column accepts text, number, and date values',
        () async {
      final profileId = '12345678-1234-1234-1234-123456789016';
      final now = DateTime.now().toUtc();

      await db.into(db.profiles).insert(
            ProfilesCompanion.insert(
              id: profileId,
              displayName: 'Parent',
              relationshipTag: RelationshipTag.parent,
              createdAt: now,
              updatedAt: now,
            ),
          );

      for (final (fieldId, type) in [
        ('id-text', CustomFieldType.text),
        ('id-number', CustomFieldType.number),
        ('id-date', CustomFieldType.date),
      ]) {
        await db.into(db.customFields).insert(
              CustomFieldsCompanion.insert(
                id: '12345678-1234-4321-4321-${fieldId.padLeft(12, '0')}',
                profileId: profileId,
                label: 'Field $fieldId',
                fieldType: type,
                createdAt: now,
                updatedAt: now,
              ),
            );
      }

      final fields = await db.select(db.customFields).get();
      expect(fields.length, equals(3));
      expect(
        fields.map((f) => f.fieldType).toSet(),
        containsAll([
          CustomFieldType.text,
          CustomFieldType.number,
          CustomFieldType.date,
        ]),
      );
    });
  });
}
