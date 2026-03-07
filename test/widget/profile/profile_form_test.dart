// Widget tests for ProfileForm — UI-level stubs.
//
// Requirements covered: PROF-04 (avatar picker), PROF-06 (paywall navigation)
//
// TODO: import 'package:autofill/presentation/widgets/profile_form.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProfileForm widget', () {
    // PROF-04: Avatar picker button renders in the form.
    testWidgets(
      'avatar picker button is present in form',
      (tester) => Future.value(markTestSkipped('stub')),
      skip: 'Wave 0 stub — implement after Wave 2',
    );

    // PROF-04: Selecting an image updates the avatar preview widget.
    testWidgets(
      'selecting image updates avatar preview',
      (tester) => Future.value(markTestSkipped('stub')),
      skip: 'Wave 0 stub — implement after Wave 2',
    );

    // PROF-06: Creating a 3rd profile triggers paywall navigation.
    testWidgets(
      'third profile creation triggers paywall navigation',
      (tester) => Future.value(markTestSkipped('stub')),
      skip: 'Wave 0 stub — implement after Wave 2',
    );
  });
}
