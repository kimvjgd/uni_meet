import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/splash.png"))),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  height: Get.height,
                  width: Get.width,
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ),
          ),
          AlertDialog(
            title: Text('예상치 못한 오류가 발생했습니다. \n다시 한번 시도해주세요.',textAlign: TextAlign.center,),
            actions: [
              Center(child: TextButton(onPressed: (){}, child: Text('돌아가기')))
            ],
          )
        ],
      ),
    );
  }
}
