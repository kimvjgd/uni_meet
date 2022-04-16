import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_meet/app/data/model/firestore_keys.dart';

class PostModel {
  final String postKey;
  final String? host;
  final String? place;
  final int? headCount;
  final String? title;
  final DateTime? createdDate;
  final int numComments;
  final String? content;
  final String? hostpushToken;
  final String? hostUni;
  final String? hostNick;
  final String? hostGrade;
  // final DocumentReference reference;

  PostModel({
    required this.postKey,
    required this.host,
    required this.place,
    required this.numComments,
    required this.headCount,
    required this.title,
    required this.createdDate,
    required this.content,
    required this.hostpushToken,
    required this. hostUni,
    required this. hostNick,
    required this. hostGrade,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postKey: json[KEY_POST_POSTKEY] == null
          ? ''
          : json[KEY_POST_POSTKEY] as String,
      host: json[KEY_POST_HOST] == null ? '' : json[KEY_POST_HOST] as String,
      place: json[KEY_POST_PLACE] == null ? '' : json[KEY_POST_PLACE] as String,
      headCount: json[KEY_POST_HEADCOUNT] == null
          ? 1
          : json[KEY_POST_HEADCOUNT] as int,
      title: json[KEY_POST_TITLE] == null ? '' : json[KEY_POST_TITLE] as String,
      createdDate: json[KEY_POST_CREATEDDATE] == null
          ? DateTime.now()
          : json[KEY_POST_CREATEDDATE].toDate(),
      content: json[KEY_POST_CONTENT] == null
          ? ''
          : json[KEY_POST_CONTENT] as String,
      hostpushToken: json[KEY_POST_HOSTPUSHTOKEN] == null
          ? ''
          : json[KEY_POST_HOSTPUSHTOKEN] as String,
      numComments: json[KEY_POST_NUMCOMMENTS] == null
          ? 0
          : json[KEY_POST_NUMCOMMENTS] as int,
      hostGrade: json[KEY_POST_HOSTGRADE] == null ? '' : json[KEY_POST_HOSTGRADE] as String,
      hostNick: json[KEY_POST_HOSTNICK] == null ? '' : json[KEY_POST_HOSTNICK] as String,
      hostUni:json[KEY_POST_HOSTUNI] == null ? '' : json[KEY_POST_HOSTUNI] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      KEY_POST_POSTKEY: postKey,
      KEY_POST_HOST: host,
      KEY_POST_PLACE: place,
      KEY_POST_HEADCOUNT: headCount,
      KEY_POST_TITLE: title,
      KEY_POST_CREATEDDATE: createdDate,
      KEY_POST_CONTENT: content,
      KEY_POST_NUMCOMMENTS: numComments,
      KEY_POST_HOSTPUSHTOKEN: hostpushToken,
      KEY_POST_HOSTNICK : hostNick,
      KEY_POST_HOSTGRADE : hostGrade,
      KEY_POST_HOSTUNI : hostUni,
    };
  }

  PostModel copyWith({
    String? postKey,
    String? host,
    String? place,
    int? headCount,
    String? title,
    DateTime? createdDate,
    int? numComments,
    String? content,
    String? hostpushToken,
    String? hostNick,
    String? hostUni,
    String? hostGrade
  }) {
    return PostModel(
        postKey: postKey ?? this.postKey,
        host: host ?? this.host,
        place: place ?? this.place,
        headCount: headCount ?? this.headCount,
        title: title ?? this.title,
        createdDate: createdDate ?? this.createdDate,
        numComments: numComments ?? this.numComments,
        content: content ?? this.content,
        hostpushToken: hostpushToken ?? this.hostpushToken,
      hostNick: hostNick ?? this.hostNick,
      hostGrade: hostGrade ?? this.hostGrade,
      hostUni:  hostUni ?? this.hostUni,
    );
  }
}
