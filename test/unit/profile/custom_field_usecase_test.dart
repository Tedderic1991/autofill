// Tests for CustomFieldUseCase — business logic for custom field CRUD.
//
// Requirements covered: PROF-07, PROF-08, PROF-09
//
// Uses mocktail to mock CustomFieldRepository so tests run without a real DB.

import 'package:autofill/domain/models/custom_field.dart';
import 'package:autofill/domain/repositories/custom_field_repository.dart';
import 'package:autofill/domain/use_cases/custom_field_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCustomFieldRepository extends Mock implements CustomFieldRepository {}

void main() {
  late MockCustomFieldRepository mockRepo;

  setUp(() {
    mockRepo = MockCustomFieldRepository();
  });

  const testProfileId = '99999999-9999-9999-9999-000000000001';

  group('CustomFieldUseCase', () {
    group('addField', () {
      // PROF-07: addField creates a custom field linked to the profile
      test('addField creates CustomField with UUID id and links to profileId',
          () async {
        final useCase = CustomFieldUseCase(mockRepo);
        when(() => mockRepo.upsert(any())).thenAnswer((_) async {});

        final result = await useCase.addField(
          testProfileId,
          'Insurance #',
          CustomFieldType.text,
        );

        expect(result.profileId, equals(testProfileId));
        expect(result.label, equals('Insurance #'));
        expect(result.fieldType, equals(CustomFieldType.text));
        // UUID v4 format: 8-4-4-4-12 hex chars
        final uuidRegex = RegExp(
          r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
        );
        expect(uuidRegex.hasMatch(result.id), isTrue,
            reason: 'id should be a valid UUID v4');
        verify(() => mockRepo.upsert(any())).called(1);
      });

      test('addField sets synchronized = false', () async {
        final useCase = CustomFieldUseCase(mockRepo);
        when(() => mockRepo.upsert(any())).thenAnswer((_) async {});

        final result =
            await useCase.addField(testProfileId, 'Label', CustomFieldType.text);

        expect(result.synchronized, isFalse);
      });

      test('addField sets createdAt and updatedAt to UTC now', () async {
        final before = DateTime.now().toUtc();
        final useCase = CustomFieldUseCase(mockRepo);
        when(() => mockRepo.upsert(any())).thenAnswer((_) async {});

        final result =
            await useCase.addField(testProfileId, 'Label', CustomFieldType.date);
        final after = DateTime.now().toUtc();

        expect(result.createdAt.isUtc, isTrue);
        expect(result.updatedAt.isUtc, isTrue);
        expect(
            result.createdAt.isAfter(before) ||
                result.createdAt.isAtSameMomentAs(before),
            isTrue);
        expect(
            result.createdAt.isBefore(after) ||
                result.createdAt.isAtSameMomentAs(after),
            isTrue);
      });

      test('addField sets deletedAt = null', () async {
        final useCase = CustomFieldUseCase(mockRepo);
        when(() => mockRepo.upsert(any())).thenAnswer((_) async {});

        final result =
            await useCase.addField(testProfileId, 'Label', CustomFieldType.number);

        expect(result.deletedAt, isNull);
      });
    });

    group('editField', () {
      // PROF-08: editField updates label, fieldType, value and sets updatedAt
      test('editField updates label and sets updatedAt/synchronized', () async {
        final useCase = CustomFieldUseCase(mockRepo);
        final now = DateTime.now().toUtc();
        final existing = CustomField(
          id: 'aaaaaaaa-aaaa-aaaa-aaaa-000000000001',
          profileId: testProfileId,
          label: 'Old Label',
          fieldType: CustomFieldType.text,
          createdAt: now,
          updatedAt: now,
          synchronized: true,
        );

        when(() => mockRepo.getActiveForProfile(testProfileId))
            .thenAnswer((_) async => [existing]);
        when(() => mockRepo.upsert(any())).thenAnswer((_) async {});

        final before = DateTime.now().toUtc();
        final result = await useCase.editField(
          existing.id,
          profileId: testProfileId,
          label: 'New Label',
        );
        final after = DateTime.now().toUtc();

        expect(result.label, equals('New Label'));
        expect(result.synchronized, isFalse);
        expect(result.id, equals(existing.id));
        expect(
            result.updatedAt.isAfter(before) ||
                result.updatedAt.isAtSameMomentAs(before),
            isTrue);
        expect(
            result.updatedAt.isBefore(after) ||
                result.updatedAt.isAtSameMomentAs(after),
            isTrue);
        verify(() => mockRepo.upsert(any())).called(1);
      });

      test('editField updates fieldType when provided', () async {
        final useCase = CustomFieldUseCase(mockRepo);
        final now = DateTime.now().toUtc();
        final existing = CustomField(
          id: 'aaaaaaaa-aaaa-aaaa-aaaa-000000000001',
          profileId: testProfileId,
          label: 'Number Field',
          fieldType: CustomFieldType.text,
          createdAt: now,
          updatedAt: now,
          synchronized: false,
        );

        when(() => mockRepo.getActiveForProfile(testProfileId))
            .thenAnswer((_) async => [existing]);
        when(() => mockRepo.upsert(any())).thenAnswer((_) async {});

        final result = await useCase.editField(
          existing.id,
          profileId: testProfileId,
          fieldType: CustomFieldType.number,
        );

        expect(result.fieldType, equals(CustomFieldType.number));
      });

      test('editField updates value when provided', () async {
        final useCase = CustomFieldUseCase(mockRepo);
        final now = DateTime.now().toUtc();
        final existing = CustomField(
          id: 'aaaaaaaa-aaaa-aaaa-aaaa-000000000001',
          profileId: testProfileId,
          label: 'Score',
          fieldType: CustomFieldType.number,
          createdAt: now,
          updatedAt: now,
          synchronized: false,
        );

        when(() => mockRepo.getActiveForProfile(testProfileId))
            .thenAnswer((_) async => [existing]);
        when(() => mockRepo.upsert(any())).thenAnswer((_) async {});

        final result = await useCase.editField(
          existing.id,
          profileId: testProfileId,
          value: '99',
        );

        expect(result.value, equals('99'));
      });
    });

    group('deleteField', () {
      // PROF-09: deleteField soft-deletes via repository.softDelete
      test('deleteField calls repository.softDelete (soft delete only)', () async {
        final useCase = CustomFieldUseCase(mockRepo);
        when(() => mockRepo.softDelete(any())).thenAnswer((_) async {});

        await useCase.deleteField('field-id-123');

        verify(() => mockRepo.softDelete('field-id-123')).called(1);
        verifyNever(() => mockRepo.upsert(any()));
      });
    });
  });
}
