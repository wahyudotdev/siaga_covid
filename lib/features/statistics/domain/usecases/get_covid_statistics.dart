import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/covid_statistics.dart';
import '../repositories/covid_statistics_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetCovidStatistics implements UseCase<CovidStatistics, Params> {
  final CovidStatisticsRepository repository;

  GetCovidStatistics(this.repository);
  @override
  Future<Either<Failure, CovidStatistics>> call(Params params) async {
    return await repository.getCovidStatistics(params.date);
  }
}

class Params extends Equatable {
  final String date;

  Params({required this.date});
  @override
  List<Object?> get props => [];
}
