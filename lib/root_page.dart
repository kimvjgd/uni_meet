import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/binding/init_bindings.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/data/model/app_user_model.dart';
import 'package:uni_meet/app/ui/page/account/edit_number.dart';
import 'package:uni_meet/app/ui/start.dart';
import 'app/ui/page/account/edit_info.dart';
import 'app/ui/page/screen_index/index_screen.dart';

class RootPage extends GetView<AuthController> {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> user) {    // FirebaseAuth_uid
          if (user.hasData) { // authentication 계정 있음
            // nickname & localimage == null => profile_image_screen
            // university == null =>
            // 학교인증 == null ?
            // splash screen
            // loading


            // 별개
            // firestore 삭제.... foreignkey같이 연동
            //  1. 채팅방 나갈때 chatRoomModel.all_user 에서 지워주고, userColleciton에서 나간사람 chatroomList 지워주기
            //  2. auth 탈퇴 => 채팅신청 => 탈퇴한 회원입니다. & 기존의 채팅방에 들어가있으면 나가지는 걸로...
            //  3.
            // 채팅방 나가기  => all_user length <=1 방폭
            // 채팅방 중간에 들어오면 그 전의 메세지 내용들을 볼 수 있냐 없냐? 없으면 작업 ㄲ
            // 삭제된 글입니다. <= postdetailscreen에서 삼항연산자

            //
            return FutureBuilder<AppUserModel?>(
                future: controller.loginUser(user.data!.uid),
                builder: (context, snapshot) {                // auth_uid와 같은 uid가 user collection안에 있으면 그 IUser, 없으면 snapshot==null
                  if (snapshot.hasData) {
                    // InitBinding.additionalBinding();
                    return const IndexScreen();
                  } else {      // snapshot.has No!!!Data
                    return Obx(() => controller.user.value.uid == null
                        ? EditInfo(uid: user.data!.uid)     // 살짝 loading을 줄까...?
                       // ? EditNumber(isLogOut: true) //로그인 페이지
                    : index());
                       // :EditNumber());
                  }
                });
          } else if(user.hasError) {
            return Container(child: Text(user.error.toString()),);
          }
          else {
            return StartScreen(); //가입 페이지
          }
        });
  }

  Widget index() {
    InitBinding.additionalBinding();
    return IndexScreen();
  }
}
