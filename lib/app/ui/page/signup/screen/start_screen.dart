import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/ui/page/signup/screen/phone_auth_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 150,),
          Text('모모두 앱ㅇㅇ \n 그 뭐냐 앱 처음 켜면 splash화면 다음 로고 나오고 밑에 번호인증 페이지'),
          Spacer(),
          TextButton(
            onPressed: (){
              Get.to(PhoneAuthScreen());
            },
            child: Text('번호로 로그인'),
          )
        ],
      ),
    );
  }
}


// DA:47:FF:84:3B:1E:14:1A:16:6D:A4:1B:C3:A2:54:00:FA:C0:D7:F6:32:2D:20:58:C0:7E:4E:D2:31:D3:35:CF
