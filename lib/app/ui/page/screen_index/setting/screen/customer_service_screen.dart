import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/ui/page/screen_index/setting/screen/personal_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/setting/screen/service_term_screen.dart';
import '../../../../components/app_color.dart';
import '../../message_popup.dart';
import 'alarm_screen.dart';
import 'open_source_screen.dart';

class CustomerServiceScreen extends StatefulWidget {
  const CustomerServiceScreen({Key? key}) : super(key: key);

  @override
  State<CustomerServiceScreen> createState() => _CustomerServiceScreenState();
}

class _CustomerServiceScreenState extends State<CustomerServiceScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController askcontroller = TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    askcontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final List<String> title = <String>['문의하기','신고하기','회원탈퇴',];
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:AppBar(
        backgroundColor:Colors.white,
        elevation: 2,
        title: Text("고객센터",style: TextStyle(color:Colors.grey[800]),),
       leading: BackButton(color: Colors.grey[800],),
      ),
      body:ListView(
        children:
      ListTile.divideTiles(
      context: context,
      tiles: [
        ListTile(
          title: Text("문의하기"),
          onTap: (){
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                      height: _size.height*0.5,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                                child: Text("문의하기")),
                            Expanded(
                              flex: 1,
                                child: TextFormField(
                                  controller: emailcontroller,
                                  decoration: InputDecoration(
                                    hintText: '회신받을 이메일을 입력해주세요'
                                  ),
                            )),
                            Expanded(
                              flex: 5,
                              child: TextFormField(
                                maxLines: 10,
                                controller: askcontroller,
                                decoration: InputDecoration(
                                  hintText: '\n\n모모두에게 문의나 건의할 사항이 있다면 자유롭게 작성해주세요! 모모두 운영진이 3일 내로 확인 후 답변을 전달할 예정이예요',
                                ),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: (){
                                    try {
                                      FirebaseStorage.instance
                                          .ref('uploads/ask/'+emailcontroller.text+'/'+FirebaseAuth.instance.currentUser!.uid.toString())
                                          .putString(askcontroller.text);

                                      print(emailcontroller.text+"업로드성공");
                                      emailcontroller.clear();
                                      askcontroller.clear();
                                    } on FirebaseException catch (e) {
                                      print("업로드실패");
                                      print(e);
                                    }


                                },
                                child: Text("제출하기"))
                          ],
                        )
                    ),
                  );
                }
            );
          },
        ),
        Divider(thickness: 1,color: app_systemGrey4,),
        ListTile(
          title: Text("신고하기"),
          onTap: (){
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                        height: _size.height*0.5,
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Text("신고하기")),
                            Expanded(
                                flex: 1,
                                child: TextFormField(
                                  controller: emailcontroller,
                                  decoration: InputDecoration(
                                      hintText: '신고 대상의 닉네임을 입력해주세요'
                                  ),
                                )),
                            Expanded(
                              flex: 5,
                              child: TextFormField(
                                maxLines: 10,
                                controller: askcontroller,
                                decoration: InputDecoration(
                                  hintText: '신고 내용을 작성해주세요!\n이미지 첨부 시, team.momodu@gmail.com\n으로 첨부를 부탁드립니다!',
                                ),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: (){
                                  //신고 만들기 .......
                                },
                                child: Text("제출하기"))
                          ],
                        )
                    ),
                  );
                }
            );

          },
        ),
        Divider(thickness: 1,color: app_systemGrey4,),
        ListTile(
          title: Text("회원탈퇴"),
          onTap: (){

          },
        ),
        Divider(thickness: 1,color: app_systemGrey4,),
      ]).toList())
    );
  }
}
