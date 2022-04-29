import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_meet/app/data/model/firestore_keys.dart';

class ChatroomModel {
  List<dynamic>? allUser;
  List<dynamic>? allToken;
  DateTime? createDate;
  String? chatroomId;
  String? postKey;
  String? postTitle;
  String? lastMessage;
  DateTime? lastMessageTime;
  int? headCount;
  DocumentReference? reference;
  String? place;

  ChatroomModel({
    required this.allUser,
    required this.allToken,
    required this.createDate,
    required this.chatroomId,
    required this.postKey,
    required this.postTitle,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.headCount,
    this.reference,
    required this.place,
  });

  factory ChatroomModel.fromJson(Map<String, dynamic> json) {
    return ChatroomModel(
      allUser: json[KEY_CHATROOM_ALLUSER].cast<String>() == null
          ? [].cast<String>()
          : json[KEY_CHATROOM_ALLUSER] as List<dynamic>,
      allToken: json[KEY_CHATROOM_ALLTOKEN]== null
          ?  []
          : json[KEY_CHATROOM_ALLTOKEN] as List,
      createDate: json[KEY_CHATROOM_CREATEDDATE] == null
          ? DateTime.now()
          : json[KEY_CHATROOM_CREATEDDATE].toDate(),
      chatroomId: json[KEY_CHATROOM_CHATROOMID] == null
          ? ''
          : json[KEY_CHATROOM_CHATROOMID] as String,
      postKey: json[KEY_CHATROOM_POSTKEY] == null
          ? ''
          : json[KEY_CHATROOM_POSTKEY] as String,
      postTitle: json[KEY_CHATROOM_POSTTITLE] == null
          ? ''
          : json[KEY_CHATROOM_POSTTITLE] as String,
      lastMessage: json[KEY_CHATROOM_LASTMESSAGE] == null
          ? ''
          : json[KEY_CHATROOM_LASTMESSAGE] as String,
      lastMessageTime: json[KEY_CHATROOM_LASTMESSAGETIME] == null ? DateTime.now() : json[KEY_CHATROOM_LASTMESSAGETIME].toDate(),
      headCount: json[KEY_CHATROOM_HEADCOUNT] == null
          ? 2
          : json[KEY_CHATROOM_HEADCOUNT] as int,
      place: json[KEY_CHATROOM_PLACE] == null? '' : json[KEY_CHATROOM_PLACE] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      KEY_CHATROOM_ALLUSER: allUser,
      KEY_CHATROOM_ALLTOKEN:allToken,
      KEY_CHATROOM_CREATEDDATE: createDate,
      KEY_CHATROOM_CHATROOMID: chatroomId,
      KEY_CHATROOM_POSTKEY: postKey,
      KEY_CHATROOM_POSTTITLE: postTitle,
      KEY_CHATROOM_LASTMESSAGE: lastMessage,
      KEY_CHATROOM_LASTMESSAGETIME: lastMessageTime,
      KEY_CHATROOM_HEADCOUNT: headCount,
      KEY_CHATROOM_PLACE : place,
    };
  }
}
