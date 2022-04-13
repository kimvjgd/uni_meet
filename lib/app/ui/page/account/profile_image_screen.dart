import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:uni_meet/app/data/model/firestore_keys.dart';
import 'package:uni_meet/app/data/repository/user_repository.dart';
import 'package:uni_meet/app/ui/page/account/confetti_screen.dart';
import 'package:uni_meet/app/ui/page/account/univ_check_screen.dart';
import 'package:uni_meet/app/ui/page/account/widget/big_text.dart';
import 'package:uni_meet/app/ui/page/account/widget/confetti_effect.dart';
import 'package:uni_meet/app/ui/page/account/widget/big_button.dart';

import '../../../data/model/app_user_model.dart';


class ProfileImageScreen extends StatefulWidget {
  const ProfileImageScreen({Key? key}) : super(key: key);

  @override
  _ProfileImageScreenState createState() => _ProfileImageScreenState();
}


class _ProfileImageScreenState extends State<ProfileImageScreen> {
  int selected_profile= 0;
  String nickname="";
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  TextEditingController _nicknameController = TextEditingController();

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(),
              BigText(headText:"새로운 만남을 대하는\n당신의 모습은 어떤가요?"),
              Spacer(flex:2,),
              selected_profile ==0 ? Center(
                child: Container(
                  height:120,
                  width:120,
                  child: CircleAvatar(
                    child: Icon(Icons.question_mark,color: Colors.white,),
                    backgroundColor: Colors.grey[200],),
                ),
              )
                  : selected_profile ==1 ? Big_Momo('diamond.png')
                  : selected_profile ==2 ? Big_Momo('uniexample.png')
                  : selected_profile ==3 ? Big_Momo('diamond.png')
                  : selected_profile ==4 ? Big_Momo('diamond.png')
                  : selected_profile ==5 ? Big_Momo('diamond.png')
                  : selected_profile ==6 ? Big_Momo('diamond.png')
                  :Container(height:120, width:120),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: _size.width*0.5,
                    child: _nicknameFormField()),
              ),
              Spacer(flex:6,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      onTap: (){
                        setState(() {
                          selected_profile=1;
                        });
                      },
                      child:Momo('diamond.png','모모1')
                  ),
                  InkWell(
                      onTap: (){
                        setState(() {
                          selected_profile=2;
                        });
                      },
                      child: Momo('uniexample.png','모모2')
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        selected_profile=3;
                      });
                    },
                    child: Momo('diamond.png','모모3'),
                  ),],
              ),
              Spacer(flex: 1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      onTap: (){
                        setState(() {
                          selected_profile=4;
                        });
                      },
                      child:Momo('diamond.png','모모4')
                  ),
                  InkWell(
                      onTap: (){
                        setState(() {
                          selected_profile=5;
                        });
                      },
                      child: Momo('diamond.png','모모5')
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        selected_profile=6;
                      });
                    },
                    child: Momo('diamond.png','모모6'),
                  ),],
              ),
              Spacer(flex: 6,),
              BigButton(
                onPressed: onPressed,
                btnText: "선택하기",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Center Big_Momo(String url){
    return Center(
      child:Container(
        height: 120,
        width: 120,
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/images/'+url),
        ),
      ),
    );
  }
  Column Momo(String url,String name){
    return Column(
      children: [
        Container(
          height: 90,
          width:90,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/'+url),
          ),
        ),
        SizedBox(height: 3,),
        Text(name)
      ],
    );
  }

  Padding _nicknameFormField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        child: Row(
          children: [
            Expanded(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "닉네임을 입력해주세요",
                    contentPadding: EdgeInsets.all(5),
                  ),
                  controller: _nicknameController,
                  validator: (name) {
                    if (name!.isNotEmpty && name.length > 1) {
                      return null;
                    } else {
                      if (name.isEmpty) {
                        return '닉네임을 입력해주세요.';
                      }
                      return '닉네임이 너무 짧습니다.';
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }

  void onPressed() async {
    nickname = _nicknameController.text.trim();
    if (selected_profile == 0 || nickname == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          "닉네임과 프로필을 설정해주세요!",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ));
    }
    else {
      var uid = FirebaseAuth.instance.currentUser!.uid;
      FirebaseFirestore.instance.collection(COLLECTION_USERS)
          .doc(uid)
          .update({
        KEY_USER_NICKNAME: nickname,
        KEY_USER_LOCALIMAGE: selected_profile
      });

      Get.to(() => ConfettiScreen(selected_profile: selected_profile,nick_name: nickname,));
    }
  }
}