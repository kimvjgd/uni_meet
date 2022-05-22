import 'package:extended_image/extended_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/controller/chat_controller.dart';
import 'package:uni_meet/app/data/repository/user_repository.dart';
import 'package:uni_meet/app/ui/components/app_color.dart';

import '../message_popup.dart';

class ProfileWidget extends StatelessWidget {
  String university;
  String grade;
  String nickname;
  String localImage;
  String mbti;
  String gender;


  ProfileWidget(
      {required this.university,
      required this.grade,
      required this.nickname,
      required this.localImage,
      required this.mbti,
        required this.gender,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> momo_name = [
      "",
      "적극적인 모모",
      "쩝쩝박사 모모",
      "알콜저장소 모모",
      "알쓰 모모",
      "부끄러운 모모",
    ];

    return SizedBox(
      height: Get.height / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/momo${localImage}.png')),
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Column(
                children: [
                  Text(
                    momo_name[int.parse(localImage)],
                    style: TextStyle(color: app_systemGrey1, fontSize: 13),
                  ),
                  Text(""),
                  Text(university + ' ' + grade),
                  Text(mbti +' / '+gender),
                  Text(nickname),
                ],
              )),
          Expanded(
              flex: 1,
              child: nickname == AuthController.to.user.value.nickname
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [Spacer(), SizedBox()])
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return MessagePopup(
                                    title: "신고하기",
                                    message:
                                        "사용자를 신고하시겠습니까? 신고 후 2~3일 내로 운영진의 적절한 조치가 이루어질 예정입니다.",
                                    okCallback: () async {
                                      await FirebaseStorage.instance
                                          .ref('report/user/' + nickname)
                                          .putString(DateTime.now().toString());
                                      //일단.. 귀찮으니..
                                      Get.back();
                                      Get.back();
                                      Get.snackbar("알림", "신고처리가 완료되었습니다.");
                                    },
                                    cancelCallback: () {
                                      Get.back();
                                    },
                                  );
                                });
                          },
                          child: Text('신고'),
                        ),
                        AuthController.to.user.value.blackList!.contains(nickname)
                        ? TextButton(
                          onPressed: () async {

                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return MessagePopup(
                                    title: "차단 해제하기",
                                    message: "차단한 사용자를 차단 해제하시겠습니까?",
                                    okCallback: () async {
                                      await UserRepository.removeBlackUser(
                                          nickname);
                                      AuthController.to.removeblackList(nickname);
                                      Get.back();
                                      Get.back();
                                      Get.snackbar("알림", "차단 해제가 완료되었습니다.");
                                    },
                                    cancelCallback: () {
                                      Get.back();
                                    },
                                  );
                                });
                          },
                          child:Text('차단 해제'),
                        )
                        : TextButton(
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return MessagePopup(
                                    title: "차단하기",
                                    message: "정말 사용자를 차단하시겠습니까?",
                                    okCallback: () async {
                                      await UserRepository.addBlackUser(
                                          nickname);
                                      AuthController.to.addblackList(nickname);
                                      Get.back();
                                      Get.back();
                                      Get.snackbar("알림", "차단이 완료되었습니다.");
                                    },
                                    cancelCallback: () {
                                      Get.back();
                                    },
                                  );
                                });
                          },
                          child:Text('차단'),
                        )
                      ],
                    ))
        ],
      ),
    );
  }
}
