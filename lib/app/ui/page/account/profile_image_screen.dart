import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:uni_meet/app/data/model/firestore_keys.dart';
import 'package:uni_meet/app/data/repository/user_repository.dart';
import 'package:uni_meet/app/ui/page/account/confetti_screen.dart';
import 'package:uni_meet/app/ui/page/account/univ_check_screen.dart';
import 'package:uni_meet/app/ui/page/account/widget/big_text.dart';
import 'package:uni_meet/app/ui/page/account/widget/confetti_effect.dart';
import 'package:uni_meet/app/ui/page/account/widget/big_button.dart';

import '../../../data/model/app_user_model.dart';


class ProfileImageScreen extends StatefulWidget {
  const ProfileImageScreen({Key? key}) : super(key: key);

  @override
  _ProfileImageScreenState createState() => _ProfileImageScreenState();
}


class _ProfileImageScreenState extends State<ProfileImageScreen> {
  int selected_profile= 0;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();

  }
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
              BigText(headText:"새로운 만남을 대하는\n당신의 모습은 어떤가요?"),
              Spacer(flex:2,),
              Center(
                  child: selected_profile ==0 ? Column(
                    children: [
                      Container(
                        height:110,
                        width:110,
                      ),
                      SizedBox(height: 3,),
                    ],
                  )
                      : selected_profile ==1 ? Momo('diamond.png','모모1')
                      : selected_profile ==2 ? Momo('uniexample.png','모모2')
                      : selected_profile ==3 ? Momo('diamond.png','모모3')
                      : selected_profile ==4 ? Momo('diamond.png','모모4')
                      : selected_profile ==5 ? Momo('diamond.png','모모5')
                      : selected_profile ==6 ? Momo('diamond.png','모모6')
                      :Container(height:110, width:110)
              ),
              Spacer(flex: 2,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      onTap: (){
                        setState(() {
                          selected_profile=1;
                        });
                      },
                      child:Momo('diamond.png','모모1')
                  ),
                  InkWell(
                      onTap: (){
                        setState(() {
                          selected_profile=2;
                        });
                      },
                      child: Momo('uniexample.png','모모2')
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        selected_profile=3;
                      });
                    },
                    child: Momo('diamond.png','모모3'),
                  ),],
              ),
              Spacer(flex: 1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      onTap: (){
                        setState(() {
                          selected_profile=4;
                        });
                      },
                      child:Momo('diamond.png','모모4')
                  ),
                  InkWell(
                      onTap: (){
                        setState(() {
                          selected_profile=5;
                        });
                      },
                      child: Momo('diamond.png','모모5')
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        selected_profile=6;
                      });
                    },
                    child: Momo('diamond.png','모모6'),
                  ),],
              ),
              Spacer(flex: 6,),
              BigButton(
                onPressed: onPressed,
                btnText: "선택하기",
              ),
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
          height: 90,
          width:90,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/'+url),
          ),
        ),
        SizedBox(height: 3,),
        Text(name)
      ],
    );
  }


  void onPressed() async {

    var uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance.collection(COLLECTION_USERS)
        .doc(uid)
        .update({KEY_USER_LOCALIMAGE:selected_profile});

    Get.to(() => ConfettiScreen(selected_profile: selected_profile));
  }

}