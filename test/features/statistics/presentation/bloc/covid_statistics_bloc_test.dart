import 'package:covid_statistics/core/error/failure.dart';
import 'package:covid_statistics/core/query_helper/date_param_helper.dart';
import 'package:covid_statistics/features/statistics/domain/repositories/covid_statistics_repository.dart';
import 'package:covid_statistics/features/statistics/domain/usecases/date_params.dart';
import 'package:covid_statistics/features/statistics/domain/usecases/get_covid_statistics_of_week.dart';
import 'package:covid_statistics/features/statistics/domain/usecases/get_covid_summary_country.dart';
import 'package:covid_statistics/features/statistics/domain/usecases/get_covid_summary_world.dart';
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
  CovidStatisticsRepository,
  GetCovidSummaryWorld,
  GetCovidSummaryCountry,
])
void main() {
  late CovidStatisticsBloc bloc;
  final covidStatisticsOfWeek = MockGetCovidStatisticsOfWeek();
  final dateParam = MockGetDateParam();
  final summaryWorld = MockGetCovidSummaryWorld();
  final summaryCountry = MockGetCovidSummaryCountry();
  setUp(() {
    bloc = CovidStatisticsBloc(
      covidStatisticsOfWeek: covidStatisticsOfWeek,
      getDateParam: dateParam,
      summaryWorld: summaryWorld,
      summaryCountry: summaryCountry,
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
      'should emit [LoadingStatistics, LoadedStatistics] in order when data emit successfully',
      () async {
        // arrange
        when(dateParam.daysOfWeek()).thenReturn(daysOfWeek);
        when(covidStatisticsOfWeek(any))
            .thenAnswer((_) async => Right([tCovidStatistics]));
        final expected = [
          Loading(),
          LoadedStatistics(data: [tCovidStatistics]),
        ];
        // assert
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(CovidStatisticsOfWeekEvent());
        await untilCalled(covidStatisticsOfWeek(any));
      },
    );
    test(
      'should emit [Loading, Error] in order when get ServerFailure',
      () async {
        when(dateParam.daysOfWeek()).thenReturn(daysOfWeek);
        when(covidStatisticsOfWeek(any))
            .thenAnswer((realInvocation) async => Left(ServerFailure()));
        final expected = [
          Loading(),
          Error(),
        ];
        // assert later
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(CovidStatisticsOfWeekEvent());
        await untilCalled(covidStatisticsOfWeek(any));
        verify(covidStatisticsOfWeek(any));
      },
    );

    test(
      'should emit [Loading, LoadedSummaryWorld] in order when there is [SummaryWorldEvent]',
      () async {
        // arrange
        when(dateParam.daysOfWeek()).thenReturn(daysOfWeek);
        when(summaryWorld(DateParams(daysOfWeek: daysOfWeek)))
            .thenAnswer((realInvocation) async => Right(tCovidSummary));
        final expected = [
          Loading(),
          LoadedSummaryWorld(data: tCovidSummary),
        ];
        // assert later
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(SummaryWorldEvent());
        await untilCalled(
            summaryWorld.call(DateParams(daysOfWeek: daysOfWeek)));
        verify(dateParam.daysOfWeek());
        verify(summaryWorld(DateParams(daysOfWeek: daysOfWeek)));
      },
    );

    test(
      'should emit [Loading, Error] on SummaryWorldEvent when there is [EmptyFailure]',
      () async {
        // arrange
        when(dateParam.daysOfWeek()).thenReturn(daysOfWeek);
        when(summaryWorld(DateParams(daysOfWeek: daysOfWeek)))
            .thenAnswer((realInvocation) async => Left(EmptyFailure()));
        final expected = [
          Loading(),
          Error(),
        ];
        // assert later
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(SummaryWorldEvent());
        await untilCalled(summaryWorld(DateParams(daysOfWeek: daysOfWeek)));
      },
    );

    test(
      'should emit [Loading, LoadedSummaryCouuntry] when there is SummaryCountryEvent',
      () async {
        // arrange
        when(dateParam.daysOfWeek()).thenReturn(daysOfWeek);
        when(summaryCountry(DateParams(daysOfWeek: daysOfWeek)))
            .thenAnswer((realInvocation) async => Right(tCovidSummary));
        final expected = [
          Loading(),
          LoadedSummaryByCountry(data: tCovidSummary),
        ];
        // assert later
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(SummaryCountryEvent());
        await untilCalled(summaryCountry(DateParams(daysOfWeek: daysOfWeek)));
        verify(dateParam.daysOfWeek());
        verify(summaryCountry(DateParams(daysOfWeek: daysOfWeek)));
      },
    );

    test(
      'should emit [Loading, Error] on SummaryCountryEvent when there is [EmptyFailure]',
      () async {
        // arrange
        when(dateParam.daysOfWeek()).thenReturn(daysOfWeek);
        when(summaryCountry(DateParams(daysOfWeek: daysOfWeek)))
            .thenAnswer((realInvocation) async => Left(EmptyFailure()));
        final expected = [
          Loading(),
          Error(),
        ];
        // assert later
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(SummaryCountryEvent());
        await untilCalled(summaryCountry(DateParams(daysOfWeek: daysOfWeek)));
      },
    );
  });
}
