import 'package:covid_statistics/core/error/failure.dart';
import 'package:covid_statistics/core/query_helper/date_param_helper.dart';
import 'package:covid_statistics/core/utils/short_list.dart';
import 'package:covid_statistics/features/statistics/domain/repositories/covid_statistics_repository.dart';
import 'package:covid_statistics/features/statistics/domain/usecases/get_covid_statistics_of_week.dart';
import 'package:covid_statistics/features/statistics/presentation/bloc/covid_statistics_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/covid_statistics_dummy.dart';
import '../../dummy/covid_summary_dummy.dart';
import 'covid_statistics_bloc_test.mocks.dart';

@GenerateMocks([
  GetCovidStatisticsOfWeek,
  GetDateParam,
  ShortList,
  CovidStatisticsRepository,
])
void main() {
  late CovidStatisticsBloc bloc;
  final covidStatisticsOfWeek = MockGetCovidStatisticsOfWeek();
  final dateParam = MockGetDateParam();
  final listShorter = MockShortList();
  setUp(() {
    bloc = CovidStatisticsBloc(
      covidStatisticsOfWeek: covidStatisticsOfWeek,
      getDateParam: dateParam,
      shortList: listShorter,
    );
  });

  test('initial state should equal to [CovidStatisticsInitial]',
      () async => expect(bloc.initialState, equals(Empty())));

  group('GetCovidStatistics', () {
    test(
      'should get data from [GetCovidStatistics] usecase',
      () async {
        // arrange
        when(dateParam.daysOfWeek()).thenReturn(daysOfWeek);
        when(covidStatisticsOfWeek(any))
            .thenAnswer((_) async => Right([tCovidStatistics]));
        // act
        bloc.add(CovidStatisticsOfWeekEvent());
        // assert
        await untilCalled(covidStatisticsOfWeek(any));
        verify(covidStatisticsOfWeek(any));
      },
    );

    test(
      'should emit [LoadingStatistics, LoadedStatistics, LoadedSummary] when data emit successfully',
      () async {
        // arrange
        when(dateParam.daysOfWeek()).thenReturn(daysOfWeek);
        when(covidStatisticsOfWeek(any))
            .thenAnswer((_) async => Right([tCovidStatistics]));
        final expected = [
          LoadingStatistics(),
          LoadedStatistics(data: [tCovidStatistics]),
          LoadedSummaryWorld(data: tCovidSummaryModel),
          LoadedSummaryByCountry(data: tCovidSummaryModel),
        ];
        // assert
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(CovidStatisticsOfWeekEvent());
      },
    );
    test(
      'should emit [LoadingStatistics, Error] when get ServerFailure',
      () async {
        when(dateParam.daysOfWeek()).thenReturn(daysOfWeek);
        when(covidStatisticsOfWeek(any))
            .thenAnswer((realInvocation) async => Left(ServerFailure()));
        final expected = [
          LoadingStatistics(),
          Error(),
        ];
        // assert
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(CovidStatisticsOfWeekEvent());
      },
    );
  });
}
