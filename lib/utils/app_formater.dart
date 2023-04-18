import 'package:intl/intl.dart';

class AppFormatter {
  static String date(DateTime date) {
    return DateFormat('EEE d, MMMM, yyyy', 'es_ES').format(date);
  }
}
