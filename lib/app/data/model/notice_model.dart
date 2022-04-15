import 'package:uni_meet/app/data/model/firestore_keys.dart';

class NoticeModel {
  String? title;
  String? description;
  DateTime? createdDate;

  NoticeModel({
    required this.title,
    required this.description,
    required this.createdDate,
  });

  factory NoticeModel.fromJson(Map<String, dynamic> json) {
    return NoticeModel(
      createdDate: json[KEY_NOTICE_DATE] == null
          ? DateTime.now()
          : json[KEY_NOTICE_DATE].toDate(),
      title: json[KEY_NOTICE_TITLE] == null
          ? ''
          : json[KEY_NOTICE_TITLE] as String,
      description: json[KEY_NOTICE_DESCRIPTION] == null
          ? ''
          : json[KEY_NOTICE_DESCRIPTION] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      KEY_NOTICE_TITLE: title,
      KEY_NOTICE_DESCRIPTION: description,
      KEY_NOTICE_DATE: createdDate,
    };
  }
}