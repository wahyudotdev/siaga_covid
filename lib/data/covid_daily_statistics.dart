// To parse this JSON data, do
//
//     final covidDailyStatistics = covidDailyStatisticsFromMap(jsonString);

import 'dart:convert';

class CovidDailyStatistics {
  CovidDailyStatistics({
    this.provinceState,
    this.countryRegion,
    this.lastUpdate,
    this.confirmed = 0,
    this.deaths = 0,
    this.recovered = 0,
    this.active = 0,
  });

  final String? provinceState;
  final String? countryRegion;
  final DateTime? lastUpdate;
  final int confirmed;
  final int deaths;
  final int recovered;
  final int active;
  factory CovidDailyStatistics.fromJson(String str) =>
      CovidDailyStatistics.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CovidDailyStatistics.fromMap(Map<String, dynamic> json) =>
      CovidDailyStatistics(
          provinceState: json["provinceState"],
          countryRegion: json["countryRegion"],
          lastUpdate: DateTime.parse(json["lastUpdate"]),
          confirmed: int.tryParse(json["confirmed"]) ?? 0,
          deaths: int.tryParse(json["deaths"]) ?? 0,
          recovered: int.tryParse(json["recovered"]) ?? 0,
          active: int.tryParse(json["active"]) ?? 0);

  Map<String, dynamic> toMap() => {
        "provinceState": provinceState,
        "countryRegion": countryRegion,
        "lastUpdate": lastUpdate!.toIso8601String(),
        "confirmed": confirmed,
        "deaths": deaths,
        "recovered": recovered,
        "active": active
      };
}
