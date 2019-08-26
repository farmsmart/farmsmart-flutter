import 'package:intl/intl.dart';

class _Constants {
  static final dateFormatter = DateFormat('dd MMMM yyyy');
}

class DateFormatter {

  static String formatDate(DateTime date) => _Constants.dateFormatter.format(date);
  
}
