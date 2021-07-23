import '../../domain/entities/covid_statistics.dart';
import '../../domain/entities/covid_summary.dart';

class CovidSummaryModel extends CovidSummary {
  final String confirmed;
  final String active;
  final String deaths;
  final String recovered;
  CovidSummaryModel({
    required this.confirmed,
    required this.active,
    required this.deaths,
    required this.recovered,
  }) : super(
          confirmed: confirmed,
          active: active,
          deaths: deaths,
          recovered: recovered,
        );
  factory CovidSummaryModel.fromStatistics(
      {required List<CovidStatistics> statistics, String? country}) {
    var confirmed = 0;
    var active = 0;
    var deaths = 0;
    var recovered = 0;
    if (country == null) {
      statistics.first.items.forEach((state) {
        confirmed += state.confirmed;
        active += state.active;
        deaths += state.deaths;
        recovered += state.recovered;
      });
    } else {
      final byCountry = statistics.first.items
          .firstWhere((element) => element.countryRegion == country);
      confirmed += byCountry.confirmed;
      active += byCountry.active;
      deaths += byCountry.deaths;
      recovered += byCountry.recovered;
    }
    return CovidSummaryModel(
      confirmed: confirmed.toString(),
      active: active.toString(),
      deaths: deaths.toString(),
      recovered: recovered.toString(),
    );
  }
}
