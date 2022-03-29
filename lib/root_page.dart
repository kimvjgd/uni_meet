import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/data/model/app_user.dart';
import 'package:uni_meet/app/ui/page/post/post_screen.dart';
import 'package:uni_meet/app/ui/page/signup/screen/auth_info_screen.dart';
import 'package:uni_meet/app/ui/page/signup/screen/start_screen.dart';

class RootPage extends GetView<AuthController> {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> user) {    // FirebaseAuth_uid
          if (user.hasData) {
            return FutureBuilder<AppUser?>(
                future: controller.loginUser(user.data!.uid),
                builder: (context, snapshot) {                // auth_uid와 같은 uid가 user collection안에 있으면 그 IUser, 없으면 snapshot==null
                  if (snapshot.hasData) {
                    return PostScreen();
                  } else {
                    return Obx(() => controller.user.value.uid != null
                        ? const PostScreen()
                        // : SignupPage(uid: user.data!.uid));
                        : AuthInfoScreen(uid: user.data!.uid));
                  }
                });
          } else {
            return StartScreen();
          }
        });
  }
}
