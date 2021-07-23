import 'package:covid_statistics/injection_container.dart' as di;
import 'package:flutter/material.dart';

import 'features/menu_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await di.sl.allReady();
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
