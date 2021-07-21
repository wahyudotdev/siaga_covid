import '../../../../data/covid_daily_statistics.dart';
import '../../../../data/covid_series.dart';
import '../../../../repository/api_global.dart';
import '../widgets/covid_chart.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/view.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/number_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StatisticPage extends StatefulWidget {
  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  List<List<CovidDailyStatistics>> covidStatistics = [];
  CovidDailyStatistics realtimeData = CovidDailyStatistics();
  List<CovidSeries> data = [];

  void getDaysOfWeek() {
    List<String> days = [];
    for (int i = 1; i < 8; i++) {
      var d = DateTime.now().subtract(Duration(days: i));
      days.add('${d.month}-${d.day}-${d.year}');
    }
    var task = days.map((e) => ApiGlobal(e));
    task.forEach((element) async {
      try {
        var result = await element.getGlobalStatistics();
        setState(() {
          covidStatistics.add(result);
          realtimeData = result
              .firstWhere((element) => element.countryRegion == 'Indonesia');
          data.add(CovidSeries(
            date: realtimeData.lastUpdate!.day.toString(),
            confirmed: realtimeData.confirmed,
            color: charts.ColorUtil.fromDartColor(lightblue),
          ));
        });
      } catch (e) {
        print(e);
      }
    });
  }

  void countLocalStatistics() {
    List<CovidSeries> d = [];
    covidStatistics.forEach((element) {
      var result =
          element.firstWhere((element) => element.countryRegion == 'Indonesia');
      d.add(CovidSeries(
        date: result.lastUpdate!.day.toString(),
        confirmed: result.confirmed,
        color: charts.ColorUtil.fromDartColor(lightblue),
      ));
    });

    setState(() {
      realtimeData = covidStatistics.first
          .firstWhere((element) => element.countryRegion == 'Indonesia');
      data = d;
    });
  }

  void countWorldStatistics() {
    int confirmed = 0;
    int recovered = 0;
    int death = 0;
    int active = 0;

    covidStatistics.first.forEach((element) {
      confirmed += element.confirmed;
      recovered += element.recovered;
      death += element.deaths;
      active += element.active;
    });

    List<CovidSeries> d = [];
    covidStatistics.forEach((element) {
      int _confirmed = 0;
      element.forEach((element) => _confirmed += element.confirmed);
      d.add(CovidSeries(
        date: element.first.lastUpdate!.day.toString(),
        confirmed: _confirmed,
        color: charts.ColorUtil.fromDartColor(lightblue),
      ));
    });

    setState(() {
      realtimeData = CovidDailyStatistics(
          confirmed: confirmed,
          recovered: recovered,
          deaths: death,
          active: active);
      data = d;
    });
  }

  @override
  void initState() {
    super.initState();
    getDaysOfWeek();
  }

  Widget _title() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(View.x * 7),
        child: Text(
          'Statistik',
          style: TextStyle(
            color: Colors.white,
            fontSize: View.x * 6,
          ),
        ),
      ),
    );
  }

  Widget _regionTabBar() {
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 2,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: TabBar(
            indicator: BubbleTabIndicator(
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              indicatorHeight: 40.0,
              indicatorColor: Colors.white,
            ),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Text('Indonesia'),
              Text('Global'),
            ],
            onTap: (index) {
              if (index == 0) {
                countLocalStatistics();
              } else {
                countWorldStatistics();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _singleStatsBox({required String hint, required String count, Color? color}) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(View.x * 3),
      ),
      padding: EdgeInsets.all(View.x * 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Text(
              hint,
              style: TextStyle(color: Colors.white, fontSize: View.x * 5),
            ),
          ),
          Flexible(
            flex: 1,
            child: Text(
              count,
              style: TextStyle(color: Colors.white, fontSize: View.x * 4.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statisticGrid() {
    return SliverToBoxAdapter(
      child: Container(
        width: View.x * 100,
        height: View.y * 35,
        padding: EdgeInsets.all(View.x * 7),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 2 / 1,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          children: [
            _singleStatsBox(
                color: orange,
                hint: 'Total',
                count: numberFormat().format(realtimeData.confirmed)),
            _singleStatsBox(
                color: red2,
                hint: 'Meninggal',
                count: numberFormat().format(realtimeData.deaths)),
            _singleStatsBox(
                color: lightblue2,
                hint: 'Aktif',
                count: numberFormat().format(realtimeData.active)),
            _singleStatsBox(
                color: green,
                hint: 'Sembuh',
                count: numberFormat().format(realtimeData.recovered)),
          ],
        ),
      ),
    );
  }

  Widget _statisticChart() {
    return SliverToBoxAdapter(
      child: Container(
        width: View.x * 100,
        height: View.y * 35,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(View.x * 10),
            topRight: Radius.circular(View.x * 10),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Colors.white.withOpacity(0.1),
              spreadRadius: 3,
              offset: Offset(3, 3),
            )
          ],
        ),
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: View.x * 7, top: View.y * 5),
                child: Text('Data bulan ${months[DateTime.now().month - 1]}'),
              ),
            ),
            Flexible(
              flex: 5,
              child: data.length == 0
                  ? Center(
                      child: Text(
                        'Kosong',
                        style: TextStyle(fontSize: View.x * 5),
                      ),
                    )
                  : CovidChart(
                      data: data.reversed.toList(),
                    ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkblue,
      child: CustomScrollView(
        slivers: [
          _title(),
          _regionTabBar(),
          _statisticGrid(),
          _statisticChart(),
        ],
      ),
    );
  }
}
