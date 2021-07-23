import 'dart:convert';

import 'package:covid_statistics/features/statistics/data/models/covid_statistics_model.dart';
import 'package:covid_statistics/features/statistics/domain/entities/covid_statistics.dart';
import 'package:covid_statistics/features/statistics/domain/entities/covid_summary.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../dummy/covid_statistics_dummy.dart';
import '../../dummy/covid_summary_dummy.dart';

void sum(CovidSummary summary) {}
void main() {
  test(
    'should be a subclass of CovidStatistics entities',
    () => expect(tCovidStatisticsModel, isA<CovidStatistics>()),
  );

  test(
    'should return a valid model from covid_statistics.json',
    () async {
      // arrange
      final jsonString = fixture('covid_statistics.json');
      // act
      final result = CovidStatisticsModel.fromJsonString(jsonString);
      // assert
      expect(result, tCovidStatisticsModel);
    },
  );

  test(
    'should return a valid json string from CovidStatisticsModel',
    () async {
      // act
      final result = json.decode(tCovidStatisticsModel.toJsonString());
      // assert
      final expected = json.decode(fixture('covid_statistics.json'));
      expect(result, expected);
    },
  );
}
