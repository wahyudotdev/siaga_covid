import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid_statistics/features/statistics/domain/usecases/date_params.dart';
import 'package:covid_statistics/features/statistics/domain/usecases/get_covid_summary_country.dart';
import 'package:covid_statistics/features/statistics/domain/usecases/get_covid_summary_world.dart';
import '../../../../core/query_helper/date_param_helper.dart';
import '../../domain/entities/covid_statistics.dart';
import '../../domain/entities/covid_summary.dart';
import '../../domain/usecases/get_covid_statistics_of_week.dart';
import 'package:equatable/equatable.dart';
part 'covid_statistics_event.dart';
part 'covid_statistics_state.dart';

class CovidStatisticsBloc
    extends Bloc<CovidStatisticsEvent, CovidStatisticsState> {
  final GetCovidStatisticsOfWeek covidStatisticsOfWeek;
  final GetDateParam getDateParam;
  final GetCovidSummaryWorld summaryWorld;
  final GetCovidSummaryCountry summaryCountry;

  CovidStatisticsBloc({
    required this.covidStatisticsOfWeek,
    required this.getDateParam,
    required this.summaryWorld,
    required this.summaryCountry,
  }) : super(Empty());

  CovidStatisticsState get initialState => Empty();

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
        yield LoadedStatistics(data: data);
      });
    }

    if (event is SummaryWorldEvent) {
      yield Loading();
      final daysOfWeek = getDateParam.daysOfWeek();
      final result = await summaryWorld(DateParams(daysOfWeek: daysOfWeek));
      yield* result.fold((failure) async* {
        yield Error();
      }, (data) async* {
        yield LoadedSummaryWorld(data: data);
      });
    }

    if (event is SummaryCountryEvent) {
      yield Loading();
      final daysOfWeek = getDateParam.daysOfWeek();
      final result = await summaryCountry(DateParams(daysOfWeek: daysOfWeek));
      yield* result.fold((failure) async* {
        yield Error();
      }, (data) async* {
        yield LoadedSummaryByCountry(data: data);
      });
    }
  }
}
