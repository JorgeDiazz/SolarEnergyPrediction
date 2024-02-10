import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toYearMonthDay() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(this);
    return formatted;
  }
}
