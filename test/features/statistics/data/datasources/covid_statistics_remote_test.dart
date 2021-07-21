import 'dart:io';

import 'package:covid_statistics/core/error/exception.dart';
import 'package:covid_statistics/features/statistics/data/datasources/covid_statistics_remote_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../dummy/covid_statistics_dummy.dart';
import 'covid_statistics_remote_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<Client>(as: #MockHttpClient),
])
void main() {
  late MockHttpClient client;
  late CovidStatisticsRemoteDataSourceImpl dataSource;

  setUp(() {
    client = MockHttpClient();
    dataSource = CovidStatisticsRemoteDataSourceImpl(client);
  });

  test(
    'should call GET method with appropriate url and parameters',
    () async {
      // arrange
      when(client.get(any)).thenAnswer((realInvocation) async =>
          Response(fixture('covid_statistics.json'), HttpStatus.ok));
      // act
      dataSource.getCovidStatistics(tCovidDate);
      // assert
      verify(client.get(Uri.parse(SERVER_API_BASE_URL + '/$tCovidDate')));
    },
  );

  test(
    'should return a [CovidStatisticsModel] when HttpStatus.ok (200)',
    () async {
      // arrange
      when(client.get(any)).thenAnswer((_) async =>
          Response(fixture('covid_statistics.json'), HttpStatus.ok));
      // act
      final result = await dataSource.getCovidStatistics(tCovidDate);
      // assert
      expect(result, tCovidStatisticsModel);
    },
  );

  test(
    'should return a [ServerException] when HttpStatus other than 200',
    () async {
      // arrange
      when(client.get(any))
          .thenAnswer((_) async => Response('Not found', HttpStatus.notFound));
      // act
      final call = dataSource.getCovidStatistics;
      // assert
      expect(() => call(tCovidDate), throwsA(TypeMatcher<ServerException>()));
    },
  );
}
