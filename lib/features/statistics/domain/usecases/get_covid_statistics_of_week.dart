import 'package:covid_statistics/core/error/failure.dart';
import 'package:covid_statistics/core/usecases/usecase.dart';
import 'package:covid_statistics/features/statistics/domain/entities/covid_statistics.dart';
import 'package:covid_statistics/features/statistics/domain/repositories/covid_statistics_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetCovidStatisticsOfWeek
    implements UseCase<List<CovidStatistics>, DateParams> {
  final CovidStatisticsRepository repository;

  GetCovidStatisticsOfWeek(this.repository);
  @override
  Future<Either<Failure, List<CovidStatistics>>> call(DateParams params) async {
    return await repository.getCovidStatisticsOfWeek(params.daysOfWeek);
  }
}

class DateParams extends Equatable {
  final List<String> daysOfWeek;

  DateParams({required this.daysOfWeek});
  @override
  List<Object?> get props => [daysOfWeek];
}
