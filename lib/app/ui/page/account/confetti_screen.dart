import 'package:flutter/material.dart';
import 'package:uni_meet/app/ui/page/account/univ_check_screen.dart';
import 'package:uni_meet/app/ui/page/account/widget/big_button.dart';
import 'package:uni_meet/app/ui/page/account/widget/big_text.dart';
import 'package:uni_meet/app/ui/page/account/widget/confetti_effect.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/ui/page/screen_index/index_screen.dart';
import '../account/widget/confetti_effect.dart';


class ConfettiScreen extends StatefulWidget {
  const ConfettiScreen({Key? key,required this.selected_profile,required this.nick_name}) : super(key: key);
  final int selected_profile;
  final String nick_name;
  @override
  State<ConfettiScreen> createState() => _ConfettiScreenState();
}

class _ConfettiScreenState extends State<ConfettiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(),
              Spacer(flex:2,),
              Confetti(),
              Center(
                  child: widget.selected_profile ==0 ? Column(
                    children: [
                      Container(
                        height:110,
                        width:110,
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 3,),
                    ],
                  )
                      : widget.selected_profile ==1 ? Big_Momo('momo1.png')
                      : widget.selected_profile ==2 ? Big_Momo('momo2.png')
                      : widget.selected_profile ==3 ? Big_Momo('momo3.png')
                      : widget.selected_profile ==4 ? Big_Momo('momo4.png')
                      : widget.selected_profile ==5 ? Big_Momo('momo5.png')
                      :Container(height:110, width:110)
              ),
              Spacer(flex: 1,),
              Center(child:Text(widget.nick_name+"님, 환영합니다!")),
              Spacer(flex: 6,),
              BigButton(onPressed: onPressed, btnText: "학교 인증하러 가기")
            ],
          ),
        ),
      ),

    );
  }

  Center Big_Momo(String url){
    return Center(
      child:Container(
        height: 120,
        width: 120,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/images/'+url),
        ),
      ),
    );
  }

  void onPressed() {
    Get.to(() => UnivCheckScreen());
   // Get.to(()=>IndexScreen());
  }
}
