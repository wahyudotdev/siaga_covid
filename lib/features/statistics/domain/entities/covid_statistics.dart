import 'package:equatable/equatable.dart';

class CovidStatistics extends Equatable {
  final List<CovidStatisticItem> items;

  CovidStatistics(this.items);

  @override
  List<Object?> get props => [items];
}

class CovidStatisticItem extends Equatable {
  final String countryRegion;
  final DateTime lastUpdate;
  final int confirmed;
  final int deaths;
  final int recovered;
  final int active;

  CovidStatisticItem({
    required this.countryRegion,
    required this.lastUpdate,
    required this.confirmed,
    required this.deaths,
    required this.recovered,
    required this.active,
  });

  @override
  List<Object?> get props => [
        countryRegion,
        lastUpdate,
        confirmed,
        deaths,
        recovered,
        active,
      ];
}
