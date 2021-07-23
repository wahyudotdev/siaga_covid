import 'package:covid_statistics/core/error/exception.dart';
import 'package:covid_statistics/core/error/failure.dart';
import 'package:covid_statistics/core/network/network_info.dart';
import 'package:covid_statistics/core/utils/short_list.dart';
import 'package:covid_statistics/features/statistics/data/datasources/covid_statistics_remote_datasource.dart';
import 'package:covid_statistics/features/statistics/data/repositories/covid_statistics_repository_impl.dart';
import 'package:covid_statistics/features/statistics/domain/entities/covid_statistics.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/covid_statistics_dummy.dart';
import 'covid_statistics_repository_impl.mocks.dart';

@GenerateMocks([
  CovidStatisticsRemoteDataSource,
  NetworkInfo,
  ShortList,
])
void main() {
  late MockCovidStatisticsRemoteDataSource remoteDataSource;
  late MockNetworkInfo networkInfo;
  late CovidStatisticsRepositoryImpl repository;
  late MockShortList shortList;
  setUp(() {
    remoteDataSource = MockCovidStatisticsRemoteDataSource();
    networkInfo = MockNetworkInfo();
    shortList = MockShortList();
    repository = CovidStatisticsRepositoryImpl(
      remoteDataSource: remoteDataSource,
      networkInfo: networkInfo,
      shortList: shortList,
    );
  });

  group('getCovidStatistics', () {
    test(
      'should return a [CovidStatistics] when call to remote data is success',
      () async {
        // arrange
        when(remoteDataSource.getCovidStatistics(any))
            .thenAnswer((_) async => tCovidStatisticsModel);
        // act
        final result = await repository.getCovidStatistics(tCovidDate);
        // assert
        expect(result, equals(Right(tCovidStatisticsModel)));
      },
    );

    test(
      'should throw a [ServerFailure] when there is [ServerException]',
      () async {
        // arrange
        when(remoteDataSource.getCovidStatistics(any))
            .thenThrow(ServerException());
        // act
        final result = await repository.getCovidStatistics(tCovidDate);
        // assert
        verify(repository.getCovidStatistics(tCovidDate));
        expect(result, equals(Left(ServerFailure())));
      },
    );
  });

  group('getCovidStatisticsOfWeek', () {
    test(
      'should return list of [CovidStatistics] in a week when call to remote data is success',
      () async {
        final expected = List<CovidStatistics>.filled(
            daysOfWeek.length, tCovidStatisticsModel);
        // arrange
        when(remoteDataSource.getCovidStatistics(any))
            .thenAnswer((_) async => tCovidStatisticsModel);
        when(shortList.shortByDate(any)).thenReturn(expected);
        // act
        final result = await repository.getCovidStatisticsOfWeek(daysOfWeek);
        // assert
        expect(true, equals(listEquals(result.toIterable().single, expected)));
      },
    );

    test(
      'should return a [ServerFailure] when a call to remote data throw an [ServerException]',
      () async {
        // arrange
        when(remoteDataSource.getCovidStatistics(any))
            .thenThrow(ServerException());
        // act
        final result = await repository.getCovidStatisticsOfWeek(daysOfWeek);
        // assert
        verify(repository.getCovidStatisticsOfWeek(daysOfWeek));
        expect(result, equals(Left(ServerFailure())));
      },
    );
    test(
      'should skip the data when returning [FormatException] and continue to request when daysOfWeek list is not end',
      () async {
        // arrange
        final expected = List<CovidStatistics>.filled(
            daysOfWeek.length - 1, tCovidStatistics);
        when(remoteDataSource.getCovidStatistics(argThat(equals(tCovidDate))))
            .thenThrow(FormatException());
        when(remoteDataSource
                .getCovidStatistics(argThat(isNot(equals(tCovidDate)))))
            .thenAnswer((realInvocation) async => tCovidStatisticsModel);
        when(shortList.shortByDate(any)).thenReturn(expected);
        // act
        final result = await repository.getCovidStatisticsOfWeek(daysOfWeek);
        // assert
        expect(result.toIterable().first.length, equals(expected.length));
      },
    );
  });
}
