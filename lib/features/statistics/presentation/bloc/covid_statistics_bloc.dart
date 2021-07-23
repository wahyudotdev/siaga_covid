import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../../core/query_helper/date_param_helper.dart';
import '../../domain/entities/covid_statistics.dart';
import '../../domain/entities/covid_summary.dart';
import '../../domain/usecases/get_covid_statistics_of_week.dart';
import 'package:equatable/equatable.dart';
part 'covid_statistics_event.dart';
part 'covid_statistics_state.dart';

const CONFIG_COUNTRY = 'Indonesia';

class CovidStatisticsBloc
    extends Bloc<CovidStatisticsEvent, CovidStatisticsState> {
  final GetCovidStatisticsOfWeek covidStatisticsOfWeek;
  final GetDateParam getDateParam;

  CovidStatisticsBloc({
    required this.covidStatisticsOfWeek,
    required this.getDateParam,
  }) : super(Empty());

  CovidStatisticsState get initialState => Empty();

  @override
  Stream<CovidStatisticsState> mapEventToState(
    CovidStatisticsEvent event,
  ) async* {
    if (event is CovidStatisticsOfWeekEvent) {
      yield LoadingStatistics();
      final daysOfWeek = getDateParam.daysOfWeek();
      final result =
          await covidStatisticsOfWeek(DateParams(daysOfWeek: daysOfWeek));
      yield* result.fold((failure) async* {
        yield Error();
      }, (data) async* {
        yield LoadedStatistics(data: data);
      });
    }
  }
}
