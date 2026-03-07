// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_provider.dart';

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

/// See also [appDatabase].
@ProviderFor(appDatabase)
const appDatabaseProvider = AppDatabaseProvider._();

/// See also [appDatabase].
class AppDatabaseProvider
    extends AsyncNotifierProviderImpl<AppDatabaseNotifier, AppDatabase> {
  const AppDatabaseProvider._()
      : super(
          () => AppDatabaseNotifier(),
          from: null,
          argument: null,
          dependencies: null,
          allTransitiveDependencies: null,
          debugGetCreateSourceHash: null,
          name: r'appDatabaseProvider',
        );

  @override
  bool runNotifierBuildWhenUserNotifierProviderIsUsed(
      AsyncNotifierProviderRef<AppDatabase> ref) {
    return true;
  }
}

/// See also [appDatabase].
class AppDatabaseNotifier extends BuildlessAsyncNotifier<AppDatabase> {
  late final Ref _ref;

  @override
  FutureOr<AppDatabase> build() {
    _ref = ref;
    return appDatabase(_ref);
  }
}

/// See also [profileRepository].
@ProviderFor(profileRepository)
const profileRepositoryProvider = ProfileRepositoryProvider._();

/// See also [profileRepository].
class ProfileRepositoryProvider extends AsyncNotifierProviderImpl<
    ProfileRepositoryNotifier, ProfileRepository> {
  const ProfileRepositoryProvider._()
      : super(
          () => ProfileRepositoryNotifier(),
          from: null,
          argument: null,
          dependencies: null,
          allTransitiveDependencies: null,
          debugGetCreateSourceHash: null,
          name: r'profileRepositoryProvider',
        );

  @override
  bool runNotifierBuildWhenUserNotifierProviderIsUsed(
      AsyncNotifierProviderRef<ProfileRepository> ref) {
    return true;
  }
}

/// See also [profileRepository].
class ProfileRepositoryNotifier
    extends BuildlessAsyncNotifier<ProfileRepository> {
  late final Ref _ref;

  @override
  FutureOr<ProfileRepository> build() {
    _ref = ref;
    return profileRepository(_ref);
  }
}

/// See also [customFieldRepository].
@ProviderFor(customFieldRepository)
const customFieldRepositoryProvider = CustomFieldRepositoryProvider._();

/// See also [customFieldRepository].
class CustomFieldRepositoryProvider extends AsyncNotifierProviderImpl<
    CustomFieldRepositoryNotifier, CustomFieldRepository> {
  const CustomFieldRepositoryProvider._()
      : super(
          () => CustomFieldRepositoryNotifier(),
          from: null,
          argument: null,
          dependencies: null,
          allTransitiveDependencies: null,
          debugGetCreateSourceHash: null,
          name: r'customFieldRepositoryProvider',
        );

  @override
  bool runNotifierBuildWhenUserNotifierProviderIsUsed(
      AsyncNotifierProviderRef<CustomFieldRepository> ref) {
    return true;
  }
}

/// See also [customFieldRepository].
class CustomFieldRepositoryNotifier
    extends BuildlessAsyncNotifier<CustomFieldRepository> {
  late final Ref _ref;

  @override
  FutureOr<CustomFieldRepository> build() {
    _ref = ref;
    return customFieldRepository(_ref);
  }
}
