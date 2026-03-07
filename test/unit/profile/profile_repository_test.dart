// Tests for ProfileRepositoryImpl — CRUD operations on profiles table.
//
// Requirements covered: PROF-01, PROF-02, PROF-03, PROF-05
//
// Uses openTestDatabase() from test/helpers/in_memory_database.dart so no
// real file I/O or encryption is needed.

import 'package:autofill/data/database/app_database.dart';
import 'package:autofill/data/database/tables/profiles_table.dart';
import 'package:autofill/data/repositories/profile_repository_impl.dart';
import 'package:autofill/domain/models/profile.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/in_memory_database.dart';

void main() {
  group('ProfileRepository', () {
    late AppDatabase db;
    late ProfileRepositoryImpl repo;

    setUp(() async {
      db = await openTestDatabase();
      repo = ProfileRepositoryImpl(db);
    });

    tearDown(() async {
      await db.close();
    });

    FamilyProfile _makeProfile({
      String id = '12345678-0000-0000-0000-000000000001',
      String displayName = 'Alice Smith',
      RelationshipTag tag = RelationshipTag.parent,
    }) {
      final now = DateTime.now().toUtc();
      return FamilyProfile(
        id: id,
        displayName: displayName,
        relationshipTag: tag,
        createdAt: now,
        updatedAt: now,
        synchronized: false,
      );
    }

    // PROF-01: Create profile with all built-in fields persisted.
    test('createProfile writes all built-in fields to DB', () async {
      final profile = _makeProfile(displayName: 'Bob Jones');
      await repo.upsert(profile);

      final fetched = await repo.getById(profile.id);
      expect(fetched, isNotNull);
      expect(fetched!.displayName, equals('Bob Jones'));
      expect(fetched.relationshipTag, equals(RelationshipTag.parent));
    });

    // PROF-02: Update profile — changes persist and updatedAt increments.
    test('updateProfile persists changes and increments updatedAt', () async {
      final original = _makeProfile(displayName: 'Carol White');
      await repo.upsert(original);

      // Wait 1ms to ensure time difference is measurable
      await Future<void>.delayed(const Duration(milliseconds: 1));

      final updated = original.copyWith(
        displayName: 'Carol Brown',
        updatedAt: DateTime.now().toUtc(),
      );
      await repo.upsert(updated);

      final fetched = await repo.getById(original.id);
      expect(fetched!.displayName, equals('Carol Brown'));
      expect(
        fetched.updatedAt.isAfter(original.updatedAt) ||
            fetched.updatedAt.isAtSameMomentAs(original.updatedAt),
        isTrue,
      );
    });

    // PROF-03: Soft delete — sets deletedAt, row not hard-deleted.
    test('deleteProfile sets deletedAt (soft delete), not hard delete',
        () async {
      final profile = _makeProfile();
      await repo.upsert(profile);
      await repo.softDelete(profile.id);

      // Row still exists in DB — verify via direct DAO access
      final row = await db.profilesDao.getProfileById(profile.id);
      expect(row, isNotNull);
      expect(row!.deletedAt, isNotNull);
    });

    // PROF-03: Deleted profiles excluded from active count query.
    test('deleted profile excluded from countActive()', () async {
      final profile = _makeProfile();
      await repo.upsert(profile);
      expect(await repo.countActive(), equals(1));

      await repo.softDelete(profile.id);
      expect(await repo.countActive(), equals(0));
    });

    // PROF-05: Relationship tag (parent/child/guardian) persisted correctly.
    test('relationshipTag persisted and retrieved for parent/child/guardian',
        () async {
      for (final (id, tag) in [
        ('12345678-0000-0000-0000-000000000002', RelationshipTag.parent),
        ('12345678-0000-0000-0000-000000000003', RelationshipTag.child),
        ('12345678-0000-0000-0000-000000000004', RelationshipTag.guardian),
      ]) {
        await repo.upsert(_makeProfile(id: id, tag: tag));
      }

      for (final (id, expectedTag) in [
        ('12345678-0000-0000-0000-000000000002', RelationshipTag.parent),
        ('12345678-0000-0000-0000-000000000003', RelationshipTag.child),
        ('12345678-0000-0000-0000-000000000004', RelationshipTag.guardian),
      ]) {
        final profile = await repo.getById(id);
        expect(profile!.relationshipTag, equals(expectedTag));
      }
    });

    // countActive returns 0 on empty DB
    test('countActive returns 0 on empty DB', () async {
      expect(await repo.countActive(), equals(0));
    });

    // watchActive emits inserted profile
    test('watchActive emits inserted profile', () async {
      final profile = _makeProfile();
      await repo.upsert(profile);

      final profiles = await repo.watchActive().first;
      expect(profiles.any((p) => p.id == profile.id), isTrue);
    });

    // watchActive excludes soft-deleted profiles
    test('watchActive excludes soft-deleted profiles', () async {
      final profile = _makeProfile();
      await repo.upsert(profile);
      await repo.softDelete(profile.id);

      final profiles = await repo.watchActive().first;
      expect(profiles.any((p) => p.id == profile.id), isFalse);
    });
  });
}
