import 'dart:convert';

import 'package:covid_statistics/features/statistics/data/models/covid_statistics_model.dart';
import 'package:covid_statistics/features/statistics/domain/entities/covid_statistics.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../dummy/covid_statistics_dummy.dart';

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

  test(
    'should return an empty array when supplied with empty json response',
    () async {
      // arrange
      final result = CovidStatisticsModel.fromJsonString(
          fixture('covid_statistics_empty.json'));
      // act
      final expected = CovidStatisticsModel([]);
      // assert
      expect(result, equals(expected));
    },
  );
}
