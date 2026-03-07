// Tests for ProfileUseCase — business rules on top of ProfileRepository.
//
// Requirements covered: PROF-06 (freemium profile cap)
//
// TODO: import 'package:autofill/domain/usecases/profile_usecase.dart';
// TODO: import 'package:autofill/data/repositories/profile_repository.dart';
// TODO: import '../../helpers/in_memory_database.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProfileUseCase', () {
    // PROF-06: Free tier allows up to 2 profiles.
    test(
      'createProfile succeeds when count < 2 on free tier',
      () => markTestSkipped('stub'),
      skip: 'Wave 0 stub — implement after Wave 1',
    );

    // PROF-06: Free tier blocks 3rd profile creation.
    test(
      'createProfile returns ProfileLimitReached when count == 2 on free tier',
      () => markTestSkipped('stub'),
      skip: 'Wave 0 stub — implement after Wave 1',
    );

    // PROF-06: Paid tier has no 2-profile cap.
    test(
      'createProfile succeeds when count == 2 on paid tier',
      () => markTestSkipped('stub'),
      skip: 'Wave 0 stub — implement after Wave 1',
    );
  });
}
