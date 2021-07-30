import '../../../../core/error/exception.dart';
import '../../../../core/local_storage/local_storage.dart';
import '../models/covid_statistics_model.dart';
import '../../domain/entities/covid_statistics.dart';
import 'package:intl/intl.dart';

abstract class CovidStatisticsLocalDataSource {
  /// Throw [CacheException] when there is no data
  Future<CovidStatistics> getCovidStatistics(String date);
  Future<void> saveCovidStatistics(CovidStatistics covidStatistics);
}

class CovidStatisticsLocalDataSourceImpl
    extends CovidStatisticsLocalDataSource {
  final LocalStorage localStorage;

  CovidStatisticsLocalDataSourceImpl(this.localStorage);

  @override
  Future<CovidStatistics> getCovidStatistics(String date) async {
    try {
      final jsonString = await localStorage.getData(key: date);
      return CovidStatisticsModel.fromJsonString(jsonString);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> saveCovidStatistics(CovidStatistics covidStatistics) async {
    final date = covidStatistics.items.first.lastUpdate;
    final key = DateFormat('MM-dd-yyyy').format(date);
    final value = CovidStatisticsModel(covidStatistics.items);
    await localStorage.saveData(key: key, value: value.toJsonString());
  }
}
