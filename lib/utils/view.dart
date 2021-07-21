import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';

class View {
  MediaQueryData _mediaQueryData;
  static double x;
  static double y;
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
