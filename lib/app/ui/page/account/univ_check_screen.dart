import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:logger/logger.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/data/model/firestore_keys.dart';
import 'package:uni_meet/app/ui/components/app_color.dart';
import 'package:uni_meet/app/ui/error_screen.dart';
import 'package:uni_meet/app/ui/page/account/widget/big_button.dart';
import 'package:uni_meet/app/ui/page/account/widget/big_text.dart';
import 'package:uni_meet/app/ui/page/screen_index/home/screen/home_screen.dart';
import '../../../../root_page.dart';
import '../../../../secret/secret_keys.dart';
import '../../../controller/notification_controller.dart';
import '../screen_index/index_screen.dart';

class UnivCheckScreen extends StatefulWidget {
  const UnivCheckScreen({Key? key}) : super(key: key);

  @override
  _UnivCheckScreenState createState() => _UnivCheckScreenState();
}

class _UnivCheckScreenState extends State<UnivCheckScreen> {
  DocumentReference users = FirebaseFirestore.instance
      .collection(COLLECTION_USERS)
      .doc(AuthController.to.user.value.uid);

  File? imageFile;
  String parsedtext = '';
  String _name = '';
  String _uni = '';
  String _grade = "";
  String _everytime = "학교 인증";
  bool flag1 = false, flag2 = false, flag3 = false;
  late bool uni_check;
  bool _isLoading = false;

  Future _getFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    final image_temporary = File(pickedFile.path);

