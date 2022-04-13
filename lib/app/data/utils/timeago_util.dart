import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;


class TimeAgo {
  static String timeAgoSinceData(DateTime time){
    final date2 = DateTime.now();
    final diff = date2.difference(time);

    if (diff.inDays >= 1)
      return DateFormat("yyyy-MM-dd HH:mm").format(time);
    if(diff.inHours >= 1)
      return DateFormat("HH:mm").format(time);
    else{
      return timeago.format(time);
    }
  }
}