import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class View {
  late MediaQueryData _mediaQueryData;
  static late double x;
  static late double y;
  void init(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _mediaQueryData = MediaQuery.of(context);
    x = _mediaQueryData.size.width / 100;
    y = _mediaQueryData.size.height / 100;
  }
}
