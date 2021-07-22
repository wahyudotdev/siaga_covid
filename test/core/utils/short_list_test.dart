import 'package:covid_statistics/core/utils/short_list.dart';
import 'package:covid_statistics/features/statistics/domain/entities/covid_statistics.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final shortlist = ShortList();
  final epoch = 1626939881000;
  final dateTimeRandom = [
    DateTime.fromMillisecondsSinceEpoch(epoch),
    DateTime.fromMillisecondsSinceEpoch(epoch).subtract(Duration(days: 2)),
    DateTime.fromMillisecondsSinceEpoch(epoch).subtract(Duration(days: 1)),
  ];
  final dateTimeShorted = [
    DateTime.fromMillisecondsSinceEpoch(epoch).subtract(Duration(days: 2)),
    DateTime.fromMillisecondsSinceEpoch(epoch).subtract(Duration(days: 1)),
    DateTime.fromMillisecondsSinceEpoch(epoch),
  ];
  test(
    'should return a shorted list when there is a bunch of List<CovidStatistics> comes in',
    () async {
      // arrange
      final randomData = dateTimeRandom
          .map((e) => CovidStatistics([
                CovidStatisticItem(
                  countryRegion: 'countryRegion',
                  lastUpdate: e,
                  confirmed: 100,
                  deaths: 100,
                  recovered: 100,
                  active: 100,
                )
              ]))
          .toList();
      // act
      final result = shortlist.shortByDate(randomData);
      // assert
      final expected = dateTimeShorted
          .map((e) => CovidStatistics([
                CovidStatisticItem(
                  countryRegion: 'countryRegion',
                  lastUpdate: e,
                  confirmed: 100,
                  deaths: 100,
                  recovered: 100,
                  active: 100,
                )
              ]))
          .toList();
      expect(result, equals(expected));
    },
  );
}
