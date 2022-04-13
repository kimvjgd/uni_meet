import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/data/model/app_user_model.dart';
import 'package:uni_meet/app/data/repository/user_repository.dart';
import 'package:uni_meet/app/ui/page/signup/screen/profile_image_screen.dart';
import 'package:uni_meet/app/ui/page/signup/widget/age_bottom_sheet.dart';
import 'package:uni_meet/app/ui/page/signup/widget/intro.dart';
import 'package:uni_meet/app/ui/page/signup/widget/major_textformfield.dart';
import 'package:uni_meet/app/ui/page/signup/widget/signup_button.dart';
import 'package:uni_meet/secret/univ_list.dart';

enum Gender { MAN, WOMAN }

class AuthInfoScreen extends StatefulWidget {
  final BuildContext context;
  final String uid;

  AuthInfoScreen({required this.context, required this.uid, Key? key})
      : super(key: key);

  @override
  State<AuthInfoScreen> createState() => _AuthInfoScreenState();
}

class _AuthInfoScreenState extends State<AuthInfoScreen> {

  var _isChecked = false;

  Gender _gender = Gender.MAN;
  bool complete = false;
  int age = 20;
  String mbti = '';

  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController _nickNameController = TextEditingController();

  TextEditingController _univController = TextEditingController();

  TextEditingController _majorController = TextEditingController();


  @override
  void dispose() {
    _nickNameController.dispose();
    _univController.dispose();
    _majorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: _size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Intro(),
                    _genderSelection("성별"),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _nickTextFormField("이름", "future"),
                          _mbtiField(),
                          _agePicker("학번"),
                          _univPicker("대학교"),
                          MajorTextFormField(category: "학과", majorController: _majorController),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: signup_button(
        size: _size, // 나중에 bool complete로 색전환 구현
        onPressed: onPressed,
      ),
    );
  }

  void onPressed() async {
    if (_formKey.currentState!.validate()) {
      var signupUser = AppUserModel(
          uid: widget.uid,
          name: _nickNameController.text,
          major: _majorController.text,
          mbti: mbti,
          gender: _gender.toString(),
          university: _univController.text,
          age: Get.find<AuthController>().user.value.age ?? 20);

      await UserRepository.signup(signupUser);

      Get.to(() => ProfileImageScreen());

    //  Get.to(ProfileImageScreen());
    } else {
    }
  }

  Padding _nickTextFormField(String category, String content) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  child: Text(category),
                )),
            Expanded(
                flex: 4,
                child: TextFormField(
                  controller: _nickNameController,
                  validator: (name) {
                    if (name!.isNotEmpty && name.length > 2) {
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

  Padding _mbtiField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  child: Text("MBTI"),
                )),
            Expanded(
                flex: 4,
                child: OutlinedButton(
                  child: mbti == ""
                      ? Text("MBTI")
                      : Text(
                    mbti,
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        clipBehavior: Clip.none,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: widget.context,
                        builder: (context) {
                          return FractionallySizedBox(
                            heightFactor: 0.6,
                            child: Container(
                                padding: EdgeInsets.all(20),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text("분석형"),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          _mbti("INTJ", context),
                                          _mbti("INTP", context),
                                          _mbti("ENTJ", context),
                                          _mbti("ENTP", context),
                                        ],
                                      ),
                                      Text("외교형"),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          _mbti("INFJ", context),
                                          _mbti("INFP", context),
                                          _mbti("ENFJ", context),
                                          _mbti("ENFP", context),
                                        ],
                                      ),
                                      Text("관리자형"),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          _mbti("ISTJ", context),
                                          _mbti("ISFJ", context),
                                          _mbti("ESTJ", context),
                                          _mbti("ESFJ", context),
                                        ],
                                      ),
                                      Text("탐험가형"),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          _mbti("ISTP", context),
                                          _mbti("ISFP", context),
                                          _mbti("ESTP", context),
                                          _mbti("ESFP", context),
                                        ],
                                      ),
                                    ])),
                          );
                        });
                  },
                )),
          ],
        ),
      ),
    );
  }

  TextButton _mbti(String text, context) {
    return TextButton(
      child: Text(text),
      style: ButtonStyle(
          textStyle: MaterialStateProperty.all(TextStyle(fontSize: 17)),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black;
            } else {
              return Colors.grey;
            }
          }),
          padding:
          MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(16)),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white;
            } else {
              return Colors.grey[200];
            }
          }),
          shape: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30));
            } else {
              return null;
            }
          })),
      onPressed: () {
        setState(() {
          this.mbti = text;
        });
        print(mbti);
        Navigator.pop(context);
      },
    );
  }

  Padding _univPicker(String category) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  child: Text(category),
                )),
            Expanded(
                flex: 4,
                child: TypeAheadField<String>(
                  suggestionsCallback: (String pattern) {
                    return univList.where((item) =>
                        item.toLowerCase().contains(pattern.toLowerCase()));
                  },
                  itemBuilder: (BuildContext context, itemData) {
                    return ListTile(
                      title: Text(itemData),
                    );
                  },
                  onSuggestionSelected: (String suggestion) {
                    setState(() {
                      this._univController.text = suggestion;
                    });
                  },
                  textFieldConfiguration:
                  TextFieldConfiguration(controller: this._univController),
                )),
          ],
        ),
      ),
    );
  }

  Padding _agePicker(String category) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  child: Text(category),
                )),
            Expanded(
                flex: 4,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: widget.context,
                        builder: (_) {
                          print(Get.find<AuthController>()
                              .user
                              .value
                              .age
                              .toString());
                          return AgeBottomSheet(age: Get.find<AuthController>().user.value.age!=null?Get.find<AuthController>().user.value.age!:20);
                        });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Text(
                          Get.find<AuthController>().user.value.age.toString()=='null'?'20':Get.find<AuthController>().user.value.age.toString())),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Padding _genderSelection(String category) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  child: Text(category),
                )),
            Expanded(flex: 4, child: _genderRadio()),
          ],
        ),
      ),
    );
  }

  Row _genderRadio() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: InkWell(
            highlightColor: Colors.white,
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                _gender = Gender.MAN;
              });
            },
            child: ListTile(
              title: Text(
                "남자",
                style: TextStyle(
                    color: _gender == Gender.MAN ? Colors.blue : Colors.black),
              ),
              leading: Radio(
                value: Gender.MAN,
                groupValue: _gender,
                onChanged: (Gender? value) {
                  setState(() {
                    _gender = value!;
                  });
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            highlightColor: Colors.white,
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                _gender = Gender.WOMAN;
              });
            },
            child: ListTile(
              title: Text("여자",
                  style: TextStyle(
                      color: _gender == Gender.WOMAN
                          ? Colors.blue
                          : Colors.black)),
              leading: Radio(
                value: Gender.WOMAN,
                groupValue: _gender,
                onChanged: (Gender? value) {
                  setState(() {
                    _gender = value!;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

}