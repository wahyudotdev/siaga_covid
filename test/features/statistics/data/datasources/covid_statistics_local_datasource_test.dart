import 'package:covid_statistics/core/error/exception.dart';
import 'package:covid_statistics/core/local_storage/local_storage.dart';
import 'package:covid_statistics/features/statistics/data/datasources/covid_statistics_local_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/covid_statistics_dummy.dart';
import 'covid_statistics_local_datasource_test.mocks.dart';

@GenerateMocks([
  LocalStorage,
])
void main() {
  late MockLocalStorage storage;
  late CovidStatisticsLocalDataSourceImpl dataSource;
  setUp(() {
    storage = MockLocalStorage();
    dataSource = CovidStatisticsLocalDataSourceImpl(storage);
  });

  test(
    'should return [CovidStatistics] when spesific key provided',
    () async {
      // arrange
      when(storage.getData(key: tCovidDate)).thenAnswer(
          (realInvocation) async => tCovidStatisticsModel.toJsonString());
      // act
      final result = await dataSource.getCovidStatistics(tCovidDate);
      // assert
      verify(storage.getData(key: tCovidDate));
      expect(result.items, tCovidStatistics.items);
    },
  );

  test(
    'should throw a [CacheException] when there is error or no data when get data from local storage',
    () async {
      // arrange
      when(storage.getData(key: tCovidDate)).thenThrow(Exception());
      // act
      final call = dataSource.getCovidStatistics;
      // assert
      expect(() => call(tCovidDate), throwsA(TypeMatcher<CacheException>()));
    },
  );
  test(
    'should call the method to cache the covid statistics in local database',
    () async {
      // arrange
      when(storage.saveData(
              key: tCovidDate, value: tCovidStatisticsModel.toJsonString()))
          .thenAnswer((realInvocation) async => null);
      // act
      await dataSource.saveCovidStatistics(tCovidStatistics);
      // assert
      verify(storage.saveData(
          key: tCovidDate, value: tCovidStatisticsModel.toJsonString()));
    },
  );
}
