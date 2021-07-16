import 'dart:io';

import 'package:covid_statistics/data/covid_daily_statistics.dart';
import 'package:dio/dio.dart';

class ApiGlobal {
  final String date;

  ApiGlobal(this.date);
  Future<List<CovidDailyStatistics>> getGlobalStatistics() async {
    try {
      final response =
          await Dio().get('https://covid19.mathdro.id/api/daily/${this.date}');
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> list = response.data;
        return list.map((e) => CovidDailyStatistics.fromMap(e)).toList();
      } else
        return Future.error('Error');
    } catch (e) {
      return Future.error(e);
    }
  }
}
