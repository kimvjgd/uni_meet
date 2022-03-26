import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../secret/secret_keys.dart';

class UniCheckScreen extends StatefulWidget {
  const UniCheckScreen({Key? key}) : super(key: key);

  @override
  _UniCheckScreenState createState() => _UniCheckScreenState();
}

class _UniCheckScreenState extends State<UniCheckScreen> {
  File? imageFile;
  String parsedtext = '';

  String name = "홍민영"; // 파이어베이스 연동 후 고쳐야 함
  String uni = "세종대";
  String everytime = "학교 인증";
  bool flag1 = false, flag2 = false, flag3 = false;

  Future _getFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    final image_temporary= File(pickedFile.path);

    var bytes = File(pickedFile.path.toString()).readAsBytesSync();
    String img64 = base64Encode(bytes);

    var url = 'https://api.ocr.space/parse/image';
    var payload = {"base64Image": "data:image/jpg;base64,${img64.toString()}","language" :"kor"};
    var header = {"apikey" :auth_image_key};

    var post = await http.post(Uri.parse(url),body: payload,headers: header);
    var result = jsonDecode(post.body);

    setState(() {
      this.imageFile = image_temporary;
      parsedtext = result['ParsedResults'][0]['ParsedText'];
    });
  }
  bool txtCheck() {
    flag1 = parsedtext.contains(name);
    flag2 = parsedtext.contains(uni);
    flag3 = parsedtext.contains(everytime);
     if(flag1) print("이름 확인");
     if(flag2) print("학교 확인");
     if(flag3) print("에타 확인");

    if (flag1 && flag2 && flag3)
      return true;
    else
      return false;
  }

  firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
      .ref('images/defaultProfile.png');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Future<void> uploadFB(File file) async {
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('uploads/file-to-upload.png')
          .putFile(file);
      print("업로드성공");
    } on FirebaseException catch (e) {
      print("업로드실패");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BackButton(),
          Text(
            "먼저 학교 인증을 해야해요",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Text("에브리타임 앱 > 내 정보 에 들어가서\n이름, 대학명, 학번이 보이게 스크린샷을 찍어주세요"),
          Text("크롭 된 파일이 아닌, 전체 스크린 샷을 업로드 해주세요!"),
          Spacer(
            flex: 1,
          ),
          Container(
              height: MediaQuery.of(context).size.width * 0.85,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.grey),
              child: Center(
                child: imageFile == null
                    ? Image.asset("assets/images/uniexample.png")
                    : Image.file(imageFile!),

              )),
          Spacer(
            flex: 1,
          ),
          ElevatedButton(
              onPressed: () {
                _getFromGallery();
              },
              child: Text("사진 업로드")
          ),
          ElevatedButton(
              onPressed: () {

                if (txtCheck())
                  {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text(
                        "인증이 완료되었습니다.",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.black,
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text(
                        "인증에 실패하였습니다. 다시 시도해 주세요.",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.black,
                    ));
                  }
              },
              child: Text("인증하기")),
          Spacer(
            flex: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "인증에 실패하셨나요?",
                style: TextStyle(color: Colors.grey),
              ),
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext child_context) {
                          return AlertDialog(
                            content: Text("사진 업로드 버튼을 통해 스크린에 캡쳐 파일을 띄운 후, 전송하기를 누르면 24시간 내로 학교 인증이 완료됩니다."),
                            actions: [
                              Center(
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          if(imageFile != null) uploadFB(imageFile!);}, child: Text("전송하기")),

                                  ],
                                ),
                              )
                            ],
                          );
                        });
                  },
                  child: Text(
                    "다른 방법으로 인증하기",
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          ),
        ],
      ),
    )));
  }
}
