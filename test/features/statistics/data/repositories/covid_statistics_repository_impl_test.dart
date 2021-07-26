import 'package:covid_statistics/core/error/exception.dart';
import 'package:covid_statistics/core/error/failure.dart';
import 'package:covid_statistics/core/network/network_info.dart';
import 'package:covid_statistics/features/statistics/data/datasources/covid_statistics_local_datasource.dart';
import 'package:covid_statistics/features/statistics/data/datasources/covid_statistics_remote_datasource.dart';
import 'package:covid_statistics/features/statistics/data/models/covid_summary_model.dart';
import 'package:covid_statistics/features/statistics/data/repositories/covid_statistics_repository_impl.dart';
import 'package:covid_statistics/features/statistics/domain/entities/covid_statistics.dart';
import 'package:covid_statistics/features/statistics/domain/entities/covid_summary.dart';
import 'package:covid_statistics/features/statistics/domain/repositories/covid_statistics_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/covid_statistics_dummy.dart';
import 'covid_statistics_repository_impl_test.mocks.dart';

@GenerateMocks([
  CovidStatisticsRemoteDataSource,
  CovidStatisticsLocalDataSource,
  NetworkInfo,
])
void main() {
  late MockCovidStatisticsRemoteDataSource remoteDataSource;
  late MockCovidStatisticsLocalDataSource localDataSource;
  late MockNetworkInfo networkInfo;
  late CovidStatisticsRepositoryImpl repository;
  setUp(() {
    remoteDataSource = MockCovidStatisticsRemoteDataSource();
    localDataSource = MockCovidStatisticsLocalDataSource();
    networkInfo = MockNetworkInfo();
    repository = CovidStatisticsRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
      networkInfo: networkInfo,
    );
  });

  group('[getCovidStatistic] Online test ', () {
    test(
      'should return list of [CovidStatistics] in a week when call to remote data is success',
      () async {
        final expected = List<CovidStatistics>.filled(
            daysOfWeek.length, tCovidStatisticsModel);
        // arrange
        when(remoteDataSource.getCovidStatistics(any))
            .thenAnswer((_) async => tCovidStatisticsModel);
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        // act
        final result = await repository.getCovidStatisticsOfWeek(daysOfWeek);
        // assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getCovidStatistics(any));
        expect(true, equals(listEquals(result.toIterable().single, expected)));
      },
    );

    test(
      'should cache [CovidStatistics] week data when call to remote data is success',
      () async {
        final expected = List<CovidStatistics>.filled(
            daysOfWeek.length, tCovidStatisticsModel);
        // arrange
        when(remoteDataSource.getCovidStatistics(any))
            .thenAnswer((_) async => tCovidStatisticsModel);
        when(localDataSource.saveCovidStatistics(expected.first))
            .thenAnswer((_) async => null);
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        // act
        await repository.getCovidStatisticsOfWeek(daysOfWeek);
        final result =
            verify(localDataSource.saveCovidStatistics(any)).callCount;
        // assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getCovidStatistics(any));
        expect(result, daysOfWeek.length);
      },
    );

    test(
      'should get data from cache when there is server failure when a call to remote data throw an [ServerException]',
      () async {
        final expected =
            List<CovidStatistics>.filled(daysOfWeek.length, tCovidStatistics);
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(remoteDataSource.getCovidStatistics(any))
            .thenThrow(ServerException());
        when(localDataSource.getCovidStatistics(any))
            .thenAnswer((_) async => tCovidStatistics);
        // act
        final result = await repository.getCovidStatisticsOfWeek(daysOfWeek);
        // assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getCovidStatistics(any));
        verify(localDataSource.getCovidStatistics(any));
        expect(
            result.toIterable().single, TypeMatcher<List<CovidStatistics>>());
        expect(result.toIterable().single.length, equals(expected.length));
      },
    );
    test(
      'should skip the data when returning [FormatException] and continue to request when daysOfWeek list is not end',
      () async {
        // arrange
        final expected = List<CovidStatistics>.filled(
            daysOfWeek.length - 1, tCovidStatistics);
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        for (String i in daysOfWeek) {
          if (i == tCovidDate) {
            when(remoteDataSource.getCovidStatistics(i))
                .thenThrow(FormatException());
          } else {
            when(remoteDataSource.getCovidStatistics(i))
                .thenAnswer((_) async => tCovidStatistics);
          }
        }
        when(localDataSource.saveCovidStatistics(any))
            .thenAnswer((_) async => null);
        // act
        final result = await repository.getCovidStatisticsOfWeek(daysOfWeek);
        // assert
        verify(remoteDataSource.getCovidStatistics(any));
        verify(localDataSource.saveCovidStatistics(any));
        expect(result.toIterable().first.length, equals(expected.length));
      },
    );

    test(
      'should skip the data when returning [CacheException] and continue to request when daysOfWeek list is not end',
      () async {
        // arrange
        final expected = List<CovidStatistics>.filled(
            daysOfWeek.length - 1, tCovidStatistics);
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(remoteDataSource.getCovidStatistics(any))
            .thenThrow(ServerException());
        for (String i in daysOfWeek) {
          if (i == tCovidDate) {
            when(localDataSource.getCovidStatistics(i))
                .thenThrow(CacheException());
          } else {
            when(localDataSource.getCovidStatistics(i))
                .thenAnswer((_) async => tCovidStatistics);
          }
        }
        // act
        final result = await repository.getCovidStatisticsOfWeek(daysOfWeek);
        // assert
        expect(result.toIterable().first.length, equals(expected.length));
      },
    );
    test(
      'should throw a [EmptyFailure] when returning empty data',
      () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(localDataSource.getCovidStatistics(any))
            .thenThrow(CacheException());
        when(remoteDataSource.getCovidStatistics(any))
            .thenThrow(ServerException());
        // act
        final result = await repository.getCovidStatisticsOfWeek(daysOfWeek);
        // assert
        verify(networkInfo.isConnected);
        verify(localDataSource.getCovidStatistics(any));
        verify(remoteDataSource.getCovidStatistics(any));
        expect(result, Left(EmptyFailure()));
      },
    );
  });

  group('Offline test [getCovidStatisticsOfWeek]', () {
    test(
      'should try to cache data when no network connection',
      () async {
        final expected =
            List<CovidStatistics>.filled(daysOfWeek.length, tCovidStatistics);
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        when(localDataSource.getCovidStatistics(any))
            .thenAnswer((_) async => tCovidStatistics);
        // act
        final result = await repository.getCovidStatisticsOfWeek(daysOfWeek);
        // assert
        verify(networkInfo.isConnected);
        verify(localDataSource.getCovidStatistics(any));
        expect(result.toIterable().first, expected);
      },
    );

    test(
      'should skip the data when datasource throw [CacheException]',
      () async {
        final expected = List<CovidStatistics>.filled(
            daysOfWeek.length - 1, tCovidStatistics);

        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        when(localDataSource.getCovidStatistics(argThat(equals(tCovidDate))))
            .thenThrow(CacheException());
        when(localDataSource
                .getCovidStatistics(argThat(isNot(equals(tCovidDate)))))
            .thenAnswer((_) async => tCovidStatistics);
        // act
        final result = await repository.getCovidStatisticsOfWeek(daysOfWeek);
        // assert
        verify(networkInfo.isConnected);
        verify(localDataSource.getCovidStatistics(any));
        expect(result.toIterable().single.length, equals(expected.length));
      },
    );

    test(
      'should throw a [EmptyFailure] when no data inside localstorage',
      () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        when(localDataSource.getCovidStatistics(any))
            .thenThrow(CacheException());
        // act
        final result = await repository.getCovidStatisticsOfWeek(daysOfWeek);
        // assert
        verify(networkInfo.isConnected);
        verify(localDataSource.getCovidStatistics(any));
        expect(result, Left(EmptyFailure()));
      },
    );
  });

  group('[getCovidSummary] Online test ', () {
    test(
      'should get [CovidSummary] from local storage when no country parameter supplied',
      () async {
        // arrange
        final list = List<CovidStatistics>.filled(
          daysOfWeek.length,
          tCovidStatistics,
        );
        final model = CovidSummaryModel.fromStatistics(statistics: list);
        final expectCovidSummary = CovidSummary(
          confirmed: model.confirmed,
          active: model.active,
          deaths: model.deaths,
          recovered: model.recovered,
        );
        when(localDataSource.getCovidStatistics(any))
            .thenAnswer((realInvocation) async => tCovidStatistics);
        // act
        final result = await repository.getCovidSummary(daysOfWeek: daysOfWeek);
        // assert
        verify(localDataSource.getCovidStatistics(any));
        expect(result, Right(expectCovidSummary));
      },
    );

    test(
      'should return a [CovidSummary] from local storage with spesified country',
      () async {
        // arrange
        final covidStatisticsIndonesia = tCovidStatistics.items
            .where((element) => element.countryRegion == COUNTRY_DATA)
            .toList();
        final list = List<CovidStatistics>.filled(
            daysOfWeek.length, CovidStatistics(covidStatisticsIndonesia));
        final model = CovidSummaryModel.fromStatistics(statistics: list);
        final expectCovidSummary = CovidSummary(
          confirmed: model.confirmed,
          active: model.active,
          deaths: model.deaths,
          recovered: model.recovered,
        );
        when(localDataSource.getCovidStatistics(any))
            .thenAnswer((realInvocation) async => tCovidStatistics);
        // act
        final result =
            await repository.getCovidSummaryCountry(daysOfWeek: daysOfWeek);

        // assert
        verify(localDataSource.getCovidStatistics(any));
        expect(result, Right(expectCovidSummary));
      },
    );
  });
}
