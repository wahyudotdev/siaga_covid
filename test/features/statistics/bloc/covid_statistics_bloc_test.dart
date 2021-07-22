import 'package:covid_statistics/core/query_helper/date_param_helper.dart';
import 'package:covid_statistics/core/utils/short_list.dart';
import 'package:covid_statistics/features/statistics/domain/usecases/get_covid_statistics_of_week.dart';
import 'package:covid_statistics/features/statistics/presentation/bloc/covid_statistics_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'covid_statistics_bloc_test.mocks.dart';

@GenerateMocks([
  GetCovidStatisticsOfWeek,
  GetDateParam,
  ShortList,
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

  group('GetCovidStatisticsOfWeek', () {
    test(
      'should ',
      () async {
        // arrange

        // act

        // assert
      },
    );
  });
}
