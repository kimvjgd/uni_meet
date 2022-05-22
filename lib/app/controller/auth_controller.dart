import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uni_meet/app/binding/init_bindings.dart';
import 'package:uni_meet/app/data/model/app_user_model.dart';
import 'package:uni_meet/app/data/repository/user_repository.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  Rx<AppUserModel> user = AppUserModel().obs;
  RxString name = ''.obs;

  void signOut() {
    user.value = AppUserModel();
  }

  Future<AppUserModel?> loginUser(String uid) async {
    var userData = await UserRepository.loginUserByUid(uid);
    if(userData != null){
      user(userData);
      InitBinding.additionalBinding();
    }
    return userData;
  }

  void setGradeNameUniv(int grade, String name, String university){
    user.value.grade = grade;
    user.value.name = name;
    user.value.university = university;
  }

  void changeAge(value) {
    user(AppUserModel(grade: value));
    // user.value.age = value;
  }

  void addblackList(String nick) {
    user.value.blackList!.add(nick);
  }
  void removeblackList(String nick) {
    user.value.blackList!.remove(nick);
  }

  void signup(AppUserModel User) async {
    _submitSignup(User);
  }

  void pickImage(value){
    user(AppUserModel(localImage: value));
  }
  void nickName(value){
    user(AppUserModel(nickname: value));
  }
  // void signup(AppUserModel signupUser, XFile? thumbnail) async {
  //   if(thumbnail==null){
  //     _submitSignup(signupUser);
  //   }else {
  //     var task = uploadXFile(thumbnail, '${signupUser.uid}/profile.${thumbnail.path.split('.').last}');
  //     task.snapshotEvents.listen((event) async {
  //       if(event.bytesTransferred == event.totalBytes && event.state == TaskState.success){
  //         var downloadUrl = await event.ref.getDownloadURL();     // 이미지의 도메인을 받아올 수 있다.
  //         var updatedUserData = signupUser.copyWith(imagePath: downloadUrl);
  //         _submitSignup(updatedUserData);
  //       }
  //     });
  //   }
  // }

  UploadTask uploadXFile(XFile file, String filename){
    var f = File(file.path);
    var ref = FirebaseStorage.instance.ref().child('users').child(filename);
    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path}
    );

    return ref.putFile(f,metadata);
  }

  void _submitSignup(AppUserModel signupUser)async {
    var result = await UserRepository.signup(signupUser);
    if(result){
      loginUser(signupUser.uid!);
    }
  }


}