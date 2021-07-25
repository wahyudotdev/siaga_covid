import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid_statistics/features/statistics/data/models/covid_series_model.dart';
import 'package:covid_statistics/features/statistics/data/models/covid_summary_model.dart';
import 'package:covid_statistics/features/statistics/domain/entities/covid_series.dart';
import 'package:covid_statistics/features/statistics/domain/entities/covid_statistics.dart';
import 'package:covid_statistics/features/statistics/domain/usecases/date_params.dart';
import '../../../../core/query_helper/date_param_helper.dart';
import '../../domain/entities/covid_summary.dart';
import '../../domain/usecases/get_covid_statistics_of_week.dart';
import 'package:equatable/equatable.dart';
part 'covid_statistics_event.dart';
part 'covid_statistics_state.dart';

class CovidStatisticsBloc
    extends Bloc<CovidStatisticsEvent, CovidStatisticsState> {
  final GetCovidStatisticsOfWeek covidStatisticsOfWeek;
  final GetDateParam getDateParam;

  CovidStatisticsBloc({
    required this.covidStatisticsOfWeek,
    required this.getDateParam,
  }) : super(Empty());

  CovidStatisticsState get initialState => Empty();
  List<CovidSeries> covidSeries = [];
  List<CovidStatistics> covidStatistics = [];

  @override
  Stream<CovidStatisticsState> mapEventToState(
    CovidStatisticsEvent event,
  ) async* {
    if (event is CovidStatisticsOfWeekEvent) {
      yield Loading();
      final daysOfWeek = getDateParam.daysOfWeek();
      final result =
          await covidStatisticsOfWeek(DateParams(daysOfWeek: daysOfWeek));
      yield* result.fold((failure) async* {
        yield Error();
      }, (data) async* {
        covidStatistics = data;
        covidSeries =
            data.map((e) => CovidSeriesModel.fromStatistics(e)).toList();
        yield LoadedStatistics();
      });
    }

    if (event is SummaryWorldEvent) {
      yield Loading();
      yield LoadedSummaryWorld(
          data: CovidSummaryModel.fromStatistics(statistics: covidStatistics));
    }

    if (event is SummaryCountryEvent) {
      yield Loading();
      yield LoadedSummaryByCountry(
          data: CovidSummaryModel.fromStatistics(
              statistics: covidStatistics, country: 'Indonesia'));
    }
  }
}
