import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;



class AuthImage extends StatefulWidget {
  const AuthImage({Key? key}) : super(key: key);

  @override
  State<AuthImage> createState() => _AuthImageState();
}

class _AuthImageState extends State<AuthImage> {

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


  firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('images/defaultProfile.png');
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
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
      body:Center(
        child: Column(
          children: [
            Spacer(flex: 3,),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey
              ),
              child: Center(
                child: imageFile==null
                    ? Text("사진을 등록하세요")
                    : Image.file(imageFile!),
              )
            ),
            Spacer(flex: 1,),
              ElevatedButton(onPressed:() {_getFromGallery();}, child: Text("사진 찾아보기")),
            Spacer(flex: 1,),
            Text(parsedtext),
            Spacer(flex: 2,),
            ElevatedButton(onPressed: (){
              //파베에 사진 업로드 됨
              if(imageFile != null) uploadFB(imageFile!);
              // Get.to(FriendListScreen());
            }, child: Text("등록")),
            Spacer(flex: 1,),

          ],
        ),
      ),
    );
  }
}


