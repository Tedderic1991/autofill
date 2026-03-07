// Unit tests for AuthStateNotifier (auth_providers.dart)
//
// Tests: AuthState starts locked, unlock() transitions to unlocked,
//        lock() transitions back to locked.
//
// Requirements: SEC-04

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../lib/providers/auth_providers.dart';

void main() {
  group('AuthStateNotifier', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is locked', () {
      final state = container.read(authStateNotifierProvider);
      expect(state, AuthState.locked);
    });

    test('unlock() transitions state to unlocked', () {
      container.read(authStateNotifierProvider.notifier).unlock();
      final state = container.read(authStateNotifierProvider);
      expect(state, AuthState.unlocked);
    });

    test('lock() transitions state back to locked', () {
      // First unlock
      container.read(authStateNotifierProvider.notifier).unlock();
      expect(container.read(authStateNotifierProvider), AuthState.unlocked);

      // Then lock
      container.read(authStateNotifierProvider.notifier).lock();
      expect(container.read(authStateNotifierProvider), AuthState.locked);
    });

    test('multiple unlock() calls keep state unlocked', () {
      container.read(authStateNotifierProvider.notifier).unlock();
      container.read(authStateNotifierProvider.notifier).unlock();
      expect(container.read(authStateNotifierProvider), AuthState.unlocked);
    });
  });
}
