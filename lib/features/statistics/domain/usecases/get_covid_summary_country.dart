import 'package:covid_statistics/core/error/failure.dart';
import 'package:covid_statistics/core/usecases/usecase.dart';
import 'package:covid_statistics/features/statistics/domain/entities/covid_summary.dart';
import 'package:covid_statistics/features/statistics/domain/repositories/covid_statistics_repository.dart';
import 'package:covid_statistics/features/statistics/domain/usecases/date_params.dart';
import 'package:dartz/dartz.dart';

class GetCovidSummaryCountry implements UseCase<CovidSummary, DateParams> {
  final CovidStatisticsRepository repository;

  GetCovidSummaryCountry(this.repository);
  @override
  Future<Either<Failure, CovidSummary>> call(DateParams params) async {
    return await repository.getCovidSummaryCountry(
        daysOfWeek: params.daysOfWeek);
  }
}