    setState(() {
      imageFile = image_temporary;
      //_Recognition(imageFile);
    });
  }

  Future<bool> _Recognition(pickedFile) async {
    var bytes = File(pickedFile.path.toString()).readAsBytesSync();
    String img64 = base64Encode(bytes);

    var url = 'https://api.ocr.space/parse/image';
    var payload = {
      "base64Image": "data:image/jpg;base64,${img64.toString()}",
      "language": "kor"
    };
    var header = {"apikey": auth_image_key};

    try {
      var post =
          await http.post(Uri.parse(url), body: payload, headers: header);
      var result = jsonDecode(post.body);
      print("http 전송완료");

      parsedtext = result['ParsedResults'][0]['ParsedText'];
      Logger().d(parsedtext);

      flag1 = parsedtext.contains(_name);
      flag2 = parsedtext.contains(_uni);
      flag3 = parsedtext.contains(_everytime);
      if (flag1) print("이름인증 ㅇㅋ");
      if (flag2) print("학교인증 ㅇㅋ");
      if (flag3) print("에타인증 ㅇㅋ");
      if (flag1 && flag2 && flag3) {

        FirebaseFirestore.instance
            .collection(COLLECTION_USERS)
            .doc(FirebaseAuth.instance.currentUser?.uid.toString())
            .update({KEY_USER_AUTH: true})
            .then((value) => print("대학인증 성공"))
            .catchError((error) => print("대학 인증 실패: $error"));
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      Logger().d('에러가 나');
      return false;
    }
  }

  Future<void> uploadFB(File file) async {
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('uploads/everytime/' +
              FirebaseAuth.instance.currentUser!.uid.toString() +
              '.png')
          .putFile(file);
      print("업로드성공");
    } on FirebaseException catch (e) {
      print("업로드실패");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    _name = AuthController.to.user.value.name!;
    _uni = AuthController.to.user.value.university!;
    _grade = AuthController.to.user.value.grade.toString() + "학번";
    return Scaffold(
      body: body(),
    );
    // return _builder();

  }

  // FutureBuilder<DocumentSnapshot> _builder() {
  //   return FutureBuilder<DocumentSnapshot>(
  //     future: FirebaseFirestore.instance
  //         .collection(COLLECTION_USERS)
  //         .doc(AuthController.to.user.value.uid)
  //         .get(),
  //     builder:
  //         (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
  //       if (snapshot.hasError) {
  //         return ErrorScreen();
  //       } else if (snapshot.connectionState == ConnectionState.none ||
  //           snapshot.connectionState == ConnectionState.waiting) {
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       } else if (snapshot.hasData) {
  //         if (snapshot.connectionState == ConnectionState.done) {
  //           Map<String, dynamic> data =
  //               snapshot.data!.data() as Map<String, dynamic>;
  //           _name = data[KEY_USER_NAME];
  //           _uni = data[KEY_USER_UNIVERSITY];
  //           _grade = data[KEY_USER_GRADE].toString() + "학번";
  //           return Scaffold(
  //             body: body(),
  //           );
  //         } else {
  //           return Container(child: Text("연결 오류 발생 "));
  //         }
  //       } else
  //         return Container();
  //     },
  //   );
  // }

// 인증 후 바로 홈으로 일단 보내기,,,,
  SafeArea body() {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BackButton(),
          //  Text("임시 텍스트 " + _uni + _grade + _name),
          BigText(headText: "먼저, 학교 인증을 해야 해요!"),
          Spacer(
            flex: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "에브리타임 앱 > 내 정보 에 들어가서\n이름, 대학명, 학번이 보이게 스크린샷을 찍어주세요\n크롭 된 파일이 아닌, 전체 스크린 샷을 업로드 해주세요",
              style: TextStyle(color: app_label_grey),
            ),
          ),
          Spacer(
            flex: 1,
          ),
          ////////////////////////////////////////////////////////////////////////////////
          Stack(
            children: [
              Container(
                  height: MediaQuery.of(context).size.width * 0.85,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.grey),
                  child: Center(
                    child: imageFile == null
                        ? Image.asset("assets/images/uniexample.png")
                        : Image.file(imageFile!),
                  )),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(10),
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (imageFile == null) {
                              return app_red;
                            } else {
                              return Colors.white;
                            }
                          })),
                      onPressed: () async {
                        await _getFromGallery();
                      },
                      child: imageFile == null
                          ? Text(
                              "사진 업로드",
                              style: TextStyle(color: Colors.white),
                            )
                          : Text(
                              "사진 다시 고르기",
                              style: TextStyle(
                                  color: app_red, fontWeight: FontWeight.bold),
                            )),
                ),
              ),
            ],
          ),
          Spacer(
            flex: 2,
          ),
          Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.06,
                child: BigButton(
                    onPressed: () async {
                      if (imageFile == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text(
                            "이미지를 업로드 해 주세요 !",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.blue,
                        ));
                      } else {
                        // if(uni_check==null){
                        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //     content: const Text(
                        //       "인식이 진행중입니다.",
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //     backgroundColor: Colors.black,
                        //   ));
                        // }
                        // else if (uni_check==true) {
                        //

                        // }
                        // else {
                        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //     content: const Text(
                        //       "인증에 실패하였습니다. 다시 시도해 주세요.",
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //     backgroundColor: Colors.black,
                        //   ));
                        // }
                        setState(() {
                          _isLoading = true;
                        });

                        if (await _Recognition(imageFile)) {
                          await Get.put(NotificationController())
                              .SendSuccessUniCheck(
                                  receiver_token: AuthController
                                      .to.user.value.token
                                      .toString());
                          // users.update({KEY_USER_AUTH: true})
                          //        .then((value) => print("대학인증 성공"))
                          //        .catchError((error) => print("대학 인증 실패: $error"));
                          Logger().d('일단 동현님께서 킵');

                        } else {
                          Logger().d('여기로 가버렸어??');

                          await Get.put(NotificationController())
                              .SendFailUniCheck(
                                  receiver_token: AuthController
                                      .to.user.value.token
                                      .toString());

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text(
                              "인증에 실패하였습니다. 다시 시도해 주세요.",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.black,
                          ));
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      }
                    },
                    btnText: _isLoading ? "인증중입니다 . . ." : "인증하기")),
          ),
          Spacer(
            flex: 1,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    " 2~3분 이내에 학교인증이 완료됩니다.",
                    style: TextStyle(color: app_systemGrey2),
                  ),
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext child_context) {
                              return AlertDialog(
                                content: Text(
                                    "에브리타임 캡쳐 스크린을 선택 후, 전송하기를 눌러주세요.\n 24시간 이내로 확인 도와드릴게요!"),
                                actions: [
                                  Center(
                                    child: Column(
                                      children: [
                                        ElevatedButton(
                                            onPressed: () async {
                                              await _getFromGallery();
                                            },
                                            child: Text("파일 찾아보기")),
                                        ElevatedButton(
                                            onPressed: () {
                                              uploadFB(imageFile!);
                                            },
                                            child: Text("전송하기")),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            });
                      },
                      child: Text(
                        "인증에 실패하셨나요?",
                        style: TextStyle(color: Colors.grey[700]),
                      )),
                  TextButton(
                      onPressed: () {
                        Get.to(RootPage());

                      },
                      child: Text(
                        "홈 구경하기",
                      )),
                ],
              ),
            ),
          ),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    ));
  }
}
