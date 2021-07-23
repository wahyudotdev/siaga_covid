import '../../features/statistics/domain/entities/covid_statistics.dart';

class ShortList {
  List<CovidStatistics> shortByDate(List<CovidStatistics> list) {
    list.sort(
        (a, b) => a.items.first.lastUpdate.compareTo(b.items.first.lastUpdate));
    return list;
  }
}
