import 'package:covid_statistics/features/statistics/domain/usecases/date_params.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/covid_statistics.dart';
import '../repositories/covid_statistics_repository.dart';
import 'package:dartz/dartz.dart';

class GetCovidStatisticsOfWeek
    implements UseCase<List<CovidStatistics>, DateParams> {
  final CovidStatisticsRepository repository;

  GetCovidStatisticsOfWeek(this.repository);
  @override
  Future<Either<Failure, List<CovidStatistics>>> call(DateParams params) async {
    return await repository.getCovidStatisticsOfWeek(params.daysOfWeek);
  }
}
