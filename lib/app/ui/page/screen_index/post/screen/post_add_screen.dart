import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/data/model/post_model.dart';
import 'package:uni_meet/app/data/repository/post_repository.dart';
import 'package:uni_meet/app/ui/components/app_color.dart';
import 'package:uni_meet/app/ui/page/account/widget/big_button.dart';

import '../../../../../controller/bottom_nav_controller.dart';

class PostAddScreen extends StatefulWidget {
  const PostAddScreen({Key? key}) : super(key: key);

  @override
  State<PostAddScreen> createState() => _PostAddScreenState();
}

class _PostAddScreenState extends State<PostAddScreen> {
  final GlobalKey<FormState> _PostformKey = GlobalKey();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  String place = "";
  int people = 0;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "글쓰기",
            style: TextStyle(color: Colors.black),
          ),
          leading: BackButton(
            color: Colors.black,
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Form(
                key: _PostformKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _titleFormField(),
                    _placeField(),
                    _peopleFormField(),
                    _contentFormField(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BigButton(onPressed: _onPressed, btnText: "완료"),
          ),
        ],
      ),
    );
  }

  Row _titleFormField() {
    return Row(
      children: [
        Flexible(
            child: TextFormField(
          maxLines: 1,
          decoration: InputDecoration(
            hintText: "제목을 입력해주세요",
            hintStyle: TextStyle(color: app_systemGrey4),
            contentPadding: EdgeInsets.all(15),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: app_systemGrey2),
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
    );
  }

  Row _contentFormField() {
    return Row(
      children: [
        Flexible(
            child: TextFormField(
          maxLines: null,
          decoration: InputDecoration(
              hintStyle: TextStyle(color: app_systemGrey4),
              hintText:
                  "간단한 자기소개와\n만나고 싶은 모모들의 조건을 작성해주세요 !\n \n[예시]\n안녕하세요~ 모모대학교 모모과 20학번 남자 3명입니다!\n21학번 여성 세 분 구해요/00대학교 구해요/MBTI E인 분들 구해요/술 잘 마시는 분 구해요",
              hintMaxLines: 10,
              contentPadding: EdgeInsets.fromLTRB(15, 70, 15, 70),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent),
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(width: 0, color: Colors.transparent))),
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
    );
  }

  Stack _peopleFormField() {
    return Stack(children: [
      Row(children: [
        Flexible(
            child: TextFormField(
          enabled: false,
          decoration: InputDecoration(
            hintText: "인원 수",
            contentPadding: EdgeInsets.all(15),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: app_systemGrey4),
            ),
          ),
          keyboardType: TextInputType.number,
          // controller: _peopleController,
          // validator: (people) {
          //   if (people!.isEmpty)
          //     return '인원 수를 입력해주세요.';
          //   else {
          //     var value = int.tryParse(people);
          //     if (value == null) {
          //       return '인원을 숫자 형식으로 입력해주세요.';
          //     } else if (value < 1 || value > 5) {
          //       //나중에 바꿈
          //       return '인원 수는 2-5명 범위에서 가능합니다.';
          //     } else {
          //       return null;
          //     }
          //   }
          // },
        )),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 200,
            child: _peoplePicker(),
          ),
        ),
      ]),
    ]);
  }

  OutlinedButton _peoplePicker() {
    List<int> peopleItem = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    return OutlinedButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (_) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[200]),
                    child: CupertinoPicker(
                        itemExtent: 75,
                        onSelectedItemChanged: (i) {
                          setState(() {
                            people = peopleItem[i];
                          });
                        },
                        children: [
                          ...peopleItem.map(
                              (e) => Align(child: Text(e.toString() + '명')))
                        ]),
                  ),
                  ElevatedButton(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "완료",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      currentFocus.unfocus();
                    },
                  ),
                ],
              );
            });
      },
      child: people == 0
          ? Text(
              "본인을 포함한 인원 수를 선택해 주세요!",
              style: TextStyle(fontSize: 10, color: app_systemGrey2),
            )
          : Text(
              people.toString() + "명",
              style: TextStyle(color: app_red),
            ),
    );
  }

  Stack _placeField() {
    return Stack(children: [
      Row(
        children: [
          Flexible(
            child: TextFormField(
              enabled: false,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 1, color: app_systemGrey4),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 1, color: app_systemGrey4),
                  ),
                  hintText: "장소"),
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 200,
              child: OutlinedButton(
                child: place == ""
                    ? Text(
                        "선택안함",
                        style: TextStyle(color: app_systemGrey4),
                      )
                    : Text(
                        place,
                        style: TextStyle(color: app_red),
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
            ),
          ),
        ],
      ),
    ]);
  }

  Stack _place(String text, context) {
    return Stack(children: [
      Row(children: [
        TextButton(
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
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(16)),
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
        ),
      ])
    ]);
  }

  _onPressed() {
    if (place == "" || people == 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          "장소와 인원수를 확인해주세요 !",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ));
    } else if (_PostformKey.currentState!.validate()) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext child_context) {
            return AlertDialog(
              content: Text("등록하시겠습니까?"),
              actions: [
                Center(
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            await PostRepository.createPost(
                                title: _titleController.text,
                                content: _contentController.text,
                                place: place,
                                headCount: people,
                                createdDate: DateTime.now(),
                                host: AuthController.to.user.value.uid!,
                                hostUni: AuthController.to.user.value.university.toString(),
                                hostNick: AuthController.to.user.value.nickname.toString(),
                                hostGrade: AuthController.to.user.value.grade.toString(),
                                hostpushToken: AuthController.to.user.value.token.toString());
                            Get.back();
                            Get.back();
                            Get.put(BottomNavController()).changeBottomNav(1);
                            //  Get.offAll(() => PostListScreen());
                            //이렇게 써도 되남..
                          },
                          child: Text("등록하기")),
                    ],
                  ),
                )
              ],
            );
          });
    }
  }
}
