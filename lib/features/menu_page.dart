import 'home/presentation/pages/home_page.dart';
import 'news/presentation/pages/news_page.dart';
import 'statistics/presentation/pages/statistic_page.dart';
import '../utils/app_colors.dart';
import '../utils/view.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int pageIndex = 0;

  final _pages = <Widget>[
    HomePage(),
    StatisticPage(),
    NewsPage(),
  ];

  final _bottomNavBarItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home_filled),
      label: 'Beranda',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.bar_chart),
      label: 'Statistik',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.book),
      label: 'Berita',
    )
  ];

  @override
  Widget build(BuildContext context) {
    View().init(context);
    return Container(
      color: darkblue,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: IndexedStack(
            index: pageIndex,
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: _bottomNavBarItems,
            backgroundColor: black,
            currentIndex: pageIndex,
            selectedItemColor: lightblue,
            unselectedItemColor: Colors.white,
            onTap: (selected) => setState(() => pageIndex = selected),
          ),
        ),
      ),
    );
  }
}
