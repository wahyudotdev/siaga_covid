import 'package:covid_statistics/features/statistics/domain/repositories/covid_statistics_repository.dart';
import 'package:covid_statistics/features/statistics/domain/usecases/get_covid_statistics.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/covid_statistics_dummy.dart';
import 'get_covid_statistics_test.mocks.dart';

@GenerateMocks([CovidStatisticsRepository])
void main() {
  late MockCovidStatisticsRepository repository;
  late GetCovidStatistics usecase;

  setUp(() {
    repository = MockCovidStatisticsRepository();
    usecase = GetCovidStatistics(repository);
  });

  test(
    'should get covid statistics from repository',
    () async {
      // arrange
      when(repository.getCovidStatistics(any))
          .thenAnswer((realInvocation) async => Right(tCovidStatistics));
      // act
      final result = await usecase(Params(date: tCovidDate));
      // assert
      expect(result, Right(tCovidStatistics));
    },
  );
}
