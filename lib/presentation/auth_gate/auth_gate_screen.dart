// Auth gate screen — shown on every cold start before profile data is visible.
//
// Auto-triggers the biometric/PIN prompt on mount via initState -> _triggerAuth().
// Also shows an Unlock button so the user can retry after dismissing the prompt.
//
// PlatformException codes handled (from local_auth — see PITFALLS.md Pitfall 7):
//   'NotEnrolled'          → guidance to set up device screen lock
//   'LockedOut'            → too many attempts, use device PIN
//   'PermanentlyLockedOut' → open device Settings to reset
//   default                → generic retry message
//
// On successful authentication: calls authStateNotifierProvider.notifier.unlock()
// which triggers go_router's redirect to /profiles.
//
// Requirements: SEC-04

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

import '../../providers/auth_providers.dart';

/// Auth gate — shown when [AuthState] is [AuthState.locked].
///
/// Auto-triggers biometric/PIN prompt on mount.
/// Shows an Unlock button for manual retry.
/// Handles all [PlatformException] error codes with user-facing messages.
class AuthGateScreen extends ConsumerStatefulWidget {
  const AuthGateScreen({super.key});

  @override
  ConsumerState<AuthGateScreen> createState() => _AuthGateScreenState();
}

class _AuthGateScreenState extends ConsumerState<AuthGateScreen> {
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Auto-trigger on mount — avoids requiring an extra tap on first open.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _triggerAuth();
    });
  }

  // ── Biometric / PIN prompt ──────────────────────────────────────────────

  Future<void> _triggerAuth() async {
    // Clear any previous error before attempting again.
    if (mounted) setState(() => _errorMessage = null);

    final auth = LocalAuthentication();

    // Check if device supports any form of authentication.
    final isSupported = await auth.isDeviceSupported();

    if (!isSupported) {
      // Device has no lock screen at all — allow access.
      // This is an edge case (e.g., emulator with no security set up).
      ref.read(authStateProvider.notifier).unlock();
      return;
    }

    try {
      final authenticated = await auth.authenticate(
        localizedReason: 'Unlock your family profiles',
        biometricOnly: false, // REQUIRED — enables PIN/pattern fallback
        persistAcrossBackgrounding: true, // Don't cancel when app backgrounds
      );
      if (authenticated) {
        ref.read(authStateProvider.notifier).unlock();
      }
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'NotEnrolled':
          _showError(
              'Set up a screen lock in device Settings to use this app.');
          break;
        case 'LockedOut':
          _showError(
              'Too many failed attempts. Use your device PIN to unlock.');
          break;
        case 'PermanentlyLockedOut':
          _showError(
              'Biometrics locked. Open device Settings > Security to reset.');
          break;
        default:
          _showError('Authentication failed. Tap Unlock to try again.');
      }
    }
  }

  void _showError(String message) {
    if (mounted) {
      setState(() => _errorMessage = message);
    }
  }

  // ── Build ───────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // App icon / branding
                const Icon(
                  Icons.lock_outline,
                  size: 72,
                  color: Colors.blueGrey,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Family Autofill',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Authenticate to access your family profiles',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 40),

                // Unlock button — also serves as retry after dismissal
                ElevatedButton.icon(
                  onPressed: _triggerAuth,
                  icon: const Icon(Icons.fingerprint),
                  label: const Text('Unlock'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 48),
                  ),
                ),

                // Error message area — shown only when a PlatformException occurs
                if (_errorMessage != null) ...[
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .errorContainer
                          .withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _errorMessage!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
