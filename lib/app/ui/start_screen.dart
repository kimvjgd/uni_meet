import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_meet/app/ui/page/account/edit_number.dart';
import 'package:uni_meet/app/ui/page/account/login_number.dart';
import 'package:uni_meet/app/ui/page/account/widget/big_button.dart';
import 'package:get/get.dart';
class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: Stack(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/splash.png'),
                        fit: BoxFit.fill
                    ))),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                 BigButton(onPressed: (){Get.to(LoginNumber());}, btnText: "로그인하기"),
                 SizedBox(height: 20,),
                 BigButton(onPressed: (){Get.to(EditNumber());}, btnText: "회원가입하기"),
           ],
        ),
            ),
      ],
    ));
  }
}
