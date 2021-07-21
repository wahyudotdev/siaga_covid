import 'package:equatable/equatable.dart';

class CovidStatistics extends Equatable {
  final String? countryRegion;
  final DateTime? lastUpdate;
  final int? confirmed;
  final int? deaths;
  final int? recovered;
  final int? active;

  CovidStatistics({
    this.countryRegion,
    this.lastUpdate,
    this.confirmed,
    this.deaths,
    this.recovered,
    this.active,
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
