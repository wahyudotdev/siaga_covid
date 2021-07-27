import 'package:covid_statistics/core/local_storage/local_storage.dart';
import 'package:covid_statistics/features/news/data/datasource/news_local_datasource.dart';
import 'package:covid_statistics/features/statistics/domain/repositories/covid_statistics_repository.dart';
import 'injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'features/menu_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await di.sl.allReady();
  await di.sl.get<LocalStorage>(instanceName: STATISTICS_BOX_NAME).init();
  await di.sl.get<LocalStorage>(instanceName: NEWS_BOX_NAME).init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Siaga Covid',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuPage(),
    );
  }
}
