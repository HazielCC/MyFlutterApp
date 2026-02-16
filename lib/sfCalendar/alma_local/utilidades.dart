import 'package:intl/intl.dart';

class Utilidades {
  static String toDateTime(DateTime dateTime) {
    final time = DateFormat.Hm().format(dateTime);
    final date = DateFormat.yMMMEd().format(dateTime);
    return '$time $date';
  }

  static String toDate(DateTime dateTime) {
    final date = DateFormat.Hm().format(dateTime);
    return '$date';
  }

  static String toTime(DateTime dateTime) {
    final time = DateFormat.Hm().format(dateTime);
    return '$time';
  }
}
