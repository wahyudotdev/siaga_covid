import 'dart:io';

import 'package:covid_statistics/features/statistics/domain/entities/covid_statistics.dart';

import '../../../../core/error/exception.dart';
import '../models/covid_statistics_model.dart';
import 'package:http/http.dart';

abstract class CovidStatisticsRemoteDataSource {
  /// Throw [ServerException] on error
  Future<CovidStatistics> getCovidStatistics(String date);
}

const SERVER_API_BASE_URL = 'https://covid19.mathdro.id/api/daily';

class CovidStatisticsRemoteDataSourceImpl
    implements CovidStatisticsRemoteDataSource {
  final Client httpClient;

  CovidStatisticsRemoteDataSourceImpl(this.httpClient);

  @override
  Future<CovidStatistics> getCovidStatistics(String date) async {
    final response =
        await httpClient.get(Uri.parse(SERVER_API_BASE_URL + '/$date'));
    if (response.statusCode == HttpStatus.ok) {
      final result = CovidStatisticsModel.fromJsonString(response.body);
      if (result.items.length == 0) {
        throw FormatException();
      } else {
        return result;
      }
    } else {
      throw ServerException();
    }
  }
}
