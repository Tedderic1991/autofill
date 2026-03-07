// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_providers.dart';

// ignore_for_file: type=lint
// **************************************************************************
// NOTE: This file was hand-authored because build_runner cannot run in the
// current environment (Flutter/Dart SDK not installed). When Flutter SDK is
// available, regenerate by running:
//   flutter pub run build_runner build --delete-conflicting-outputs
// **************************************************************************

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// See also [profileList].
@ProviderFor(profileList)
const profileListProvider = ProfileListProvider._();

/// See also [profileList].
class ProfileListProvider
    extends StreamNotifierProviderImpl<ProfileListNotifier, List<FamilyProfile>> {
  const ProfileListProvider._()
      : super(
          () => ProfileListNotifier(),
          from: null,
          argument: null,
          dependencies: null,
          allTransitiveDependencies: null,
          debugGetCreateSourceHash: null,
          name: r'profileListProvider',
        );
}

/// See also [profileList].
class ProfileListNotifier
    extends BuildlessStreamNotifier<List<FamilyProfile>> {
  late final Ref _ref;

  @override
  Stream<List<FamilyProfile>> build() {
    _ref = ref;
    return profileList(_ref);
  }
}

/// See also [profileUseCase].
@ProviderFor(profileUseCase)
const profileUseCaseProvider = ProfileUseCaseProvider._();

/// See also [profileUseCase].
class ProfileUseCaseProvider
    extends AsyncNotifierProviderImpl<ProfileUseCaseNotifier, ProfileUseCase> {
  const ProfileUseCaseProvider._()
      : super(
          () => ProfileUseCaseNotifier(),
          from: null,
          argument: null,
          dependencies: null,
          allTransitiveDependencies: null,
          debugGetCreateSourceHash: null,
          name: r'profileUseCaseProvider',
        );

  @override
  bool runNotifierBuildWhenUserNotifierProviderIsUsed(
      AsyncNotifierProviderRef<ProfileUseCase> ref) {
    return true;
  }
}

/// See also [profileUseCase].
class ProfileUseCaseNotifier extends BuildlessAsyncNotifier<ProfileUseCase> {
  late final Ref _ref;

  @override
  FutureOr<ProfileUseCase> build() {
    _ref = ref;
    return profileUseCase(_ref);
  }
}

/// See also [customFieldUseCase].
@ProviderFor(customFieldUseCase)
const customFieldUseCaseProvider = CustomFieldUseCaseProvider._();

/// See also [customFieldUseCase].
class CustomFieldUseCaseProvider
    extends AsyncNotifierProviderImpl<CustomFieldUseCaseNotifier, CustomFieldUseCase> {
  const CustomFieldUseCaseProvider._()
      : super(
          () => CustomFieldUseCaseNotifier(),
          from: null,
          argument: null,
          dependencies: null,
          allTransitiveDependencies: null,
          debugGetCreateSourceHash: null,
          name: r'customFieldUseCaseProvider',
        );

  @override
  bool runNotifierBuildWhenUserNotifierProviderIsUsed(
      AsyncNotifierProviderRef<CustomFieldUseCase> ref) {
    return true;
  }
}

/// See also [customFieldUseCase].
class CustomFieldUseCaseNotifier
    extends BuildlessAsyncNotifier<CustomFieldUseCase> {
  late final Ref _ref;

  @override
  FutureOr<CustomFieldUseCase> build() {
    _ref = ref;
    return customFieldUseCase(_ref);
  }
}
