import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/repositories/counter_repository.dart';

void main() {
  group(
    'Counter Class - ',
    () {
      late Counter counter;

      setUp(() {
        counter = Counter();
      });
      test(
        'given counter class, when a new instance is created, then the value of count variable should be 0',
        () {
          //arrange
          //act
          final val = counter.count;
          //assert
          expect(val, 0);
        },
      );

      test(
        'given counter class, when increment function is called, then the value of count variable should be 1',
        () {
          //arrange
          //act
          counter.increment();
          final val = counter.count;
          //assert
          expect(val, 1);
        },
      );

      test(
        'given counter class, when decrement function is called, then the value of count variable should be -1',
        () {
          //arrange
          //act
          counter.decrement();
          final val = counter.count;
          //assert
          expect(val, -1);
        },
      );

      test(
        'given counter class, when reset function is called, then the count variable should be 0',
        () {
          counter.reset();
          final val = counter.count;
          expect(val, 0);
        },
      );

      test(
        'given counter class, when isPositive function is called, then it should return true if count variable is greater than zero and false otherwise',
        () {
          counter.increment();
          bool isPositive = counter.isPositive();
          expect(isPositive, true);
          counter.decrement();
          isPositive = counter.isPositive();
          expect(isPositive, false);
        },
      );
    },
  );
}
