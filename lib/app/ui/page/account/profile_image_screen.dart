import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
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
  int selected_profile = 0;
  String nickname = "";
  CollectionReference users =
      FirebaseFirestore.instance.collection(COLLECTION_USERS);

  TextEditingController _nicknameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
      appBar: AppBar(
        leading: BackButton(color: Colors.black,),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(headText: "새로운 만남을 대하는\n당신의 모습은 어떤가요?"),
              Spacer(
                flex: 2,
              ),
              selected_profile == 0
                  ? Center(
                      child: Container(
                        height: 120,
                        width: 120,
                        child: CircleAvatar(
                          child: Icon(
                            Icons.question_mark,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.grey[200],
                        ),
                      ),
                    )
                  : selected_profile == 1
                      ? Big_Momo('momo1.png')
                      : selected_profile == 2
                          ? Big_Momo('momo2.png')
                          : selected_profile == 3
                              ? Big_Momo('momo3.png')
                              : selected_profile == 4
                                  ? Big_Momo('momo4.png')
                                  : selected_profile == 5
                                      ? Big_Momo('momo5.png')
                                      : selected_profile == 6
                                          ? Big_Momo('momo6.png')
                                          : Container(height: 120, width: 120),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                    width: _size.width * 0.5,
                    child: Form(key: _formKey, child: _nicknameFormField())),
              ),
              Spacer(
                flex: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      onTap: () {
                        setState(() {
                          selected_profile = 1;
                        });
                      },
                      child: Momo('momo1.png', '적극적인 모모')),
                  InkWell(
                      onTap: () {
                        setState(() {
                          selected_profile = 2;
                        });
                      },
                      child: Momo('momo2.png', '쩝쩝박사 모모')),
                ],
              ),
              Spacer(
                flex: 1,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      selected_profile = 3;
                    });
                  },
                  child: Momo('momo3.png', '알콜저장소 모모'),
                ),
                InkWell(
                    onTap: () {
                      setState(() {
                        selected_profile = 4;
                      });
                    },
                    child: Momo('momo4.png', '알쓰 모모')),
                InkWell(
                    onTap: () {
                      setState(() {
                        selected_profile = 5;
                      });
                    },
                    child: Momo('momo5.png', '부끄러운 모모')),
              ]),
              Spacer(
                flex: 6,
              ),
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

  Center Big_Momo(String url) {
    return Center(
      child: Container(
        height: 120,
        width: 120,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/images/' + url),
        ),
      ),
    );
  }

  Column Momo(String url, String name) {
    return Column(
      children: [
        Container(
          height: 90,
          width: 90,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/images/' + url),
          ),
        ),
        SizedBox(
          height: 3,
        ),
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
                if (name!.isNotEmpty &&
                    name.length > 1 &&
                    name.length < 13 &&
                    !name.contains(' ')) {
                  return null;
                } else {
                  if (name.isEmpty) {
                    return '닉네임을 입력해주세요.';
                  } else if (name.contains(' ')) {
                    return '닉네임에 공백이 있습니다.';
                  }
                  return '닉네임은 2~12글자 사이입니다.';
                }
              },
            )),
          ],
        ),
      ),
    );
  }

  Future<bool> IsUsedNick(String NickName) async {
    late bool _isUsed;
    await FirebaseFirestore.instance
        .collection(COLLECTION_USERS)
        .where(KEY_USER_NICKNAME, isEqualTo: NickName)
        .limit(1)
        .get()
        .then((QuerySnapshot data) async {
          if (data.size > 0) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text(
                "이미 존재하는 닉네임입니다!",
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
            ));
            _isUsed = true;
          }
          else _isUsed =false;
    });
    return _isUsed;
  }

  Future<bool> IsBadNick(String NickName) async {
    late bool _isBad;
    List<dynamic> NameList=[];
    await FirebaseFirestore.instance
        .collection('exception')
        .doc('nickname')
        .get()
    .then((value) {
      NameList = value.data()!["NameList"];

      if(NameList.contains(NickName)){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
            "닉네임으로 사용하실 수 없습니다",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ));
        _isBad = true;

      }else _isBad =false;
    });

    return _isBad;
  }

  void onPressed() async {
    if (selected_profile == 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          "프로필을 설정해주세요!",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ));
    }
    else if (await IsUsedNick(_nicknameController.text) == false && await IsBadNick(_nicknameController.text) == false &&
        _formKey.currentState!.validate()) {
      var uid = FirebaseAuth.instance.currentUser!.uid;
      AuthController().pickImage(selected_profile);
      AuthController().nickName(_nicknameController.text);
      await FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(uid).update({
        KEY_USER_NICKNAME: _nicknameController.text,
        KEY_USER_LOCALIMAGE: selected_profile
      });
      Get.to(() => ConfettiScreen(
            selected_profile: selected_profile,
            nick_name: _nicknameController.text,
          ));
    }
  }
}
