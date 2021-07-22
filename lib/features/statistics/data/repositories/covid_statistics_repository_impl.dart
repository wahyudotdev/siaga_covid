import 'package:covid_statistics/core/error/exception.dart';
import 'package:covid_statistics/core/network/network_info.dart';
import 'package:covid_statistics/features/statistics/data/datasources/covid_statistics_remote_datasource.dart';
import 'package:covid_statistics/features/statistics/domain/entities/covid_statistics.dart';
import 'package:covid_statistics/core/error/failure.dart';
import 'package:covid_statistics/features/statistics/domain/repositories/covid_statistics_repository.dart';
import 'package:dartz/dartz.dart';

class CovidStatisticsRepositoryImpl implements CovidStatisticsRepository {
  final CovidStatisticsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  CovidStatisticsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, CovidStatistics>> getCovidStatistics(
      String date) async {
    try {
      final result = await remoteDataSource.getCovidStatistics(date);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<CovidStatistics>>> getCovidStatisticsOfWeek(
      List<String> date) async {
    try {
      List<CovidStatistics> list = [];
      for (var element in date) {
        final result = await remoteDataSource.getCovidStatistics(element);
        list.add(result);
      }
      return Right(list);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
