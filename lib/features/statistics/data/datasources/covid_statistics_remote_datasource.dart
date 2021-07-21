import 'dart:io';

import 'package:covid_statistics/core/error/exception.dart';
import 'package:covid_statistics/features/statistics/data/models/covid_statistics_model.dart';
import 'package:http/http.dart';

abstract class CovidStatisticsRemoteDataSource {
  /// Throw [ServerException] on error
  Future<CovidStatisticsModel> getCovidStatistics(String date);
}

const SERVER_API_BASE_URL = 'https://covid19.mathdro.id/api/daily';

class CovidStatisticsRemoteDataSourceImpl
    implements CovidStatisticsRemoteDataSource {
  final Client httpClient;

  CovidStatisticsRemoteDataSourceImpl(this.httpClient);

  @override
  Future<CovidStatisticsModel> getCovidStatistics(String date) async {
    final response =
        await httpClient.get(Uri.parse(SERVER_API_BASE_URL + '/$date'));
    if (response.statusCode == HttpStatus.ok) {
      return CovidStatisticsModel.fromJsonString(response.body);
    } else {
      throw ServerException();
    }
  }
}
