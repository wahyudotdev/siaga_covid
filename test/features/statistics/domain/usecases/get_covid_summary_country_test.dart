import 'package:covid_statistics/core/error/failure.dart';
import 'package:covid_statistics/features/statistics/domain/usecases/date_params.dart';
import 'package:covid_statistics/features/statistics/domain/usecases/get_covid_summary_country.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/covid_statistics_dummy.dart';
import '../../dummy/covid_summary_dummy.dart';
import '../../presentation/bloc/covid_statistics_bloc_test.mocks.dart';

void main() {
  late MockCovidStatisticsRepository repository;
  late GetCovidSummaryCountry usecase;

  setUp(() {
    repository = MockCovidStatisticsRepository();
    usecase = GetCovidSummaryCountry(repository);
  });

  test(
    'should return a list of CovidStatistics when there is a succesfull request',
    () async {
      // arrange
      when(repository.getCovidSummaryCountry(daysOfWeek: daysOfWeek))
          .thenAnswer((realInvocation) async => Right(tCovidSummary));
      // act
      final result = await usecase(DateParams(daysOfWeek: daysOfWeek));
      // assert
      verify(repository.getCovidSummaryCountry(daysOfWeek: daysOfWeek));
      expect(result, Right(tCovidSummary));
    },
  );

  test(
    'should return an [EmptyFailure] when getCovidSummaryCountry return an [EmptyFailure]',
    () async {
      // arrange
      when(repository.getCovidSummaryCountry(daysOfWeek: daysOfWeek))
          .thenAnswer((realInvocation) async => Left(EmptyFailure()));
      // act
      final result = await usecase(DateParams(daysOfWeek: daysOfWeek));
      // assert
      verify(repository.getCovidSummaryCountry(daysOfWeek: daysOfWeek));
      expect(result, equals(Left(EmptyFailure())));
    },
  );
}
