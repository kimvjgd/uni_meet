import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_meet/app/data/model/app_user_model.dart';
import 'package:uni_meet/app/data/model/post_model.dart';
import 'package:uni_meet/app/data/model/firestore_keys.dart';
import 'package:get/get.dart';
import '../../controller/auth_controller.dart';
import '../../controller/notification_controller.dart';
import '../model/comment_model.dart';
import '../model/news_model.dart';

class NewsRepository{
  Future<void> createCommentNews(PostModel post) async {
    final CollectionReference newsRef = FirebaseFirestore
        .instance
        .collection(COLLECTION_USERS)
        .doc(post.host)
        .collection(COLLECTION_NEWSLIST);

    var newsData = {
      KEY_NEWS_NEWS : post.title.toString() + "에 새 댓글이 달렸습니다.",
      KEY_NEWS_ADDRESS : post.postKey,
      KEY_NEWS_TYPE :1,
      KEY_NEWS_CREATEDDATE:DateTime.now()
    };
    await newsRef.add(newsData);
    print("포스트 새 댓글 소식 저장");


  }

  Future<void> createChatOpenNews(String post_title,String receiverUID,String address) async {
    final CollectionReference newsRef = FirebaseFirestore
        .instance
        .collection(COLLECTION_USERS)
        .doc(receiverUID)
        .collection(COLLECTION_NEWSLIST);

    var newsData = {
      KEY_NEWS_NEWS : post_title+ "에 새로운 채팅이 개설되었습니다.",
      KEY_NEWS_ADDRESS : address,
      KEY_NEWS_TYPE : 2,
      KEY_NEWS_CREATEDDATE:DateTime.now()
    };
    await newsRef.add(newsData);
    print("새 채팅소식 저장");

  }

  Future<List<NewsModel>> getAllNews() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance.collection(COLLECTION_USERS).doc(AuthController.to.user.value.uid).collection(COLLECTION_NEWSLIST).get();

    List<NewsModel> news = [];
    snapshot.docs.forEach((e) {
      NewsModel element= NewsModel.fromJson(e.data());
      news.add(element);
    });
    return news;
  }

  static Future<void> deleteALLNEWS() async {
    CollectionReference newsList = FirebaseFirestore.instance.collection(
        COLLECTION_USERS).doc(AuthController.to.user.value.uid).collection(COLLECTION_NEWSLIST);
    var snapshots = await newsList.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete()
          .then((value) => print("새소식 삭제 완료"))
          .catchError((error) => print("새소식 삭제 실패: $error"));;
    }

  }

}