import 'package:covid_statistics/features/statistics/data/datasources/covid_statistics_local_datasource.dart';
import 'package:covid_statistics/features/statistics/data/models/covid_summary_model.dart';
import 'package:covid_statistics/features/statistics/domain/entities/covid_summary.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/covid_statistics_remote_datasource.dart';
import '../../domain/entities/covid_statistics.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/covid_statistics_repository.dart';
import 'package:dartz/dartz.dart';

const COUNTRY_DATA = 'Indonesia';

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
      List<String> daysOfWeek) async {
    List<CovidStatistics> list = [];
    if (await networkInfo.isConnected) {
      for (var element in daysOfWeek) {
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
      for (var element in daysOfWeek) {
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

  @override
  Future<Either<Failure, CovidSummary>> getCovidSummary(
      {required List<String> daysOfWeek}) async {
    List<CovidStatistics> list = [];
    for (String day in daysOfWeek) {
      final result = await localDataSource.getCovidStatistics(day);
      list.add(result);
    }
    final summary = CovidSummaryModel.fromStatistics(statistics: list);
    return Right(
      CovidSummary(
          confirmed: summary.confirmed,
          active: summary.active,
          deaths: summary.deaths,
          recovered: summary.recovered),
    );
  }

  @override
  Future<Either<Failure, CovidSummary>> getCovidSummaryCountry(
      {required List<String> daysOfWeek}) async {
    List<CovidStatistics> list = [];
    for (String day in daysOfWeek) {
      final result = await localDataSource.getCovidStatistics(day);
      list.add(result);
    }
    final summary = CovidSummaryModel.fromStatistics(
      statistics: list,
      country: COUNTRY_DATA,
    );
    return Right(
      CovidSummary(
          confirmed: summary.confirmed,
          active: summary.active,
          deaths: summary.deaths,
          recovered: summary.recovered),
    );
  }
}
