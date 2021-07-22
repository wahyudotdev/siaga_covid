import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid_statistics/core/query_helper/date_param_helper.dart';
import 'package:covid_statistics/core/utils/short_list.dart';
import 'package:covid_statistics/features/statistics/domain/usecases/get_covid_statistics_of_week.dart';
import 'package:equatable/equatable.dart';
part 'covid_statistics_event.dart';
part 'covid_statistics_state.dart';

class CovidStatisticsBloc
    extends Bloc<CovidStatisticsEvent, CovidStatisticsState> {
  final GetCovidStatisticsOfWeek covidStatisticsOfWeek;
  final GetDateParam getDateParam;
  final ShortList shortList;

  CovidStatisticsBloc({
    required this.covidStatisticsOfWeek,
    required this.getDateParam,
    required this.shortList,
  }) : super(Empty());

  CovidStatisticsState get initialState => Empty();

  @override
  Stream<CovidStatisticsState> mapEventToState(
    CovidStatisticsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
