part of 'covid_statistics_bloc.dart';

abstract class CovidStatisticsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CovidStatisticsOfWeekEvent extends CovidStatisticsEvent {}

class SummaryWorldEvent extends CovidStatisticsEvent {}

class SummaryCountryEvent extends CovidStatisticsEvent {}
