import 'package:covid_statistics/core/utils/app_colors.dart';
import 'package:covid_statistics/core/utils/constant.dart';
import 'package:covid_statistics/core/utils/view.dart';
import 'package:covid_statistics/features/statistics/presentation/widgets/covid_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/covid_statistics_bloc.dart';
import '../../../../injection_container.dart';

class StatisticPage extends StatelessWidget {
  final bloc = sl<CovidStatisticsBloc>();
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
            onTap: (tab) {
              if (tab == 0) {
                bloc.add(SummaryCountryEvent());
              } else
                bloc.add(SummaryWorldEvent());
            },
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

  Widget _showStatistics(
      {required bool isLoading,
      required String confirmed,
      required String active,
      required String deaths,
      required String recovered}) {
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
            count: confirmed,
            isLoading: isLoading,
          ),
          _singleStatsBox(
            color: red2,
            hint: 'Meninggal',
            count: deaths,
            isLoading: isLoading,
          ),
          _singleStatsBox(
            color: lightblue2,
            hint: 'Aktif',
            count: active,
            isLoading: isLoading,
          ),
          _singleStatsBox(
            color: green,
            hint: 'Sembuh',
            count: recovered,
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }

  Widget _statisticGrid() {
    return SliverToBoxAdapter(
      child: BlocBuilder<CovidStatisticsBloc, CovidStatisticsState>(
        builder: (context, state) {
          if (state is Empty) bloc.add(CovidStatisticsOfWeekEvent());
          if (state is LoadedStatistics) {
            bloc.add(SummaryWorldEvent());
            bloc.add(SummaryCountryEvent());
          }
          if (state is LoadedSummaryByCountry) {
            return _showStatistics(
              isLoading: false,
              confirmed: state.data.confirmed,
              active: state.data.active,
              deaths: state.data.deaths,
              recovered: state.data.recovered,
            );
          }
          if (state is LoadedSummaryWorld) {
            return _showStatistics(
              isLoading: false,
              confirmed: state.data.confirmed,
              active: state.data.active,
              deaths: state.data.deaths,
              recovered: state.data.recovered,
            );
          }
          return _showStatistics(
            isLoading: true,
            confirmed: '0',
            active: '0',
            deaths: '0',
            recovered: '0',
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
              child: BlocBuilder<CovidStatisticsBloc, CovidStatisticsState>(
                builder: (context, state) {
                  return Center(
                    child: bloc.covidSeries.length == 0
                        ? CircularProgressIndicator()
                        : CovidChart(
                            data: bloc.covidSeries,
                          ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _snackBar() {
    return SliverToBoxAdapter(
      child: BlocBuilder<CovidStatisticsBloc, CovidStatisticsState>(
        builder: (context, state) {
          final snackBar = SnackBar(content: Text('Gagal memuat data'));
          if (state is Error) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Future.delayed(Duration(seconds: 5),
                () => bloc.add(CovidStatisticsOfWeekEvent()));
          }
          return Container();
        },
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
            _snackBar(),
          ],
        ),
      ),
    );
  }
}
