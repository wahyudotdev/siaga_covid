import '../entities/covid_summary.dart';

import '../../../../core/error/failure.dart';
import '../entities/covid_statistics.dart';
import 'package:dartz/dartz.dart';

const COUNTRY_DATA = 'Indonesia';
const STATISTICS_BOX_NAME = 'covid_statistics_box';

abstract class CovidStatisticsRepository {
  Future<Either<Failure, List<CovidStatistics>>> getCovidStatisticsOfWeek(
      List<String> daysOfWeek);
  Future<Either<Failure, CovidSummary>> getCovidSummary(
      {required List<String> daysOfWeek});
  Future<Either<Failure, CovidSummary>> getCovidSummaryCountry(
      {required List<String> daysOfWeek});
}
