part of 'covid_statistics_bloc.dart';

abstract class CovidStatisticsState extends Equatable {
  const CovidStatisticsState();

  @override
  List<Object> get props => [];
}

class Empty extends CovidStatisticsState {}

class Loading extends CovidStatisticsState {}

class StatisticsLoaded extends CovidStatisticsState {}

class Error extends CovidStatisticsState {}
