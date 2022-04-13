import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/ui/page/account/profile_image_screen.dart';
import 'package:uni_meet/app/ui/page/account/widget/big_button.dart';
import 'package:uni_meet/app/ui/page/account/widget/big_text.dart';
import '../../../../secret/univ_list.dart';
import '../../../data/model/app_user_model.dart';


enum Gender { MAN, WOMAN }
class EditInfo extends StatefulWidget {
  final String uid;
  const EditInfo({Key? key, required this.uid}) : super(key: key);

  @override
  _EditInfoState createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  Gender _gender = Gender.MAN;
  bool complete = false;
  int age = 20;
  String mbti = '';
  int grade=0;

  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _univController = TextEditingController();
  TextEditingController _majorController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _univController.dispose();
    _majorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    DocumentReference users = FirebaseFirestore.instance.collection('users').doc(widget.uid);
    //파이어베이스 유저 개인정보 저장하기
    void createUserInFirestore (){
      AppUserModel userModel = AppUserModel(
        uid:FirebaseAuth.instance.currentUser?.uid,
        unicheck:false,
        phone:FirebaseAuth.instance.currentUser?.phoneNumber,
        name: _nameController.text,
        gender: _gender.toString(),
        university: _univController.text,
        major: _majorController.text,
       // grade: grade,
        mbti: mbti,
      );
      //users.update(userModel.toMap());
     // UserRepository.signup(userModel);
    }

    return GestureDetector(
      onTap: (){FocusScope.of(context).unfocus();},
      child: Scaffold(
        appBar: AppBar(title: Text("개인정보 입력하기")),
        body:Center(
          child: SizedBox(
            height: _size.height,
            width: _size.width*0.9,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("임시 user uid => "+widget.uid ),
                  BigText(headText: "안녕하세요!👋\n즐거운 만남을 위해\n당신에 대해 알려주세요."),
                  Form(key:_formKey,
                      child:Column(
                        children: [
                          _nameFormField("이름"),
                          _genderSelection("성별"),
                          _univPicker("대학교"),
                          _majorTextFormField("학과")
                        ],
                      )
                  ),
                  _gradePicker(),
                  _mbtiField(),
                  SizedBox(height: 30,),
                  BigButton(onPressed: () {
                    if(mbti == "" || grade == 0){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text(
                          "학번과 MBTI를 채워주세요 !",
                          style: TextStyle(color: Colors.black),
                        ),
                        backgroundColor: Colors.white,
                      ));
                    }
                    else if (_formKey.currentState!.validate()) {
                      createUserInFirestore();
                      Get.to(ProfileImageScreen());
                    } else {
                      print('입력 실패!');
                    }
                  }, btnText:"등록하기")
                ],
              ),
            ),
          ),
        )

      ),
    );
  }

  //성별 선택
  Padding _genderSelection(String category) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        child: Row(
          children: [
            SizedBox(width: 5,),
            Expanded(
                flex: 1,
                child: Container(
                  child: Text(category,style:TextStyle(fontSize: 16,color: Colors.grey[600]),
                ))),
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
                "남성",
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
              title: Text("여성",
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

  //이름 선택
  Padding _nameFormField(String category) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        child: Row(
          children: [
            Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                      label: Text(category),
                    contentPadding: EdgeInsets.all(5),
                  ),
                  controller: _nameController,
                  validator: (name) {
                    if (name!.isNotEmpty && name.length > 1) {
                      return null;
                    } else {
                      if (name.isEmpty) {
                        return '이름을 입력해주세요.';
                      }
                      return '이름이 너무 짧습니다.';
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }

  //대학교 선택
  Padding _univPicker(String category) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        child: Row(
          children: [
            Expanded(
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
                  TextFieldConfiguration(
                      controller: this._univController,
                    decoration: InputDecoration(
                      label: Text(category),
                      contentPadding: EdgeInsets.all(5),

                    )
                  ),
                )),
          ],
        ),
      ),
    );
  }
  //학과 선택
  Padding _majorTextFormField(String category) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        child: Row(
          children: [
            Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    label: Text(category),
                    contentPadding: EdgeInsets.all(5),
                  ),
                  controller: _majorController,
                  validator: (major) {
                    if (major!.isNotEmpty && major.length > 2) {
                      return null;
                    } else {
                      if (major.isEmpty) {
                        return '학과명을 입력해주세요.';
                      }
                      return '학과명을 정확히 기재해주세요.';
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }

  //학번 선택
  Padding _gradePicker() {
    List<int> gradeItem = [14,15,16,17,18,19,20,21,22];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        child: Row(
          children: [
            SizedBox(width: 5,),
            Expanded(
                flex: 1,
                child: Container(
                    child: Text("학번",style:TextStyle(fontSize: 16,color: Colors.grey[600]),
                    ))),
            Expanded(
              flex: 4,
              child: OutlinedButton(
                onPressed:(){
                  showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height:MediaQuery.of(context).size.height * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey[200]),
                              child: CupertinoPicker(
                                  itemExtent: 75,
                                  onSelectedItemChanged: (i) {
                                    setState(() {
                                      grade = gradeItem[i];
                                    });
                                  },
                                  children: [
                                    ...gradeItem.map((e) => Align(child: Text(e.toString() + '학번')))
                                  ]),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                child: TextButton(
                                  child:Text("완료"),
                                  onPressed: (){
                                    Navigator.pop(context);
                                    FocusScopeNode currentFocus = FocusScope.of(context);
                                    currentFocus.unfocus();
                                  },
                                )
                            ),
                          ],
                        );
                      });
                },
                child:grade == 0
                  ? Text("학번")
                  : Text(grade.toString() + "학번",style: TextStyle(color: Colors.black),),
    ),
            ),
          ],
        ),
      )
    );
  }

  //엠비티아이 선택
  Padding _mbtiField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        child: Row(
          children: [
            SizedBox(width: 5,),
            Expanded(
                flex: 1,
                child: Container(
                    child: Text("MBTI",style:TextStyle(fontSize: 16,color: Colors.grey[600]),
                    ))),
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
                      context: context,
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
              ),
            ),
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
        Navigator.pop(context);
        FocusScopeNode currentFocus = FocusScope.of(context);
        currentFocus.unfocus();
      },
    );
  }


}