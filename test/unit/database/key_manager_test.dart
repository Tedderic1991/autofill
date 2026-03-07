// Tests for KeyManager — SEC-04 key generation and retrieval.
//
// Covers:
// - KeyManager.getOrCreateKey() returns a base64url string of length > 0
// - KeyManager.getOrCreateKey() called twice returns the same key
// - KeyManager.hasKey() returns false when storage is empty
// - KeyManager.hasKey() returns true after getOrCreateKey() is called

import 'package:autofill/data/security/key_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  group('KeyManager', () {
    late MockFlutterSecureStorage mockStorage;
    late KeyManager keyManager;

    setUp(() {
      mockStorage = MockFlutterSecureStorage();
      keyManager = KeyManager(mockStorage);
    });

    test(
      'hasKey() returns false when storage is empty',
      () async {
        when(() => mockStorage.read(key: any(named: 'key')))
            .thenAnswer((_) async => null);

        final result = await keyManager.hasKey();

        expect(result, isFalse);
      },
    );

    test(
      'getOrCreateKey() returns a base64url string of length > 0',
      () async {
        // Simulate no existing key, then storage write succeeds
        when(() => mockStorage.read(key: any(named: 'key')))
            .thenAnswer((_) async => null);
        when(
          () => mockStorage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        ).thenAnswer((_) async {});

        final key = await keyManager.getOrCreateKey();

        expect(key, isNotEmpty);
        // base64url encoding of 32 bytes produces exactly 44 chars (with padding)
        // or 43 chars (without padding) — always > 0
        expect(key.length, greaterThan(0));
        // Verify it only contains valid base64url characters
        expect(key, matches(RegExp(r'^[A-Za-z0-9\-_=]+$')));
      },
    );

    test(
      'getOrCreateKey() called twice returns the same key',
      () async {
        String? storedValue;

        // First call: read returns null, write stores the key
        when(() => mockStorage.read(key: any(named: 'key'))).thenAnswer(
          (_) async => storedValue,
        );
        when(
          () => mockStorage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        ).thenAnswer((invocation) async {
          storedValue =
              invocation.namedArguments[const Symbol('value')] as String;
        });

        final key1 = await keyManager.getOrCreateKey();
        final key2 = await keyManager.getOrCreateKey();

        expect(key1, equals(key2));
      },
    );

    test(
      'hasKey() returns true after getOrCreateKey() is called',
      () async {
        String? storedValue;

        when(() => mockStorage.read(key: any(named: 'key'))).thenAnswer(
          (_) async => storedValue,
        );
        when(
          () => mockStorage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        ).thenAnswer((invocation) async {
          storedValue =
              invocation.namedArguments[const Symbol('value')] as String;
        });

        expect(await keyManager.hasKey(), isFalse);
        await keyManager.getOrCreateKey();
        expect(await keyManager.hasKey(), isTrue);
      },
    );
  });
}
