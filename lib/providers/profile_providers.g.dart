// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Live stream of active (non-deleted) profiles, sorted by displayName.
///
/// Emits a new list whenever any profile is inserted, updated, or soft-deleted.
/// UI widgets that display a profile list should subscribe via:
///   ref.watch(profileListProvider)

@ProviderFor(profileList)
final profileListProvider = ProfileListProvider._();

/// Live stream of active (non-deleted) profiles, sorted by displayName.
///
/// Emits a new list whenever any profile is inserted, updated, or soft-deleted.
/// UI widgets that display a profile list should subscribe via:
///   ref.watch(profileListProvider)

final class ProfileListProvider extends $FunctionalProvider<
        AsyncValue<List<FamilyProfile>>,
        List<FamilyProfile>,
        Stream<List<FamilyProfile>>>
    with
        $FutureModifier<List<FamilyProfile>>,
        $StreamProvider<List<FamilyProfile>> {
  /// Live stream of active (non-deleted) profiles, sorted by displayName.
  ///
  /// Emits a new list whenever any profile is inserted, updated, or soft-deleted.
  /// UI widgets that display a profile list should subscribe via:
  ///   ref.watch(profileListProvider)
  ProfileListProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'profileListProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$profileListHash();

  @$internal
  @override
  $StreamProviderElement<List<FamilyProfile>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<FamilyProfile>> create(Ref ref) {
    return profileList(ref);
  }
}

String _$profileListHash() => r'6841ae1ef82eb4cdd545e656dfb3bf16944db82a';

/// Use case provider for profile mutations.
///
/// keepAlive: true — the use case has no disposable resources and should
/// remain alive for the app session.
///
/// Usage:
///   final useCase = await ref.read(profileUseCaseProvider.future);
///   await useCase.createProfile(request);

@ProviderFor(profileUseCase)
final profileUseCaseProvider = ProfileUseCaseProvider._();

/// Use case provider for profile mutations.
///
/// keepAlive: true — the use case has no disposable resources and should
/// remain alive for the app session.
///
/// Usage:
///   final useCase = await ref.read(profileUseCaseProvider.future);
///   await useCase.createProfile(request);

final class ProfileUseCaseProvider extends $FunctionalProvider<
        AsyncValue<ProfileUseCase>, ProfileUseCase, FutureOr<ProfileUseCase>>
    with $FutureModifier<ProfileUseCase>, $FutureProvider<ProfileUseCase> {
  /// Use case provider for profile mutations.
  ///
  /// keepAlive: true — the use case has no disposable resources and should
  /// remain alive for the app session.
  ///
  /// Usage:
  ///   final useCase = await ref.read(profileUseCaseProvider.future);
  ///   await useCase.createProfile(request);
  ProfileUseCaseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'profileUseCaseProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$profileUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<ProfileUseCase> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<ProfileUseCase> create(Ref ref) {
    return profileUseCase(ref);
  }
}

String _$profileUseCaseHash() => r'a47901282e55c4bf38f286035fef16ef92ea0671';

/// Use case provider for custom field mutations.
///
/// keepAlive: true — the use case has no disposable resources and should
/// remain alive for the app session.
///
/// Usage:
///   final useCase = await ref.read(customFieldUseCaseProvider.future);
///   await useCase.addField(profileId, label, type);

@ProviderFor(customFieldUseCase)
final customFieldUseCaseProvider = CustomFieldUseCaseProvider._();

/// Use case provider for custom field mutations.
///
/// keepAlive: true — the use case has no disposable resources and should
/// remain alive for the app session.
///
/// Usage:
///   final useCase = await ref.read(customFieldUseCaseProvider.future);
///   await useCase.addField(profileId, label, type);

final class CustomFieldUseCaseProvider extends $FunctionalProvider<
        AsyncValue<CustomFieldUseCase>,
        CustomFieldUseCase,
        FutureOr<CustomFieldUseCase>>
    with
        $FutureModifier<CustomFieldUseCase>,
        $FutureProvider<CustomFieldUseCase> {
  /// Use case provider for custom field mutations.
  ///
  /// keepAlive: true — the use case has no disposable resources and should
  /// remain alive for the app session.
  ///
  /// Usage:
  ///   final useCase = await ref.read(customFieldUseCaseProvider.future);
  ///   await useCase.addField(profileId, label, type);
  CustomFieldUseCaseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'customFieldUseCaseProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$customFieldUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<CustomFieldUseCase> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<CustomFieldUseCase> create(Ref ref) {
    return customFieldUseCase(ref);
  }
}

String _$customFieldUseCaseHash() =>
    r'27f605903e8459b9c49a6dd6710a76885953b02f';
