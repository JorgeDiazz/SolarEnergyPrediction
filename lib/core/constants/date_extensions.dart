import 'package:intl/intl.dart';

extension DateExtension on int {
  String getDayName() {
    final date = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    return DateFormat('EEEE').format(date);
  }

  String getTime() {
    final date = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    return DateFormat.Hm().format(date);
  }
}
