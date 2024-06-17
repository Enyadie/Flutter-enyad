import 'package:intl/intl.dart';

class SFormatter{
  static String formatDate(DateTime? date){
    date ??= DateTime.now();
    return DateFormat('dd-mm-yyyy').format(date);
  }

  static String formatCurrency(double amount){
    return NumberFormat.currency(locale: 'en_JMD',symbol: '\$').format(amount);
  }

  static String formatPhoneNumber(String phoneNumber){
    if (phoneNumber.length == 7) {
      // Format for 7-digit phone number
      return "1-876-${phoneNumber.substring(0, 3)}${phoneNumber.substring(3)}";
    } else if (phoneNumber.length == 10) {
      // Format for 10-digit phone number
      return "1-${phoneNumber.substring(0, 3)}${phoneNumber.substring(3, 6)}${phoneNumber.substring(6)}";
    } else if (phoneNumber.length == 11) {
      // Format for 11-digit phone number
      return "${phoneNumber.substring(0, 1)}${phoneNumber.substring(1, 4)}${phoneNumber.substring(4, 7)}${phoneNumber.substring(7)}";
    }
    // Return original phone number if length is not 7, 10, or 11
    return phoneNumber;
  }


}