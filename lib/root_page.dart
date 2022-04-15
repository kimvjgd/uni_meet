import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/binding/init_bindings.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/data/model/app_user_model.dart';
import 'package:uni_meet/app/ui/page/account/edit_number.dart';
import 'app/ui/page/account/edit_info.dart';
import 'app/ui/page/screen_index/index_screen.dart';

class RootPage extends GetView<AuthController> {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> user) {    // FirebaseAuth_uid
          if (user.hasData) {
            return FutureBuilder<AppUserModel?>(
                future: controller.loginUser(user.data!.uid),
                builder: (context, snapshot) {                // auth_uid와 같은 uid가 user collection안에 있으면 그 IUser, 없으면 snapshot==null
                  if (snapshot.hasData) {
                    InitBinding.additionalBinding();
                    return const IndexScreen();
                  } else {
                    return Obx(() => controller.user.value.uid != null
                        ? index()
                        : EditInfo(uid: user.data!.uid));
                  }
                });
          } else {
            return EditNumber();
          }
        });
  }

  Widget index() {
    InitBinding.additionalBinding();
    return IndexScreen();
  }
}
