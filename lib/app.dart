// App root widget — configures MaterialApp.router with go_router.
//
// Auth guard: the go_router redirect closure checks authStateNotifierProvider.
// A ProviderChangeNotifier bridges Riverpod state into GoRouter's
// refreshListenable so the router re-evaluates its redirect whenever
// the auth state changes (locked ↔ unlocked).
//
// Routes:
//   /auth                → AuthGateScreen (public)
//   /profiles            → ProfileListScreen (auth-gated)
//   /profiles/new        → ProfileEditScreen (create, auth-gated)
//   /profiles/:id/edit   → ProfileEditScreen (edit, auth-gated)
//   /paywall             → PaywallStubScreen (auth-gated)
//
// Requirements: SEC-04 (no profile screen reachable without authentication)

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'presentation/auth_gate/auth_gate_screen.dart';
import 'presentation/paywall/paywall_stub_screen.dart';
import 'presentation/profiles/profile_edit_screen.dart';
import 'presentation/profiles/profile_list_screen.dart';
import 'providers/auth_providers.dart';

// ── ProviderChangeNotifier bridge ──────────────────────────────────────────
//
// GoRouter's refreshListenable expects a ChangeNotifier. This class wraps a
// Riverpod ProviderSubscription and calls notifyListeners() whenever the
// watched provider emits a new value. GoRouter then re-runs its redirect.

class _ProviderChangeNotifier<T> extends ChangeNotifier {
  _ProviderChangeNotifier(ProviderContainer container, ProviderListenable<T> provider) {
    _subscription = container.listen<T>(provider, (_, __) => notifyListeners());
  }

  late final ProviderSubscription<T> _subscription;

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}

// ── AutofillApp ─────────────────────────────────────────────────────────────

class AutofillApp extends ConsumerStatefulWidget {
  const AutofillApp({super.key});

  @override
  ConsumerState<AutofillApp> createState() => _AutofillAppState();
}

class _AutofillAppState extends ConsumerState<AutofillApp> {
  late final GoRouter _router;
  late final _ProviderChangeNotifier<AuthState> _authChangeNotifier;

  @override
  void initState() {
    super.initState();

    // Build the refreshListenable bridge using the ProviderContainer from the
    // enclosing ProviderScope (accessible via ProviderScope.containerOf).
    // We defer actual construction to didChangeDependencies so the context is
    // ready.
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Guard: only create the router once.
    if (!_routerInitialized) {
      _initRouter();
    }
  }

  bool _routerInitialized = false;

  void _initRouter() {
    _routerInitialized = true;
    final container = ProviderScope.containerOf(context);
    _authChangeNotifier = _ProviderChangeNotifier<AuthState>(
      container,
      authStateNotifierProvider,
    );

    _router = GoRouter(
      initialLocation: '/auth',
      refreshListenable: _authChangeNotifier,
      redirect: (context, state) {
        final authState = container.read(authStateNotifierProvider);
        final isLocked = authState == AuthState.locked;
        final isAuthRoute = state.matchedLocation == '/auth';

        // Unauthenticated user trying to reach a gated route → send to /auth.
        if (isLocked && !isAuthRoute) return '/auth';

        // Authenticated user on the auth screen → redirect to /profiles.
        if (!isLocked && isAuthRoute) return '/profiles';

        // No redirect needed.
        return null;
      },
      routes: [
        GoRoute(
          path: '/auth',
          builder: (_, __) => const AuthGateScreen(),
        ),
        GoRoute(
          path: '/profiles',
          builder: (_, __) => const ProfileListScreen(),
        ),
        GoRoute(
          path: '/profiles/new',
          builder: (_, __) => const ProfileEditScreen(profileId: null),
        ),
        GoRoute(
          path: '/profiles/:id/edit',
          builder: (_, state) => ProfileEditScreen(
            profileId: state.pathParameters['id'],
          ),
        ),
        GoRoute(
          path: '/paywall',
          builder: (_, __) => const PaywallStubScreen(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _authChangeNotifier.dispose();
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Family Autofill',
      routerConfig: _router,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
    );
  }
}
