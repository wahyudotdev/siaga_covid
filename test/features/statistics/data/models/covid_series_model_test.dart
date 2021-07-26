import 'package:covid_statistics/features/statistics/data/models/covid_series_model.dart';
import 'package:covid_statistics/features/statistics/domain/entities/covid_series.dart';
import 'package:covid_statistics/features/statistics/domain/repositories/covid_statistics_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tCovidSeriesModel = CovidSeriesModel(date: '20', confirmed: 200);
  test(
    'should a subclass of [CovidSeries]',
    () async => expect(tCovidSeriesModel, isA<CovidSeries>()),
  );

  test(
    'should return a [CovidSeries] data when supplied with json string',
    () async {
      // arrange
      String jsonString = fixture('covid_statistics.json');
      // act
      final result = CovidSeriesModel.fromJsonString(jsonString: jsonString);
      // assert
      final expected = CovidSeriesModel(date: '20', confirmed: 200);
      expect(result, equals(expected));
    },
  );

  test(
    'should return a country spesific [CovidSeries] data when supplied with json string and country name',
    () async {
      // arrange
      String jsonString = fixture('covid_statistics.json');
      // act
      final result = CovidSeriesModel.fromJsonString(
          jsonString: jsonString, key: COUNTRY_DATA);
      // assert
      final expected = CovidSeriesModel(date: '20', confirmed: 100);
      expect(result, equals(expected));
    },
  );
}
