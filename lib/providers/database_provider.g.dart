// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Riverpod provider for the encrypted [AppDatabase].
///
/// Opens the database exactly once per app session (keepAlive: true).
/// Retrieves the encryption key from Android Keystore via [KeyManager]
/// before calling [openEncryptedDatabase].
///
/// On widget disposal, the database is closed via [ref.onDispose].

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

/// Riverpod provider for the encrypted [AppDatabase].
///
/// Opens the database exactly once per app session (keepAlive: true).
/// Retrieves the encryption key from Android Keystore via [KeyManager]
/// before calling [openEncryptedDatabase].
///
/// On widget disposal, the database is closed via [ref.onDispose].

final class AppDatabaseProvider extends $FunctionalProvider<
        AsyncValue<AppDatabase>, AppDatabase, FutureOr<AppDatabase>>
    with $FutureModifier<AppDatabase>, $FutureProvider<AppDatabase> {
  /// Riverpod provider for the encrypted [AppDatabase].
  ///
  /// Opens the database exactly once per app session (keepAlive: true).
  /// Retrieves the encryption key from Android Keystore via [KeyManager]
  /// before calling [openEncryptedDatabase].
  ///
  /// On widget disposal, the database is closed via [ref.onDispose].
  AppDatabaseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'appDatabaseProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $FutureProviderElement<AppDatabase> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<AppDatabase> create(Ref ref) {
    return appDatabase(ref);
  }
}

String _$appDatabaseHash() => r'875675436f6f3c7f865137ea8bf4fd0ecb43127f';

/// Riverpod provider for [ProfileRepository].
///
/// Depends on [appDatabaseProvider]. keepAlive matches the DB lifetime.

@ProviderFor(profileRepository)
final profileRepositoryProvider = ProfileRepositoryProvider._();

/// Riverpod provider for [ProfileRepository].
///
/// Depends on [appDatabaseProvider]. keepAlive matches the DB lifetime.

final class ProfileRepositoryProvider extends $FunctionalProvider<
        AsyncValue<ProfileRepository>,
        ProfileRepository,
        FutureOr<ProfileRepository>>
    with
        $FutureModifier<ProfileRepository>,
        $FutureProvider<ProfileRepository> {
  /// Riverpod provider for [ProfileRepository].
  ///
  /// Depends on [appDatabaseProvider]. keepAlive matches the DB lifetime.
  ProfileRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'profileRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$profileRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<ProfileRepository> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<ProfileRepository> create(Ref ref) {
    return profileRepository(ref);
  }
}

String _$profileRepositoryHash() => r'bc70640d66e9f9fbbab762920a1aff258a0ce5fa';

/// Riverpod provider for [CustomFieldRepository].
///
/// Depends on [appDatabaseProvider]. keepAlive matches the DB lifetime.

@ProviderFor(customFieldRepository)
final customFieldRepositoryProvider = CustomFieldRepositoryProvider._();

/// Riverpod provider for [CustomFieldRepository].
///
/// Depends on [appDatabaseProvider]. keepAlive matches the DB lifetime.

final class CustomFieldRepositoryProvider extends $FunctionalProvider<
        AsyncValue<CustomFieldRepository>,
        CustomFieldRepository,
        FutureOr<CustomFieldRepository>>
    with
        $FutureModifier<CustomFieldRepository>,
        $FutureProvider<CustomFieldRepository> {
  /// Riverpod provider for [CustomFieldRepository].
  ///
  /// Depends on [appDatabaseProvider]. keepAlive matches the DB lifetime.
  CustomFieldRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'customFieldRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$customFieldRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<CustomFieldRepository> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<CustomFieldRepository> create(Ref ref) {
    return customFieldRepository(ref);
  }
}

String _$customFieldRepositoryHash() =>
    r'19e637b5ff41c23aa25ab9a3698ef79e89543200';
