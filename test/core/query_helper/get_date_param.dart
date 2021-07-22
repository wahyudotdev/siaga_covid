import 'package:clock/clock.dart';
import 'package:covid_statistics/core/query_helper/date_param_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Timestamp on 21 Jul 2021 08:00
  final epoch = 1626829200000;
  test(
    'should return a list of string containing date in week range (MM-dd-yyyy)',
    () async {
      // arrange
      final expected = [
        '07-14-2021',
        '07-15-2021',
        '07-16-2021',
        '07-17-2021',
        '07-18-2021',
        '07-19-2021',
        '07-20-2021'
      ];
      // act
      final result = withClock(
          Clock.fixed(DateTime.fromMillisecondsSinceEpoch(epoch)),
          () => GetDateParam().daysOfWeek());
      // assert
      expect(result, equals(expected));
    },
  );
}
