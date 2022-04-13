import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_meet/app/data/model/firestore_keys.dart';

class CommentModel {
  String? host;
  String? content;
  DateTime? commentTime;
  // DocumentReference? reference;

  CommentModel({
    this.host,
    this.content,
    this.commentTime,
    // this.reference,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
        host:json[KEY_COMMENT_HOST] == null ? '' : json[KEY_COMMENT_HOST] as String,
        content:json[KEY_COMMENT_CONTENT] == null ? '' : json[KEY_COMMENT_CONTENT] as String,
        commentTime:json[KEY_COMMENT_COMMENTTIME] == null ? DateTime.now() : json[KEY_COMMENT_COMMENTTIME].toDate(),
    );
  }

  // Comment.fromSnapshot(DocumentSnapshot snapshot)
  CommentModel.fromMap(Map<String, dynamic>? map)
    : host = map?[KEY_COMMENT_HOST],
      content = map?[KEY_COMMENT_CONTENT],
      commentTime = map?[KEY_COMMENT_COMMENTTIME].toUtc();

  CommentModel.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data() as Map<String, dynamic>?);

  Map<String, dynamic> toMap() {
    return {
      KEY_COMMENT_HOST: host,
      KEY_COMMENT_CONTENT: content,
      KEY_COMMENT_COMMENTTIME: commentTime,
    };
  }

}
