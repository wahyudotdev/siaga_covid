import 'package:covid_statistics/core/error/exception.dart';
import 'package:covid_statistics/core/network/network_info.dart';
import 'package:covid_statistics/core/utils/short_list.dart';
import 'package:covid_statistics/features/statistics/data/datasources/covid_statistics_remote_datasource.dart';
import 'package:covid_statistics/features/statistics/domain/entities/covid_statistics.dart';
import 'package:covid_statistics/core/error/failure.dart';
import 'package:covid_statistics/features/statistics/domain/repositories/covid_statistics_repository.dart';
import 'package:dartz/dartz.dart';

class CovidStatisticsRepositoryImpl implements CovidStatisticsRepository {
  final CovidStatisticsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final ShortList shortList;
  CovidStatisticsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.shortList,
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
        try {
          final result = await remoteDataSource.getCovidStatistics(element);
          list.add(result);
        } on FormatException {}
      }
      return Right(shortList.shortByDate(list));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
