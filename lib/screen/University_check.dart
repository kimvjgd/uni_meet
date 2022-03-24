import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class UniCheckScreen extends StatefulWidget {
  const UniCheckScreen({Key? key}) : super(key: key);

  @override
  _UniCheckScreenState createState() => _UniCheckScreenState();
}

class _UniCheckScreenState extends State<UniCheckScreen> {


  File? imageFile;
  String parsedtext = '';

  Future _getFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    final image_temporary= File(pickedFile.path);

    var bytes = File(pickedFile.path.toString()).readAsBytesSync();
    String img64 = base64Encode(bytes);

    var url = 'https://api.ocr.space/parse/image';
    var payload = {"base64Image": "data:image/jpg;base64,${img64.toString()}","language" :"kor"};
    var header = {"apikey" :"K84674039688957"};

    var post = await http.post(Uri.parse(url),body: payload,headers: header);
    var result = jsonDecode(post.body);

    setState(() {
      this.imageFile = image_temporary;
      parsedtext = result['ParsedResults'][0]['ParsedText'];
    });
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
                    Text("먼저 학교 인증을 해야해요",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                    Text("에브리타임 앱 > 내 정보 에 들어가서\n이름, 대학명, 학번이 보이게 스크린샷을 찍어주세요"),
                    Spacer(flex:2,),
                    Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.grey
                        ),
                        child: Center(
                          child: imageFile==null
                              ? Image.asset("assets/images/uniexample.png")
                              : Image.file(imageFile!),
                        )
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

                            },
                            child: Text(
                              "다른 방법으로 인증하기",
                              style: TextStyle(color: Colors.blue),
                            ))
                      ],
                    ),
                    ElevatedButton(onPressed:() {_getFromGallery();}, child: Text("사진 업로드")),

                  ],
              ),
            )
        )
    );
  }
}
