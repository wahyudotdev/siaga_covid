import 'package:covid_statistics/core/error/failure.dart';
import 'package:covid_statistics/core/usecases/usecase.dart';
import 'package:covid_statistics/features/statistics/domain/entities/covid_statistics.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetCovidStatistics implements UseCase<CovidStatistics, Params> {
  @override
  Future<Either<Failure, CovidStatistics>> call(Params params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class Params extends Equatable {
  @override
  List<Object?> get props => [];
}
