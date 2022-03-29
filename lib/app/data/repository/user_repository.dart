import 'package:uni_meet/app/data/model/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  static Future<AppUser?> loginUserByUdi(String uid) async {
    var data = await FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: uid).get();

    if(data.size==0){
      return null;
    }else {
      return AppUser.fromJson(data.docs.first.data());
    }
  }

  static Future<bool> signup(AppUser user)async {
    try{
      await FirebaseFirestore.instance.collection('users').add(user.toMap());
      return true;
    }catch(e) {
      return false;
    }
  }
}