// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Manages the app-level authentication state.
///
/// Usage:
///   // Read current state:
///   final state = ref.watch(authStateNotifierProvider);
///
///   // Trigger unlock (call after local_auth authenticate() returns true):
///   ref.read(authStateNotifierProvider.notifier).unlock();
///
///   // Lock again (call on explicit sign-out or background lock):
///   ref.read(authStateNotifierProvider.notifier).lock();

@ProviderFor(AuthStateNotifier)
final authStateProvider = AuthStateNotifierProvider._();

/// Manages the app-level authentication state.
///
/// Usage:
///   // Read current state:
///   final state = ref.watch(authStateNotifierProvider);
///
///   // Trigger unlock (call after local_auth authenticate() returns true):
///   ref.read(authStateNotifierProvider.notifier).unlock();
///
///   // Lock again (call on explicit sign-out or background lock):
///   ref.read(authStateNotifierProvider.notifier).lock();
final class AuthStateNotifierProvider
    extends $NotifierProvider<AuthStateNotifier, AuthState> {
  /// Manages the app-level authentication state.
  ///
  /// Usage:
  ///   // Read current state:
  ///   final state = ref.watch(authStateNotifierProvider);
  ///
  ///   // Trigger unlock (call after local_auth authenticate() returns true):
  ///   ref.read(authStateNotifierProvider.notifier).unlock();
  ///
  ///   // Lock again (call on explicit sign-out or background lock):
  ///   ref.read(authStateNotifierProvider.notifier).lock();
  AuthStateNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'authStateProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$authStateNotifierHash();

  @$internal
  @override
  AuthStateNotifier create() => AuthStateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthState>(value),
    );
  }
}

String _$authStateNotifierHash() => r'a2089cc5a5481a4bb3771f996381ff7a4a4f77ae';

/// Manages the app-level authentication state.
///
/// Usage:
///   // Read current state:
///   final state = ref.watch(authStateNotifierProvider);
///
///   // Trigger unlock (call after local_auth authenticate() returns true):
///   ref.read(authStateNotifierProvider.notifier).unlock();
///
///   // Lock again (call on explicit sign-out or background lock):
///   ref.read(authStateNotifierProvider.notifier).lock();

abstract class _$AuthStateNotifier extends $Notifier<AuthState> {
  AuthState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AuthState, AuthState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AuthState, AuthState>, AuthState, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}
