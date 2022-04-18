
import 'package:uni_meet/app/data/model/firestore_keys.dart';


class NewsModel {
  String? news;
  String? address;
  DateTime? createdDate;
  int? type; // 0번 그 외 / 1번 포스트 / 2번 채팅 / 3번 공지사항

  NewsModel(
      {required this.news,
        required this.address,
        required this.type,
        required this.createdDate
      });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      news: json[KEY_NEWS_NEWS] == null ? '' : json[KEY_NEWS_NEWS] as String,
      address: json[KEY_NEWS_ADDRESS] == null ? '' : json[KEY_NEWS_ADDRESS] as String,
      type : json[KEY_NEWS_TYPE] == null ? 0 : json[KEY_NEWS_TYPE] as int,
      createdDate: json[KEY_NOTICE_DATE] == null
          ? DateTime.now()
          : json[KEY_NOTICE_DATE].toDate(),
       );
  }

  Map<String, dynamic> toMap() {
    return {
      KEY_NEWS_NEWS: news,
      KEY_NEWS_ADDRESS: address,
      KEY_NEWS_TYPE:type,
      KEY_NEWS_CREATEDDATE:createdDate,
    };
  }
}
