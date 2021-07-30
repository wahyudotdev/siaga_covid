import 'dart:convert';

import '../../domain/entities/covid_series.dart';
import '../../domain/entities/covid_statistics.dart';

class CovidSeriesModel extends CovidSeries {
  final String date;
  final int confirmed;
  CovidSeriesModel({required this.date, required this.confirmed})
      : super(confirmed: confirmed, date: date);

  factory CovidSeriesModel.fromStatistics(CovidStatistics list) {
    var confirmed = 0;
    list.items.forEach((element) => confirmed += element.confirmed);
    return CovidSeriesModel(
      date: list.items.first.lastUpdate.day.toString(),
      confirmed: confirmed,
    );
  }

  factory CovidSeriesModel.fromJsonString(
      {required String jsonString, String? key}) {
    var confirmed = 0;
    List<dynamic> items = json.decode(jsonString);
    if (key == null) {
      items.forEach((element) {
        confirmed += int.tryParse(element['confirmed']) ?? 0;
      });
    } else {
      items.forEach((element) {
        if (element['countryRegion'] == key) {
          confirmed += int.tryParse(element['confirmed']) ?? 0;
        }
      });
    }
    return CovidSeriesModel(
      date: DateTime.parse(items.first['lastUpdate']).day.toString(),
      confirmed: confirmed,
    );
  }
}
