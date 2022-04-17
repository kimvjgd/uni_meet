import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
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
    return Container(
      width: Get.width / 2,
      height: Get.height / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ExtendedImage.asset(
              'assets/images/momo${localImage}.png',
              width: Get.width / 4,
              height: Get.height / 6,
            ),
          ),
          Spacer(),
          Text(university),
          Text(grade),
          Text(nickname),
          Row(
            children: [
              TextButton(
                onPressed: () {},     ///TODO
                child: Text('신고'),
              ),
              Spacer(),
              TextButton(
                onPressed: () {},     ///TODO
                child: Text('차단'),
              )
            ],
          )
        ],
      ),
    );
  }
}
