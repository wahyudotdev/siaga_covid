import 'package:covid_statistics/core/error/failure.dart';
import 'package:covid_statistics/features/statistics/domain/usecases/date_params.dart';
import 'package:covid_statistics/features/statistics/domain/usecases/get_covid_statistics_of_week.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/covid_statistics_dummy.dart';
import '../../presentation/bloc/covid_statistics_bloc_test.mocks.dart';

void main() {
  late MockCovidStatisticsRepository repository;
  late GetCovidStatisticsOfWeek usecase;

  setUp(() {
    repository = MockCovidStatisticsRepository();
    usecase = GetCovidStatisticsOfWeek(repository);
  });

  test(
    'should return a list of CovidStatistics when there is a succesfull request',
    () async {
      // arrange
      when(repository.getCovidStatisticsOfWeek(any))
          .thenAnswer((_) async => Right([tCovidStatistics]));
      // act
      final result = await usecase(DateParams(daysOfWeek: daysOfWeek));
      // assert
      verify(repository.getCovidStatisticsOfWeek(any));
      expect(true, listEquals(result.toIterable().single, [tCovidStatistics]));
    },
  );

  test(
    'should return an [EmptyFailure] when getCovidStatisticsOfWeek return an [EmptyFailure]',
    () async {
      // arrange
      when(repository.getCovidStatisticsOfWeek(any))
          .thenAnswer((realInvocation) async => Left(CacheFailure()));
      // act
      final result = await usecase(DateParams(daysOfWeek: daysOfWeek));
      // assert
      verify(repository.getCovidStatisticsOfWeek(any));
      expect(result, equals(Left(CacheFailure())));
    },
  );
}
