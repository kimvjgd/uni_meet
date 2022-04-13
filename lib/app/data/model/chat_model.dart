import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_meet/app/data/model/firestore_keys.dart';

class ChatModel {
  String? writer;
  String? message;
  DateTime? createdDate;
  DocumentReference? reference;

  ChatModel(
      {required this.writer,
      required this.message,
      required this.createdDate,
      this.reference,
      });

  factory ChatModel.fromJson(
      Map<String, dynamic> json, DocumentReference reference) {
    return ChatModel(
      writer:
          json[KEY_CHAT_WRITER] == null ? '' : json[KEY_CHAT_WRITER] as String,
      message: json[KEY_CHAT_MESSAGE] == null
          ? ''
          : json[KEY_CHAT_MESSAGE] as String,
      createdDate: json[KEY_CHAT_CREATEDDATE] == null
          ? DateTime.now()
          : json[KEY_CHAT_CREATEDDATE].toDate(),
      reference: reference,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      KEY_CHAT_WRITER: writer,
      KEY_CHAT_MESSAGE: message,
      KEY_CHAT_CREATEDDATE: createdDate,
    };
  }
}
