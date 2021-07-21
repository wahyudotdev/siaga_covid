import '../../../../data/covid_series.dart';
import '../../../../utils/number_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class CovidChart extends StatelessWidget {
  final List<CovidSeries> data;

  const CovidChart({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<charts.Series<CovidSeries, String>> series = [
      charts.Series(
        id: 'covid series',
        data: data,
        domainFn: (series, _) => series.date,
        measureFn: (series, _) => series.confirmed,
        colorFn: (series, _) => series.color,
      ),
    ];
    final simpleFormatter =
        charts.BasicNumericTickFormatterSpec.fromNumberFormat(numberFormat());
    return charts.BarChart(
      series,
      barGroupingType: charts.BarGroupingType.grouped,
      defaultRenderer: charts.BarRendererConfig(
        cornerStrategy: charts.ConstCornerStrategy(30),
        maxBarWidthPx: 10,
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
        tickFormatterSpec: simpleFormatter,
      ),
    );
  }
}
