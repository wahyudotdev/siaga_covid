import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/covid_statistics_bloc.dart';
import '../widgets/covid_chart.dart';
import '../../domain/entities/covid_series.dart';
import '../../../../injection_container.dart';
import '../../../../data/covid_daily_statistics.dart';
import '../../../../repository/api_global.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/view.dart';
import '../../../../utils/constant.dart';

class StatisticPage extends StatefulWidget {
  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  final bloc = sl<CovidStatisticsBloc>();
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
    // getDaysOfWeek();
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
            onTap: null,
          ),
        ),
      ),
    );
  }

  Widget _singleStatsBox(
      {String? hint, String? count, Color? color, required bool isLoading}) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(View.x * 3),
      ),
      padding: EdgeInsets.all(View.x * 5),
      child: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    hint!,
                    style: TextStyle(color: Colors.white, fontSize: View.x * 5),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Text(
                    count!,
                    style:
                        TextStyle(color: Colors.white, fontSize: View.x * 4.5),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _statisticGrid() {
    return SliverToBoxAdapter(
      child: BlocBuilder<CovidStatisticsBloc, CovidStatisticsState>(
        builder: (context, state) {
          print(state.runtimeType);
          if (state is Empty) bloc.add(CovidStatisticsOfWeekEvent());
          if (state is LoadedSummaryByCountry) {
            return Container(
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
                    count: state.data.confirmed,
                    isLoading: false,
                  ),
                  _singleStatsBox(
                    color: red2,
                    hint: 'Meninggal',
                    count: state.data.deaths,
                    isLoading: false,
                  ),
                  _singleStatsBox(
                    color: lightblue2,
                    hint: 'Aktif',
                    count: state.data.active,
                    isLoading: false,
                  ),
                  _singleStatsBox(
                    color: green,
                    hint: 'Sembuh',
                    count: state.data.recovered,
                    isLoading: false,
                  ),
                ],
              ),
            );
          }
          return Container(
            width: View.x * 100,
            height: View.y * 35,
            padding: EdgeInsets.all(View.x * 7),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
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
    return BlocProvider(
      create: (context) => bloc,
      child: Container(
        color: darkblue,
        child: CustomScrollView(
          slivers: [
            _title(),
            _regionTabBar(),
            _statisticGrid(),
            _statisticChart(),
          ],
        ),
      ),
    );
  }
}
