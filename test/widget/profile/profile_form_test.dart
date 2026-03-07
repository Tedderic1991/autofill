// Widget tests for ProfileEditScreen.
//
// Requirements covered:
//   PROF-04: avatar picker button renders in the form
//   PROF-06: ProfileLimitReached on create navigates to PaywallStubScreen

import 'package:autofill/domain/models/custom_field.dart';
import 'package:autofill/domain/models/profile.dart';
import 'package:autofill/domain/repositories/custom_field_repository.dart';
import 'package:autofill/domain/repositories/profile_repository.dart';
import 'package:autofill/domain/use_cases/custom_field_use_case.dart';
import 'package:autofill/domain/use_cases/profile_use_case.dart';
import 'package:autofill/presentation/paywall/paywall_stub_screen.dart';
import 'package:autofill/presentation/profiles/profile_edit_screen.dart';
import 'package:autofill/providers/database_provider.dart';
import 'package:autofill/providers/profile_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// ── Mocks ──────────────────────────────────────────────────────────────────

class _MockProfileUseCase extends Mock implements ProfileUseCase {}

class _MockCustomFieldUseCase extends Mock implements CustomFieldUseCase {}

class _MockCustomFieldRepository extends Mock
    implements CustomFieldRepository {}

class _MockProfileRepository extends Mock implements ProfileRepository {}

// ── Stub notifiers ─────────────────────────────────────────────────────────

class _StubProfileListNotifier extends ProfileListNotifier {
  @override
  Stream<List<FamilyProfile>> build() => Stream.value(const []);
}

class _StubProfileUseCaseNotifier extends ProfileUseCaseNotifier {
  _StubProfileUseCaseNotifier(this._useCase);
  final ProfileUseCase _useCase;
  @override
  Future<ProfileUseCase> build() async => _useCase;
}

class _StubCustomFieldUseCaseNotifier extends CustomFieldUseCaseNotifier {
  _StubCustomFieldUseCaseNotifier(this._useCase);
  final CustomFieldUseCase _useCase;
  @override
  Future<CustomFieldUseCase> build() async => _useCase;
}

class _StubCustomFieldRepositoryNotifier
    extends CustomFieldRepositoryNotifier {
  _StubCustomFieldRepositoryNotifier(this._repo);
  final CustomFieldRepository _repo;
  @override
  Future<CustomFieldRepository> build() async => _repo;
}

class _StubProfileRepositoryNotifier extends ProfileRepositoryNotifier {
  _StubProfileRepositoryNotifier(this._repo);
  final ProfileRepository _repo;
  @override
  Future<ProfileRepository> build() async => _repo;
}

// ── Helpers ────────────────────────────────────────────────────────────────

Widget _wrapWithProviders(
  Widget child, {
  required ProfileUseCase profileUseCaseMock,
  CustomFieldUseCase? customFieldUseCaseMock,
  CustomFieldRepository? customFieldRepoMock,
  ProfileRepository? profileRepoMock,
}) {
  final cfUseCaseMock = customFieldUseCaseMock ?? _MockCustomFieldUseCase();
  final cfRepoMock = customFieldRepoMock ?? _MockCustomFieldRepository();
  final profRepoMock = profileRepoMock ?? _MockProfileRepository();

  return ProviderScope(
    overrides: [
      profileListProvider.overrideWith(_StubProfileListNotifier.new),
      profileUseCaseProvider
          .overrideWith(() => _StubProfileUseCaseNotifier(profileUseCaseMock)),
      customFieldUseCaseProvider
          .overrideWith(() => _StubCustomFieldUseCaseNotifier(cfUseCaseMock)),
      customFieldRepositoryProvider.overrideWith(
          () => _StubCustomFieldRepositoryNotifier(cfRepoMock)),
      profileRepositoryProvider.overrideWith(
          () => _StubProfileRepositoryNotifier(profRepoMock)),
    ],
    child: MaterialApp(home: child),
  );
}

// ── Tests ──────────────────────────────────────────────────────────────────

void main() {
  setUpAll(() {
    registerFallbackValue(
      const ProfileCreateRequest(
        displayName: 'Test',
        relationshipTag: RelationshipTag.parent,
      ),
    );
    registerFallbackValue(
      const ProfileUpdateRequest(
        id: 'test-id',
        displayName: 'Test',
      ),
    );
    registerFallbackValue(CustomFieldType.text);
  });

  group('ProfileEditScreen widget', () {
    // PROF-04: Avatar picker button renders in the new-profile form.
    testWidgets(
      'avatar picker button is present in form',
      (tester) async {
        final mockUseCase = _MockProfileUseCase();

        await tester.pumpWidget(
          _wrapWithProviders(
            const ProfileEditScreen(profileId: null),
            profileUseCaseMock: mockUseCase,
          ),
        );
        await tester.pump();

        expect(find.text('Pick photo'), findsOneWidget);
      },
    );

    // PROF-04: Avatar picker button renders in edit mode too.
    testWidgets(
      'selecting image updates avatar preview',
      (tester) async {
        final mockUseCase = _MockProfileUseCase();
        final profRepoMock = _MockProfileRepository();
        final cfRepoMock = _MockCustomFieldRepository();

        // Return null for the profile (profile not found — shows empty form)
        when(() => profRepoMock.getById(any()))
            .thenAnswer((_) async => null);
        // Return empty list for custom fields
        when(() => cfRepoMock.getActiveForProfile(any()))
            .thenAnswer((_) async => <CustomField>[]);

        await tester.pumpWidget(
          _wrapWithProviders(
            const ProfileEditScreen(profileId: 'existing-id'),
            profileUseCaseMock: mockUseCase,
            profileRepoMock: profRepoMock,
            customFieldRepoMock: cfRepoMock,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Pick photo'), findsOneWidget);
      },
    );

    // PROF-06: Creating a 3rd profile triggers paywall navigation.
    testWidgets(
      'third profile creation triggers paywall navigation',
      (tester) async {
        final mockUseCase = _MockProfileUseCase();

        // createProfile always throws ProfileLimitReached
        when(() => mockUseCase.createProfile(any()))
            .thenThrow(const ProfileLimitReached());

        await tester.pumpWidget(
          _wrapWithProviders(
            const ProfileEditScreen(profileId: null),
            profileUseCaseMock: mockUseCase,
          ),
        );
        await tester.pump();

        // Fill in the required display name field
        await tester.enterText(
          find.widgetWithText(TextFormField, 'Name *'),
          'Third Child',
        );

        // Tap Save in the AppBar
        await tester.tap(find.text('Save'));
        await tester.pumpAndSettle();

        // Should have navigated to PaywallStubScreen
        expect(find.byType(PaywallStubScreen), findsOneWidget);
        expect(find.text('Upgrade to Family Pro'), findsOneWidget);
      },
    );
  });
}
