import 'package:covid_statistics/features/statistics/data/datasources/covid_statistics_local_datasource.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/covid_statistics_remote_datasource.dart';
import '../../domain/entities/covid_statistics.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/covid_statistics_repository.dart';
import 'package:dartz/dartz.dart';

class CovidStatisticsRepositoryImpl implements CovidStatisticsRepository {
  final CovidStatisticsRemoteDataSource remoteDataSource;
  final CovidStatisticsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  CovidStatisticsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  Either<Failure, List<CovidStatistics>> _dataOrEmpty(
      List<CovidStatistics> list) {
    list.sort(
        (a, b) => a.items.first.lastUpdate.compareTo(b.items.first.lastUpdate));
    if (list.isNotEmpty) {
      return Right(list);
    } else {
      return Left(EmptyFailure());
    }
  }

  @override
  Future<Either<Failure, List<CovidStatistics>>> getCovidStatisticsOfWeek(
      List<String> date) async {
    List<CovidStatistics> list = [];
    if (await networkInfo.isConnected) {
      for (var element in date) {
        try {
          final result = await remoteDataSource.getCovidStatistics(element);
          list.add(result);
          await localDataSource.saveCovidStatistics(result);
        } on ServerException {
          try {
            final result = await localDataSource.getCovidStatistics(element);
            list.add(result);
            await localDataSource.saveCovidStatistics(result);
          } on CacheException {
            print('CacheException');
          }
        } on FormatException {
          print('FormatException');
        }
      }
      return _dataOrEmpty(list);
    } else {
      for (var element in date) {
        try {
          final result = await localDataSource.getCovidStatistics(element);
          list.add(result);
        } on CacheException {
          print('CacheException');
        }
      }
      return _dataOrEmpty(list);
    }
  }
}
