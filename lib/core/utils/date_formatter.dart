import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDateTime(DateTime dt) {
    // Example: Jan 20, 7:40 pm
    return DateFormat('MMM d, h:mm a').format(dt);
  }

  static String formatDateRange(DateTime start, DateTime end) {
    // Example: Jan 21 - Jan 22, 2025
    final startFormat = DateFormat('MMM d');
    final endFormat = DateFormat('MMM d, yyyy');
    return '${startFormat.format(start)} - ${endFormat.format(end)}';
  }

  static String formatDateInput(DateTime dt) {
    // Example: 05-03-2025
    return DateFormat('dd-MM-yyyy').format(dt);
  }

  static String formatDateSimple(DateTime dt) {
    // Example: 04/03/2025
    return DateFormat('dd/MM/yyyy').format(dt);
  }
}
