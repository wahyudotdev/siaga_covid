import 'package:charts_flutter/flutter.dart' as charts;

class CovidSeries {
  final String date;
  final int confirmed;
  final charts.Color color;

  CovidSeries({this.date, this.confirmed, this.color});
}
