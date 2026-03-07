// Tests for SEC-04: database encryption at rest via KeyManager + Drift.
//
// TODO: import 'package:autofill/data/database/key_manager.dart';
// TODO: import 'package:autofill/data/database/app_database.dart';
// TODO: import '../../helpers/in_memory_database.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SEC-04 encryption', () {
    test(
      'KeyManager generates a 32-byte base64 key on first call',
      () => markTestSkipped('stub'),
      skip: 'Wave 0 stub — implement after Wave 1',
    );

    test(
      'KeyManager returns the same key on subsequent calls',
      () => markTestSkipped('stub'),
      skip: 'Wave 0 stub — implement after Wave 1',
    );

    test(
      'AppDatabase opens successfully with valid key',
      () => markTestSkipped('stub'),
      skip: 'Wave 0 stub — implement after Wave 1',
    );

    test(
      'AppDatabase fails to open (or returns empty) when opened without correct key',
      () => markTestSkipped('stub'),
      skip: 'Wave 0 stub — implement after Wave 1',
    );
  });
}
