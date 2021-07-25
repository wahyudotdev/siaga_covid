import 'dart:convert';

import '../../domain/entities/covid_statistics.dart';
import 'package:intl/intl.dart';

class CovidStatisticsModel extends CovidStatistics {
  CovidStatisticsModel(List<CovidStatisticItem> items) : super(items);

  factory CovidStatisticsModel.fromJsonString(String jsonString) {
    List<dynamic> jsonData = json.decode(jsonString);
    if (jsonData.length > 0) {
      final items = jsonData
          .map(
            (data) => CovidStatisticItem(
              countryRegion: data['countryRegion'],
              active: int.tryParse(data['active']) ?? 0,
              confirmed: int.tryParse(data['confirmed']) ?? 0,
              deaths: int.tryParse(data['deaths']) ?? 0,
              lastUpdate: DateTime.parse(data['lastUpdate']),
              recovered: int.tryParse(data['recovered']) ?? 0,
            ),
          )
          .toList();
      return CovidStatisticsModel(items);
    } else {
      return CovidStatisticsModel([]);
    }
  }

  String toJsonString() {
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
}
