import 'package:covid_statistics/features/statistics/data/models/covid_summary_model.dart';
import 'package:covid_statistics/features/statistics/domain/entities/covid_statistics.dart';
import 'package:covid_statistics/features/statistics/domain/entities/covid_summary.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy/covid_statistics_dummy.dart';
import '../../dummy/covid_summary_dummy.dart';

void main() {
  test(
    'should be a subclass of CovidSummary entities',
    () => expect(tCovidSummaryModel, isA<CovidSummary>()),
  );

  test(
    'should return an instance of [CovidSummaryModel] world data when provided with List<CovidStatistics> and country not provided',
    () async {
      // arrange
      List<CovidStatistics> list = [
        tCovidStatistics,
        tCovidStatistics,
        tCovidStatistics
      ];
      // act
      final result = CovidSummaryModel.fromStatistics(statistics: list);
      final item = tCovidStatistics.items.first;
      final expected = CovidSummaryModel(
        confirmed: (item.confirmed * tCovidStatistics.items.length).toString(),
        active: (item.active * tCovidStatistics.items.length).toString(),
        deaths: (item.deaths * tCovidStatistics.items.length).toString(),
        recovered: (item.recovered * tCovidStatistics.items.length).toString(),
      );
      // assert
      expect(result, equals(expected));
    },
  );

  test(
    'should return an instance of [CovidSummary] country Test data when provided with List<CovidStatistics> and country=Test',
    () async {
      // arrange
      List<CovidStatistics> list = [
        tCovidStatistics,
        tCovidStatistics,
        tCovidStatistics
      ];
      final tCountry = 'Test';
      // act
      final result =
          CovidSummaryModel.fromStatistics(statistics: list, country: tCountry);
      final item = tCovidStatistics.items
          .firstWhere((element) => element.countryRegion == tCountry);
      final expected = CovidSummaryModel(
        confirmed: item.confirmed.toString(),
        active: item.active.toString(),
        deaths: item.deaths.toString(),
        recovered: item.recovered.toString(),
      );
      // assert
      expect(result, equals(expected));
    },
  );
}
