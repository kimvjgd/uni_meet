import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/data/model/firestore_keys.dart';
import 'package:uni_meet/app/data/model/post_model.dart';

class PostRepository {

  static Future<void> createPost({required String title,
    required String content,
    required String place,
    required int headCount,
    required DateTime createdDate,
    required String host,
    required String hostpushToken,
    required String hostGrade,
    required String hostNick,
    required String hostUni,
  }) async {
    DocumentReference postRef = FirebaseFirestore.instance.collection(
        COLLECTION_POSTS).doc();
    PostModel postData = PostModel(
        title: title,
        postKey: postRef.id,
        content: content,
        place: place,
        headCount: headCount,
        createdDate: createdDate,
        host: host,
        hostGrade: hostGrade,
        hostNick: hostNick,
        hostUni: hostUni,
        hostpushToken: hostpushToken,
        numComments: 0);
    await postRef
        .set(postData.toMap());
  }

  static Future<List<PostModel>> loadPostList() async {
    var document = FirebaseFirestore.instance
        .collection(COLLECTION_POSTS)
        .orderBy(KEY_POST_CREATEDDATE, descending: true).limit(10); // 나중에 더 추가
    var data = await document.get();
    return data.docs.map<PostModel>((e) => PostModel.fromJson(e.data()))
        .toList();
  }

  static Future<void> deletePost(String PostKey) async {
    CollectionReference post = FirebaseFirestore.instance.collection(
        COLLECTION_POSTS);
    return post
        .doc(PostKey)
        .delete()
        .then((value) => print("포스트 삭제 완료"))
        .catchError((error) => print("포스트 삭제 실패: $error"));
  }

  Future<List<PostModel>> getTwoPosts() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance.collection(COLLECTION_POSTS).where(KEY_POST_HOST, isEqualTo: AuthController.to.user.value.uid).limit(2).get();

    List<PostModel> posts = [];
    snapshot.docs.forEach((e) {
      PostModel post = PostModel.fromJson(e.data());
          posts.add(post);
    });
    return posts;
  }
  Future<List<PostModel>> getAllPosts() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance.collection(COLLECTION_POSTS).where(KEY_POST_HOST, isEqualTo: AuthController.to.user.value.uid).get();

    List<PostModel> posts = [];
    snapshot.docs.forEach((e) {
      PostModel post = PostModel.fromJson(e.data());
      posts.add(post);
    });
    return posts;
  }

  Future<PostModel> getAPost(String postKey) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(COLLECTION_POSTS)
        .where(KEY_POST_POSTKEY, isEqualTo: postKey).limit(1).get();
    late PostModel post;
    snapshot.docs.forEach((e) {
      post = PostModel.fromJson(e.data());
    });

    return post;
  }
//
//   QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
//       .instance
//       .collection(COLLECTION_NOTICES)
//       .limit(3)
//       .get();
//   List<NoticeModel> notices = [];
//   snapshot.docs.forEach((e) {
//     NoticeModel notice = NoticeModel.fromJson(e.data());
//     notices.add(notice);
//   });
//   return notices;
// }


}