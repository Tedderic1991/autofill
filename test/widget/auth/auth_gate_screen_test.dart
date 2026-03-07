// Widget tests for AuthGateScreen
//
// Tests: Unlock button is present, error messages for PlatformException codes
//        are not shown by default, and the screen renders without crashing.
//
// Note: local_auth biometric prompt is a system dialog — not testable in widget
// tests. We test the UI structure and error message display state.
//
// Requirements: SEC-04

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../lib/presentation/auth_gate/auth_gate_screen.dart';
import '../../../lib/providers/auth_providers.dart';

// Stub notifier that skips the actual biometric call — auth state stays locked
// so the screen remains in its initial locked state during tests.
class _StubAuthNotifier extends AuthStateNotifier {
  @override
  AuthState build() => AuthState.locked;

  @override
  void unlock() => state = AuthState.unlocked;

  @override
  void lock() => state = AuthState.locked;
}

void main() {
  group('AuthGateScreen', () {
    Widget _buildSubject() {
      return ProviderScope(
        overrides: [
          authStateNotifierProvider
              .overrideWith(() => _StubAuthNotifier()),
        ],
        child: const MaterialApp(
          home: AuthGateScreen(),
        ),
      );
    }

    testWidgets('renders without crashing', (tester) async {
      await tester.pumpWidget(_buildSubject());
      await tester.pump(); // settle initState / post-frame callbacks
      expect(find.byType(AuthGateScreen), findsOneWidget);
    });

    testWidgets('shows Unlock button', (tester) async {
      await tester.pumpWidget(_buildSubject());
      await tester.pump();
      expect(find.widgetWithText(ElevatedButton, 'Unlock'), findsOneWidget);
    });

    testWidgets('error message area is initially empty (no error shown)',
        (tester) async {
      await tester.pumpWidget(_buildSubject());
      await tester.pump();
      // No specific error messages should be visible initially
      expect(
          find.text('Set up a screen lock in device Settings to use this app.'),
          findsNothing);
      expect(
          find.text('Too many failed attempts. Use your device PIN to unlock.'),
          findsNothing);
      expect(
          find.text(
              'Biometrics locked. Open device Settings > Security to reset.'),
          findsNothing);
    });

    testWidgets('displays app name or title text', (tester) async {
      await tester.pumpWidget(_buildSubject());
      await tester.pump();
      // Screen should show some kind of title/branding
      expect(find.text('Family Autofill'), findsOneWidget);
    });
  });
}
