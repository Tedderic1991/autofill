// Tests for ProfileUseCase — business rules on top of ProfileRepository.
//
// Requirements covered: PROF-06 (freemium profile cap), updateProfile, deleteProfile
//
// Uses mocktail to mock ProfileRepository so tests run without a real DB.

import 'package:autofill/domain/models/profile.dart';
import 'package:autofill/domain/use_cases/profile_use_case.dart';
import 'package:autofill/domain/repositories/profile_repository.dart';
import 'package:autofill/providers/entitlement_providers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  late MockProfileRepository mockRepo;

  setUp(() {
    mockRepo = MockProfileRepository();
  });

  FamilyProfile _makeProfile({
    String id = 'aaaaaaaa-aaaa-aaaa-aaaa-000000000001',
    String displayName = 'Alice',
  }) {
    final now = DateTime.now().toUtc();
    return FamilyProfile(
      id: id,
      displayName: displayName,
      relationshipTag: RelationshipTag.child,
      createdAt: now,
      updatedAt: now,
      synchronized: false,
    );
  }

  ProfileCreateRequest _makeRequest({String displayName = 'Alice'}) {
    return ProfileCreateRequest(
      displayName: displayName,
      relationshipTag: RelationshipTag.child,
    );
  }

  group('ProfileUseCase', () {
    group('createProfile — free tier', () {
      // PROF-06: Free tier allows up to 2 profiles.
      test('createProfile succeeds when count < 2 on free tier', () async {
        final useCase = ProfileUseCase(mockRepo, EntitlementTier.free);
        when(() => mockRepo.countActive()).thenAnswer((_) async => 1);
        when(() => mockRepo.upsert(any())).thenAnswer((_) async {});

        final result = await useCase.createProfile(_makeRequest());

        expect(result.displayName, equals('Alice'));
        expect(result.synchronized, isFalse);
        expect(result.id, isNotEmpty);
        expect(result.id.length, equals(36)); // UUID v4 format
        verify(() => mockRepo.upsert(any())).called(1);
      });

      // PROF-06: Free tier allows up to 2 profiles (exactly 0 existing).
      test('createProfile succeeds when count == 0 on free tier', () async {
        final useCase = ProfileUseCase(mockRepo, EntitlementTier.free);
        when(() => mockRepo.countActive()).thenAnswer((_) async => 0);
        when(() => mockRepo.upsert(any())).thenAnswer((_) async {});

        final result = await useCase.createProfile(_makeRequest());

        expect(result.displayName, equals('Alice'));
        verify(() => mockRepo.countActive()).called(1);
        verify(() => mockRepo.upsert(any())).called(1);
      });

      // PROF-06: Free tier blocks 3rd profile creation.
      test('createProfile throws ProfileLimitReached when count == 2 on free tier',
          () async {
        final useCase = ProfileUseCase(mockRepo, EntitlementTier.free);
        when(() => mockRepo.countActive()).thenAnswer((_) async => 2);

        expect(
          () => useCase.createProfile(_makeRequest()),
          throwsA(isA<ProfileLimitReached>()),
        );
        verifyNever(() => mockRepo.upsert(any()));
      });

      // PROF-06: Paid tier has no 2-profile cap.
      test('createProfile succeeds when count == 2 on paid tier', () async {
        final useCase = ProfileUseCase(mockRepo, EntitlementTier.paid);
        // countActive should NOT be called for paid tier
        when(() => mockRepo.upsert(any())).thenAnswer((_) async {});

        final result = await useCase.createProfile(_makeRequest());

        expect(result.displayName, equals('Alice'));
        verifyNever(() => mockRepo.countActive());
        verify(() => mockRepo.upsert(any())).called(1);
      });
    });

    group('createProfile — field initialization', () {
      test('createProfile assigns UUID v4 id', () async {
        final useCase = ProfileUseCase(mockRepo, EntitlementTier.free);
        when(() => mockRepo.countActive()).thenAnswer((_) async => 0);
        when(() => mockRepo.upsert(any())).thenAnswer((_) async {});

        final result = await useCase.createProfile(_makeRequest());

        // UUID v4 format: 8-4-4-4-12 hex chars
        final uuidRegex = RegExp(
          r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
        );
        expect(uuidRegex.hasMatch(result.id), isTrue,
            reason: 'id should be a valid UUID v4');
      });

      test('createProfile sets synchronized = false', () async {
        final useCase = ProfileUseCase(mockRepo, EntitlementTier.free);
        when(() => mockRepo.countActive()).thenAnswer((_) async => 0);
        when(() => mockRepo.upsert(any())).thenAnswer((_) async {});

        final result = await useCase.createProfile(_makeRequest());

        expect(result.synchronized, isFalse);
      });

      test('createProfile sets createdAt and updatedAt to UTC now', () async {
        final before = DateTime.now().toUtc();
        final useCase = ProfileUseCase(mockRepo, EntitlementTier.free);
        when(() => mockRepo.countActive()).thenAnswer((_) async => 0);
        when(() => mockRepo.upsert(any())).thenAnswer((_) async {});

        final result = await useCase.createProfile(_makeRequest());
        final after = DateTime.now().toUtc();

        expect(result.createdAt.isAfter(before) || result.createdAt.isAtSameMomentAs(before),
            isTrue);
        expect(result.createdAt.isBefore(after) || result.createdAt.isAtSameMomentAs(after),
            isTrue);
        expect(result.updatedAt.isAfter(before) || result.updatedAt.isAtSameMomentAs(before),
            isTrue);
        expect(result.createdAt.isUtc, isTrue);
        expect(result.updatedAt.isUtc, isTrue);
      });
    });

    group('updateProfile', () {
      test('updateProfile sets updatedAt to now and synchronized = false',
          () async {
        final useCase = ProfileUseCase(mockRepo, EntitlementTier.free);
        final existing = _makeProfile();
        when(() => mockRepo.getById(existing.id))
            .thenAnswer((_) async => existing);
        when(() => mockRepo.upsert(any())).thenAnswer((_) async {});

        final before = DateTime.now().toUtc();
        final request = ProfileUpdateRequest(
          id: existing.id,
          displayName: 'Alice Updated',
        );
        final result = await useCase.updateProfile(existing.id, request);
        final after = DateTime.now().toUtc();

        expect(result.displayName, equals('Alice Updated'));
        expect(result.synchronized, isFalse);
        expect(result.updatedAt.isAfter(before) || result.updatedAt.isAtSameMomentAs(before),
            isTrue);
        expect(result.updatedAt.isBefore(after) || result.updatedAt.isAtSameMomentAs(after),
            isTrue);
        verify(() => mockRepo.upsert(any())).called(1);
      });

      test('updateProfile throws ProfileNotFound when profile does not exist',
          () async {
        final useCase = ProfileUseCase(mockRepo, EntitlementTier.free);
        when(() => mockRepo.getById('missing-id'))
            .thenAnswer((_) async => null);

        expect(
          () => useCase.updateProfile(
              'missing-id', ProfileUpdateRequest(id: 'missing-id')),
          throwsA(isA<ProfileNotFound>()),
        );
      });
    });

    group('deleteProfile', () {
      test('deleteProfile calls repository.softDelete only — no hard delete',
          () async {
        final useCase = ProfileUseCase(mockRepo, EntitlementTier.free);
        when(() => mockRepo.softDelete(any())).thenAnswer((_) async {});

        await useCase.deleteProfile('some-id');

        verify(() => mockRepo.softDelete('some-id')).called(1);
        verifyNever(() => mockRepo.upsert(any()));
      });
    });
  });
}
