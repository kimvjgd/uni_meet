import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class ProfileWidget extends StatelessWidget {
  String university;
  String grade;
  String nickname;
  String localImage;

  ProfileWidget(
      {required this.university,
      required this.grade,
      required this.nickname,
      required this.localImage,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height/3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image:AssetImage('assets/images/momo${localImage}.png')),
              ),
            ),
          ),
          Expanded(
            flex: 3,
              child: Column(
            children: [
              Text("모모 이름 넣기"),
              Text(university+' '+grade),
              Text("mbti넣기"),
              Text(nickname),
            ],
          )),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {},     ///TODO
                  child: Text('신고'),
                ),
                TextButton(
                  onPressed: () {},     ///TODO
                  child: Text('차단'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
