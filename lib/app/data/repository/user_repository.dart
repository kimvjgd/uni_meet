import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/data/model/app_user_model.dart';
import 'package:uni_meet/app/data/model/firestore_keys.dart';

class UserRepository {
  static Future<AppUserModel?> loginUserByUid(String uid) async {
    var data = await FirebaseFirestore.instance
        .collection(COLLECTION_USERS)
        .where(KEY_USER_UID, isEqualTo: uid)
        .get();

    if (data.size == 0) {
      return null;
    } else {
      return AppUserModel.fromJson(data.docs.first.data());
    }
  }

  static Future<bool> signup(AppUserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection(COLLECTION_USERS)
          .doc(user.uid)
          .set(user.toMap());
      print("정보 저장 성공");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<void> withdrawal(String uid) async {
    try {
      await FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(uid).collection(COLLECTION_NEWSLIST)
          .get()
          .then((snapshot){
            for (DocumentSnapshot i in snapshot.docs)
              i.reference.delete();
          }
          );
      await FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(uid).delete();
      await FirebaseAuth.instance.currentUser!.delete();
    } catch(e){
      Logger().d(e);
    }
  }

  static Future<void> addBlackUser(String blackNickname) async {
    var prev_data = await FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(AuthController.to.user.value.uid).get();

    List<dynamic> data = await prev_data.get(KEY_USER_BLACKLIST)??[];

    Set<dynamic> semiResult = data.toSet();
    semiResult.add(blackNickname);
    List<dynamic> result = semiResult.toList();
    await FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(AuthController.to.user.value.uid).update({KEY_USER_BLACKLIST: result});
  }
}
