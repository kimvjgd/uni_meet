import 'package:flutter/material.dart';
import 'package:uni_meet/app/ui/page/account/univ_check_screen.dart';
import 'package:uni_meet/app/ui/page/account/widget/big_button.dart';
import 'package:uni_meet/app/ui/page/account/widget/big_text.dart';
import 'package:uni_meet/app/ui/page/account/widget/confetti_effect.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/ui/page/screen_index/index_screen.dart';
import '../account/widget/confetti_effect.dart';


class ConfettiScreen extends StatefulWidget {
  const ConfettiScreen({Key? key,required this.selected_profile}) : super(key: key);
  final int selected_profile;
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
              BigText(headText: "환영합니다!"),
              Spacer(flex:2,),
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
                      Text("어쩌고")
                    ],
                  )
                      : widget.selected_profile ==1 ? Momo('diamond.png','모모1')
                      : widget.selected_profile ==2 ? Momo('uniexample.png','모모2')
                      : widget.selected_profile ==3 ? Momo('diamond.png','모모3')
                      : widget.selected_profile ==4 ? Momo('diamond.png','모모4')
                      : widget.selected_profile ==5 ? Momo('diamond.png','모모5')
                      : widget.selected_profile ==6 ? Momo('diamond.png','모모6')
                      :Container(height:110, width:110)
              ),
              Confetti(),
              Spacer(flex: 6,),
              BigButton(onPressed: onPressed, btnText: "학교 인증하러 가기")

            ],
          ),
        ),
      ),

    );
  }

  Column Momo(String url,String name){
    return Column(
      children: [
        Container(
          height: 150,
          width:150,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/'+url),
          ),
        ),
        SizedBox(height: 5,),
        Text(name,style: TextStyle(fontSize: 20),)
      ],
    );
  }

  void onPressed() {
    //Get.to(() => UnivCheckScreen());
    Get.to(()=>IndexScreen());
  }
}
