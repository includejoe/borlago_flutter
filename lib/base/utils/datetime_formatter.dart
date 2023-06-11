import 'package:intl/intl.dart';


String? formatDateTime(String? dateTime) {
  if(dateTime != null) {
    DateTime formattedDateTime = DateTime.parse(dateTime);

    DateTime now = DateTime.now();
    if (formattedDateTime.year == now.year &&
        formattedDateTime.month == now.month &&
        formattedDateTime.day == now.day) {
      return 'Today, ${DateFormat('hh:mm a').format(formattedDateTime)}';
    } else if (formattedDateTime.year == now.year &&
        formattedDateTime.month == now.month &&
        formattedDateTime.day == now.day - 1) {
      return 'Yesterday, ${DateFormat('hh:mm a').format(formattedDateTime)}';
    } else {
      return DateFormat('MM-dd-yyyy, hh:mm a').format(formattedDateTime);
    }
  } else {
    return null;
  }
}