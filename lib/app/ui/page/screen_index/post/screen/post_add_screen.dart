import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/data/model/post_model.dart';
import 'package:uni_meet/app/data/repository/post_repository.dart';
import 'package:uni_meet/app/ui/page/account/widget/big_button.dart';

class PostAddScreen extends StatefulWidget {
  const PostAddScreen({Key? key}) : super(key: key);

  @override
  State<PostAddScreen> createState() => _PostAddScreenState();
}

class _PostAddScreenState extends State<PostAddScreen> {
  var logger = Logger();
  final GlobalKey<FormState> _PostformKey = GlobalKey();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  TextEditingController _peopleController = TextEditingController();
  String place="";

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _peopleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("디자인 나중에요..."),
          leading: Row(
            children: [
              Icon(Icons.arrow_back_ios),
              Text('홈'),
            ],
          ),
        ),
        body: Column(
          children: [
            Center(
              child: Form(
                key: _PostformKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        _peopleFormField(),
                        _placeField(),],
                    ),
                    _titleFormField(),
                    _contentFormField(),
                  ],
                ),
              ),
            ),
            BigButton(onPressed: _onPressed, btnText: "완료")
          ],
        )
      ),
    );
  }

  Padding _placeField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: 100,
        child: Row(
          children: [
            SizedBox(width: 5,),
            OutlinedButton(
              child: place == ""
                  ? Text("장소")
                  : Text(
                place,
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
                        heightFactor: 0.2,
                        child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                _place("무관", context),
                                _place("홍대", context),
                                _place("신촌", context),
                                _place("건대", context),
                                _place("강남", context),
                              ],
                            )),
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
  Padding _peopleFormField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        child: Row(
          children: [
            SizedBox(
                width: 100,
                child: TextFormField(
                  decoration: InputDecoration(
                    label: Text("인원 수"),
                    contentPadding: EdgeInsets.all(15),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0)),

                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                      BorderSide(width: 1, color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  controller: _peopleController,
                  validator: (people) {
                    if(people!.isEmpty) return '인원 수를 입력해주세요.';
                    else{
                      var value = int.tryParse(people);
                      if (value == null) {
                        return '인원을 숫자 형식으로 입력해주세요.';
                      }
                      else if (value < 1 || value > 5) { //나중에 바꿈
                        return '인원 수는 2-5명 범위에서 가능합니다.';
                      } else {
                        return null;
                      }
                    }
                  },
                )
            ),
          ],
        ),
      ),
    );
  }
  Padding _titleFormField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Flexible(
              child: TextFormField(
                maxLines: 1,
                decoration: InputDecoration(
                  label: Text("제목"),
                  hintText: "제목을 입력해주세요",
                  contentPadding: EdgeInsets.all(15),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(10.0)),

                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                    BorderSide(width: 1, color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                controller: _titleController,
                validator: (title) {
                  if (title!.isNotEmpty && title.length > 1) {
                    return null;
                  } else {
                    if (title.isEmpty) {
                      return '제목을 입력해주세요.';
                    }
                    return '제목이 너무 짧습니다.';
                  }
                },
              )),
        ],
      ),
    );
  }
  Padding _contentFormField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          children: [
            Flexible(
                child: TextFormField(
                  maxLines: null,
                  decoration: InputDecoration(
                    label: Text("내용"),
                    hintText: "00학번 이상/이하 구해요, 00대학교 구해요, MBTI 0000구해요, 술 잘마시는 사람 구해요",
                    contentPadding: EdgeInsets.fromLTRB(15, 70, 15, 70),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                      BorderSide(width: 1, color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0)),
                    ),

                  ),
                  controller: _contentController,
                  validator: (content) {
                    if (content!.isNotEmpty && content.length > 1) {
                      return null;
                    } else {
                      if (content.isEmpty) {
                        return '내용을 입력해주세요.';
                      }
                      return '내용이 너무 짧습니다.';
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
  TextButton _place(String text, context) {
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
          this.place = text;
        });
        Navigator.pop(context);
        FocusScopeNode currentFocus = FocusScope.of(context);
        currentFocus.unfocus();
      },
    );
  }

  _onPressed(){
    if(place == "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          "장소를 입력해주세요 !",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ));
    }
    else if (_PostformKey.currentState!.validate()) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext child_context) {
            return AlertDialog(
              content: Text(
                  "등록하시겠습니까?"),
              actions: [
                Center(
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            logger.d("${_titleController.text} && ${_contentController
                                .text}");
                            await PostRepository.createPost(
                                title: _titleController.text,
                                content: _contentController.text,
                                place: place,
                                headCount: int.parse(_peopleController.text),
                                createdDate: DateTime.now(),
                                host: AuthController.to.user.value.uid!,
                                hostpushToken: ''
                            );
                            Get.back();
                            Get.back();
                            //  Get.offAll(() => PostListScreen());
                            //이렇게 써도 되남..
                          },
                          child: Text("등록하기")),

                    ],
                  ),
                )
              ],
            );
          });}

  }
}
