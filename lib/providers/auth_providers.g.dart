// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

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

/// See also [AuthStateNotifier].
@ProviderFor(AuthStateNotifier)
const authStateNotifierProvider = AuthStateNotifierProvider._();

/// See also [AuthStateNotifier].
class AuthStateNotifierProvider
    extends NotifierProviderImpl<AuthStateNotifier, AuthState> {
  const AuthStateNotifierProvider._()
      : super(
          () => AuthStateNotifier(),
          from: null,
          argument: null,
          dependencies: null,
          allTransitiveDependencies: null,
          debugGetCreateSourceHash: null,
          name: r'authStateNotifierProvider',
        );

  @override
  AuthState runNotifierBuild(AuthStateNotifier notifier) {
    return notifier.build();
  }
}
