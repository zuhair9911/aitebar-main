import 'package:intl/intl.dart';
extension DateTimeExtension on DateTime {
  String get timeAgo {
    final difference = DateTime.now().difference(this);
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inSeconds > 0) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'just now';
    }
  }

  String format({String format = 'yyyy-MM-dd'}) {
    return DateFormat(format).format(this);
  }
}