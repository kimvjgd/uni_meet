import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:timeago/timeago.dart';

class TimeAgo {
  static setLocalMessages() {
    setLocaleMessages('ko', KoMessages());
  }

  static String timeAgoSinceData(DateTime time){
    final date2 = DateTime.now();
    final diff = date2.difference(time);

    if (diff.inDays >= 1)
      return DateFormat("yyyy-MM-dd HH:mm").format(time);
    if(diff.inHours >= 1)
      return DateFormat("HH:mm").format(time);
    else{
      return timeago.format(time, locale: 'ko', allowFromNow: true);
    }
  }
  static String timeCustomFormat(DateTime date) {
    // final date = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    return format(date, locale: 'ko', allowFromNow: true);
  }
}

class KoMessages implements LookupMessages {
  String prefixAgo() => '';

  String prefixFromNow() => '';

  String suffixAgo() => '전';

  String suffixFromNow() => '후';

  String lessThanOneMinute(int seconds) => '방금';

  String aboutAMinute(int minutes) => '방금';

  String minutes(int minutes) => '$minutes분';

  String aboutAnHour(int minutes) => '1시간';

  String hours(int hours) => '$hours시간';

  String aDay(int hours) => '1일';

  String days(int days) => '$days일';

  String aboutAMonth(int days) => '한달';

  String months(int months) => '$months개월';

  String aboutAYear(int year) => '1년';

  String years(int years) => '$years년';

  String wordSeparator() => ' ';
}
