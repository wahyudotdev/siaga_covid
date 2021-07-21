import 'package:covid_statistics/core/error/exception.dart';
import 'package:covid_statistics/core/error/failure.dart';
import 'package:covid_statistics/core/network/network_info.dart';
import 'package:covid_statistics/features/statistics/data/datasources/covid_statistics_remote_datasource.dart';
import 'package:covid_statistics/features/statistics/data/repositories/covid_statistics_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/covid_statistics_dummy.dart';
import 'covid_statistics_repository_impl_test.mocks.dart';

@GenerateMocks([
  CovidStatisticsRemoteDataSource,
  NetworkInfo,
])
void main() {
  late MockCovidStatisticsRemoteDataSource remoteDataSource;
  late MockNetworkInfo networkInfo;
  late CovidStatisticsRepositoryImpl repository;

  setUp(() {
    remoteDataSource = MockCovidStatisticsRemoteDataSource();
    networkInfo = MockNetworkInfo();
    repository = CovidStatisticsRepositoryImpl(
      remoteDataSource: remoteDataSource,
      networkInfo: networkInfo,
    );
  });

  test(
    'should return a [CovidStatistics] when call to remote data is success',
    () async {
      // arrange
      when(remoteDataSource.getCovidStatistics(any))
          .thenAnswer((_) async => tCovidStatisticsModel);
      // act
      final result = await repository.getCovidStatistics(tCovidDate);
      // assert
      verify(repository.getCovidStatistics(tCovidDate));
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
}
