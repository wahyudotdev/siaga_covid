import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/covid_statistics.dart';
import 'package:intl/intl.dart';

class CovidStatisticsModel extends CovidStatistics implements Equatable {
  CovidStatisticsModel(List<CovidStatisticItem> items) : super(items);

  factory CovidStatisticsModel.fromJsonString(String jsonString) {
    List<dynamic> jsonData = json.decode(jsonString);
    final items = jsonData
        .map(
          (data) => CovidStatisticItem(
            countryRegion: data['countryRegion'],
            active: int.parse(data['active']),
            confirmed: int.parse(data['confirmed']),
            deaths: int.parse(data['deaths']),
            lastUpdate: DateTime.parse(data['lastUpdate']),
            recovered: int.parse(data['recovered']),
          ),
        )
        .toList();
    return CovidStatisticsModel(items);
  }

  toJsonString() {
    final jsonMap = items
        .map(
          (e) => {
            'countryRegion': e.countryRegion,
            'active': e.active.toString(),
            'confirmed': e.confirmed.toString(),
            'deaths': e.deaths.toString(),
            'lastUpdate':
                DateFormat('yyyy-MM-dd hh:mm:ss').format(e.lastUpdate),
            'recovered': e.recovered.toString()
          },
        )
        .toList();
    return json.encode(jsonMap);
  }

  @override
  List<Object> get props => [this.items];
}
