import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/data/model/comment_model.dart';
import 'package:uni_meet/app/data/model/firestore_keys.dart';

class CommentRepository {
  Future<void> createNewComment(
      String postKey, Map<String, dynamic> commentData) async {
    final DocumentReference postRef =
        FirebaseFirestore.instance.collection(COLLECTION_POSTS).doc(postKey);
    final DocumentReference commentRef =
        postRef.collection(COLLECTION_COMMENTS).doc();

    commentData[KEY_COMMENT_COMMENTKEY] = commentRef;

    return FirebaseFirestore.instance.runTransaction((tx) async {
      tx.set(commentRef, commentData);
      // int numOfComments = postSnapshot.get(KEY_POST_NUMCOMMENTS);
      // 나중에 자신의 commentlist를 보려면 여기서 transaction 처리를 해줘야한다.
    });
  }

  Future<List<CommentModel>> loadCommentList(String postKey) async {
    var document = FirebaseFirestore.instance
        .collection(COLLECTION_POSTS)
        .doc(postKey)
        .collection(COLLECTION_COMMENTS)
        .orderBy(KEY_COMMENT_COMMENTTIME, descending: false);
    var data = await document.get();
    List<CommentModel> comments = [];
    for (int i = 0; i < data.size; i++) {
      CommentModel comment = CommentModel(
        hostKey: data.docs[i].data()[KEY_COMMENT_HOSTKEY],
        hostInfo: data.docs[i].data()[KEY_COMMENT_HOSTINFO],
        hostPushToken: data.docs[i].data()[KEY_COMMENT_HOSTPUSHTOKEN],
        commentKey: data.docs[i].data()[KEY_COMMENT_COMMENTKEY],
        content: data.docs[i].data()[KEY_COMMENT_CONTENT],
        commentTime: data.docs[i].data()[KEY_COMMENT_COMMENTTIME].toDate(),
      );
      if (!AuthController.to.user.value.blackList!.contains(comment.hostKey)) {
        comments.add(comment);
      }
    }
    return comments;
  }

  Future<void> deleteComment(String postKey, DocumentReference UID) async {
    return (UID)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<bool> checkCommentPossible(String commentUid) async {
    var test2 = await FirebaseFirestore.instance
        .collection(COLLECTION_USERS)
        .doc(commentUid)
        .get();
    return test2.exists;
  }
}

CommentRepository commentRepository = CommentRepository();
