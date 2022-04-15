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
import 'package:uni_meet/app/data/model/firestore_keys.dart';
import 'package:uni_meet/app/ui/components/app_color.dart';
import 'package:uni_meet/app/ui/page/account/widget/big_button.dart';
import 'package:uni_meet/app/ui/page/account/widget/big_text.dart';
import '../../../../secret/secret_keys.dart';
import '../screen_index/index_screen.dart';


class UnivCheckScreen extends StatefulWidget {
  const UnivCheckScreen({Key? key}) : super(key: key);

  @override
  _UnivCheckScreenState createState() => _UnivCheckScreenState();
}

class _UnivCheckScreenState extends State<UnivCheckScreen> {

  DocumentReference users = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid);

  File? imageFile;
  String parsedtext = '';
  String name = '';
  String uni ='';
  String grade = "";
  String everytime = "학교 인증";
  bool flag1 = false, flag2 = false, flag3 = false;
  bool? uni_check;

  Future _getFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    final image_temporary = File(pickedFile.path);

    setState(() {
      this.imageFile = image_temporary;
      _Recognition(imageFile);
    });
  }

  Future _Recognition(pickedFile) async {
    var bytes = File(pickedFile.path.toString()).readAsBytesSync();
    String img64 = base64Encode(bytes);

    var url = 'https://api.ocr.space/parse/image';
    var payload = {
      "base64Image": "data:image/jpg;base64,${img64.toString()}",
      "language": "kor"
    };
    var header = {"apikey": auth_image_key};

    var post = await http.post(Uri.parse(url), body: payload, headers: header);
    var result = jsonDecode(post.body);

    setState(() {
      parsedtext = result['ParsedResults'][0]['ParsedText'];
      uni_check = txtCheck();
    });
  }

  bool txtCheck() {
    flag1 = parsedtext.contains(name);
    flag2 = parsedtext.contains(uni);
    flag3 = parsedtext.contains(everytime);
    /*if (flag1) print("이름 확인");
    if (flag2) print("학교 확인");
    if (flag3) print("에타 확인");*/

    if (flag1 && flag2 && flag3)
      return true;
    else
      return false;
  }

  Future<void> uploadFB(File file) async {
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('uploads/'+FirebaseAuth.instance.currentUser!.uid.toString()+'.png')
          .putFile(file);
      print("업로드성공");
    } on FirebaseException catch (e) {
      print("업로드실패");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          name = data['name'];
          uni = data['university'];
          grade = data['grade'].toString() + "학번";
          return Scaffold(
            body: body(),
          );
        }
        //로딩화면 수정 필요 !!!!!!!
        return LinearProgressIndicator(backgroundColor: Colors.white,color: Colors.purple,);
      },
    );


  }
// 인증 후 바로 홈으로 일단 보내기,,,,
  SafeArea body(){
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(),
             // Text("임시 텍스트" + uni + grade + name),
              BigText(headText: "먼저, 학교 인증을 해야 해요!"),
              Spacer(
                flex: 1,
              ),
              Text("에브리타임 앱 > 내 정보 에 들어가서\n이름, 대학명, 학번이 보이게 스크린샷을 찍어주세요\n크롭 된 파일이 아닌, 전체 스크린 샷을 업로드 해주세요"
                ,style: TextStyle(color: app_label_grey),),
              Spacer(
                flex: 1,
              ),
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
                            backgroundColor: MaterialStateProperty.resolveWith((states) {
                              if(imageFile ==null){
                                return app_red;
                              }
                              else{
                                return Colors.white;
                              }
                            })
                          ),
                          onPressed: () {
                            _getFromGallery();
                          },
                          child:
                          imageFile ==null
                              ? Text("사진 업로드",style: TextStyle(color: Colors.white),)
                              : Text("사진 다시 고르기",style: TextStyle(color: app_red,fontWeight: FontWeight.bold),)
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(
                flex: 2,
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width*0.85,
                  height: MediaQuery.of(context).size.height*0.06,
                  child: BigButton(
                      onPressed: () {
                        if (imageFile == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text(
                              "이미지를 업로드 해 주세요 !",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.blue,
                          ));
                        }
                        else {
                          if(uni_check==null){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text(
                                "인식이 진행중입니다.",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.black,
                            ));
                          }
                          else if (uni_check==true) {
                            users.update({KEY_USER_AUTH: true})
                                .then((value) => print("User Updated"))
                                .catchError((error) => print("Failed to update user: $error"));
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text(
                                "인증에 실패하였습니다. 다시 시도해 주세요.",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.black,
                            ));
                            uni_check=null;
                          }

                          Get.to(IndexScreen());
                      }
                        },
                      btnText: "인증하기",)
                ),
                ),
              Spacer(
                flex: 1,
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(" 2~3분 이내에 학교인증이 완료됩니다.",style: TextStyle(color: app_systemGrey2),),
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
