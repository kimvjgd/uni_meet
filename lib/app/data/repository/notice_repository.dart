import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:uni_meet/app/data/model/firestore_keys.dart';
import 'package:uni_meet/app/data/model/notice_model.dart';

class NoticeRepository {
  static final NoticeRepository _noticeRepository =
      NoticeRepository._internal();

  factory NoticeRepository() => _noticeRepository;

  NoticeRepository._internal();

  static Future<List<NoticeModel>> loadPostList() async {
    var document = FirebaseFirestore.instance
        .collection(COLLECTION_NOTICES)
        .orderBy(KEY_NOTICE_DATE, descending: true); // 나중에 더 추가
    var data = await document.get();
    return data.docs
        .map<NoticeModel>((e) => NoticeModel.fromJson(e.data()))
        .toList();
  }

  Future<List<NoticeModel>> getThreeNotices() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(COLLECTION_NOTICES);

    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(COLLECTION_NOTICES)
        .limit(3)
        .get();
    List<NoticeModel> notices = [];
    snapshot.docs.forEach((e) {
      NoticeModel notice = NoticeModel.fromJson(e.data());
      notices.add(notice);
    });
    return notices;
  }
  Future<List<NoticeModel>> getAllNotices() async {

    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(COLLECTION_NOTICES)
        .get();
    List<NoticeModel> notices = [];
    snapshot.docs.forEach((e) {
      NoticeModel notice = NoticeModel.fromJson(e.data());
      notices.add(notice);
    });
    return notices;
  }
}
