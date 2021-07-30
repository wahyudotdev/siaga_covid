import 'package:charts_flutter/flutter.dart' as charts;
import '../../../../core/utils/app_colors.dart';
import '../../domain/entities/covid_series.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/number_format.dart';

class CovidChart extends StatelessWidget {
  final List<CovidSeries>? data;

  const CovidChart({Key? key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<charts.Series<CovidSeries, String>> series = [
      charts.Series(
        id: 'covid series',
        data: data!,
        domainFn: (series, _) => series.date,
        measureFn: (series, _) => series.confirmed,
        colorFn: (series, _) => charts.ColorUtil.fromDartColor(lightblue),
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
