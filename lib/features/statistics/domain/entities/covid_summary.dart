import 'package:equatable/equatable.dart';

class CovidSummary extends Equatable {
  final String confirmed;
  final String active;
  final String deaths;
  final String recovered;

  CovidSummary({
    required this.confirmed,
    required this.active,
    required this.deaths,
    required this.recovered,
  });

  @override
  List<Object?> get props => [confirmed, active, deaths, recovered];
}
