import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uni_meet/app/data/model/app_user.dart';
import 'package:uni_meet/app/data/repository/user_repository.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  Rx<AppUser> user = AppUser().obs;

  Future<AppUser?> loginUser(String uid) async {
    var userData = await UserRepository.loginUserByUdi(uid);
    if(userData != null){
      user(userData);
      // TODO add other binding here
    }
    return userData;
  }

  void changeAge(value) {
    user(AppUser(age: value));
    // user.value.age = value;
  }

  void toggleGender() {

  }

  void signup(AppUser signupUser, XFile? thumbnail) async {
    if(thumbnail==null){
      _submitSignup(signupUser);
    }else {

      var task = uploadXFile(thumbnail, '${signupUser.uid}/profile.${thumbnail.path.split('.').last}');
      task.snapshotEvents.listen((event) async {
        if(event.bytesTransferred == event.totalBytes && event.state == TaskState.success){
          var downloadUrl = await event.ref.getDownloadURL();     // 이미지의 도메인을 받아올 수 있다.
          var updatedUserData = signupUser.copyWith(imagePath: downloadUrl);
          _submitSignup(updatedUserData);
        }
      });
    }

  }
  UploadTask uploadXFile(XFile file, String filename){
    var f = File(file.path);
    var ref = FirebaseStorage.instance.ref().child('users').child(filename);
    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path}
    );

    return ref.putFile(f,metadata);
  }

  void _submitSignup(AppUser signupUser)async {
    var result = await UserRepository.signup(signupUser);
    if(result){
      loginUser(signupUser.uid!);
    }
  }

}