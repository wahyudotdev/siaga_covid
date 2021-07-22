import 'package:clock/clock.dart';
import 'package:intl/intl.dart';

class GetDateParam {
  daysOfWeek() {
    List<String> list = [];
    for (var i = 0; i < 7; i++) {
      final date = clock.now().subtract(Duration(days: i + 1));
      list.add(DateFormat('MM-dd-yyyy').format(date));
    }
    return list.reversed.toList();
  }
}
