import 'package:covid_statistics/features/statistics/data/models/covid_statistics_model.dart';
import 'package:covid_statistics/features/statistics/domain/entities/covid_statistics.dart';

final tCovidStatisticItem = [
  CovidStatisticItem(
    countryRegion: 'Test',
    active: 100,
    confirmed: 100,
    deaths: 100,
    lastUpdate: DateTime.parse("2021-07-21 08:00:00"),
    recovered: 100,
  ),
  CovidStatisticItem(
    countryRegion: 'Indonesia',
    active: 100,
    confirmed: 100,
    deaths: 100,
    lastUpdate: DateTime.parse("2021-07-21 08:00:00"),
    recovered: 100,
  )
];
final tCovidStatistics = CovidStatistics(tCovidStatisticItem);

final tCovidStatisticsModel = CovidStatisticsModel(tCovidStatisticItem);

final tCovidDate = '07-14-2021';
final daysOfWeek = [
  '07-14-2021',
  '07-15-2021',
  '07-16-2021',
  '07-17-2021',
  '07-18-2021',
  '07-19-2021',
  '07-20-2021',
];
