import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_meet/app/data/model/firestore_keys.dart';
import 'package:uni_meet/app/data/model/notice_model.dart';

class NoticeRepository {
  static final NoticeRepository _noticeRepository = NoticeRepository._internal();
  factory NoticeRepository() => _noticeRepository;

  NoticeRepository._internal();

  static Future<List<NoticeModel>> loadPostList() async {
    var document = FirebaseFirestore.instance
        .collection(COLLECTION_NOTICES)
        .orderBy(KEY_NOTICE_DATE, descending: true);       // 나중에 더 추가
    var data = await document.get();
    return data.docs.map<NoticeModel>((e) => NoticeModel.fromJson(e.data())).toList();
  }

}