// Paywall stub screen — shown when ProfileLimitReached is thrown.
//
// Phase 1 stub: the Upgrade button is a no-op that shows a SnackBar.
// Phase 4 replaces the button body with a RevenueCat purchase flow.
//
// Requirements: PROF-06 (freemium cap — upgrade path visible when hit)

import 'package:flutter/material.dart';

/// Stub paywall screen shown when the free-tier profile limit is reached.
///
/// The "Upgrade" button is intentionally a no-op in Phase 1. Phase 4 will
/// replace the button's onPressed body with a RevenueCat purchase flow.
class PaywallStubScreen extends StatelessWidget {
  const PaywallStubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upgrade'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.star_border_rounded,
              size: 80,
              color: Colors.amber,
            ),
            const SizedBox(height: 24),
            Text(
              'Upgrade to Family Pro',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Free plan is limited to 2 family profiles. '
              'Upgrade to add unlimited profiles.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  // TODO(phase4): Replace with RevenueCat purchase flow.
                  // ignore: avoid_print
                  debugPrint('TODO phase4: launch RevenueCat upgrade flow');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Coming in a future update'),
                    ),
                  );
                },
                child: const Text('Upgrade'),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Maybe later'),
            ),
          ],
        ),
      ),
    );
  }
}
