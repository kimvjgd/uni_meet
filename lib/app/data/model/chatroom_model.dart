import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_meet/app/data/model/firestore_keys.dart';

class ChatroomModel {
  List<dynamic>? allUser;
  DateTime? createDate;
  String? chatId;
  String? postKey;
  String? postTitle;
  String? lastMessage;
  DateTime? lastMessageTime;
  int? headCount;
  DocumentReference? reference;

  ChatroomModel({
    required this.allUser,
    required this.createDate,
    required this.chatId,
    required this.postKey,
    required this.postTitle,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.headCount,
    this.reference,
  });

  factory ChatroomModel.fromJson(Map<String, dynamic> json) {
    return ChatroomModel(
      allUser: json[KEY_CHATROOM_ALLUSER].cast<String>() == null
          ? [].cast<String>()
          : json[KEY_CHATROOM_ALLUSER] as List<dynamic>,
      createDate: json[KEY_CHATROOM_CREATEDDATE] == null
          ? DateTime.now()
          : json[KEY_CHATROOM_CREATEDDATE].toDate(),
      chatId: json[KEY_CHATROOM_CHATROOMID] == null
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
    );
  }

  Map<String, dynamic> toMap() {
    return {
      KEY_CHATROOM_ALLUSER: allUser,
      KEY_CHATROOM_CREATEDDATE: createDate,
      KEY_CHATROOM_CHATROOMID: chatId,
      KEY_CHATROOM_POSTKEY: postKey,
      KEY_CHATROOM_POSTTITLE: postTitle,
      KEY_CHATROOM_LASTMESSAGE: lastMessage,
      KEY_CHATROOM_LASTMESSAGETIME: lastMessageTime,
      KEY_CHATROOM_HEADCOUNT: headCount,
    };
  }
}
