import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/ui/components/app_color.dart';

class ProfileWidget extends StatelessWidget {
  String university;
  String grade;
  String nickname;
  String localImage;
  String mbti;

  ProfileWidget(
      {required this.university,
      required this.grade,
      required this.nickname,
      required this.localImage,
        required this.mbti,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> momo_name = ["","적극적인 모모","쩝쩝박사 모모","알콜저장소 모모","알쓰 모모","부끄러운 모모",];

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
              Text(momo_name[int.parse(localImage)],style: TextStyle(color: app_systemGrey1,fontSize: 13),),
              Text(""),
              Text(university+' '+grade),
              Text(mbti),
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
