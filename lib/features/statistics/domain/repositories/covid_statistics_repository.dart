import '../../../../core/error/failure.dart';
import '../entities/covid_statistics.dart';
import 'package:dartz/dartz.dart';

abstract class CovidStatisticsRepository {
  Future<Either<Failure, CovidStatistics>> getCovidStatistics(String date);
}
