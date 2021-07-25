import 'package:intl/intl.dart';

NumberFormat numberFormat() {
  return NumberFormat.compactCurrency(
      decimalDigits: 2, symbol: '', locale: 'ID');
}
