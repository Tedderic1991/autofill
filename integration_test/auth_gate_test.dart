// Integration tests for the biometric auth gate.
//
// NOTE: These tests require a physical device with biometric hardware.
// They cannot run on the simulator/emulator or in CI without a device.
//
// TODO: import 'package:autofill/presentation/screens/auth_gate_screen.dart';
// TODO: import 'package:integration_test/integration_test.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthGate integration', () {
    // App starts locked — profile list not yet visible.
    test(
      'app starts in locked state — profile list not visible',
      () => markTestSkipped('stub'),
      skip: 'Wave 0 stub — physical device only',
    );

    // Successful biometric auth transitions to profile list.
    test(
      'successful biometric auth shows profile list',
      () => markTestSkipped('stub'),
      skip: 'Wave 0 stub — physical device only',
    );

    // Failed biometric offers PIN fallback.
    test(
      'failed biometric shows PIN fallback option',
      () => markTestSkipped('stub'),
      skip: 'Wave 0 stub — physical device only',
    );
  });
}
