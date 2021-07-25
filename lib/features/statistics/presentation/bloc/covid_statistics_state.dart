part of 'covid_statistics_bloc.dart';

abstract class CovidStatisticsState extends Equatable {
  const CovidStatisticsState();

  @override
  List<Object> get props => [];
}

class Empty extends CovidStatisticsState {}

class Loading extends CovidStatisticsState {}

class LoadedStatistics extends CovidStatisticsState {}

class LoadedSummaryWorld extends CovidStatisticsState {
  final CovidSummary data;

  LoadedSummaryWorld({required this.data});
}

class LoadedSummaryByCountry extends CovidStatisticsState {
  final CovidSummary data;

  LoadedSummaryByCountry({required this.data});
}

class Error extends CovidStatisticsState {}
