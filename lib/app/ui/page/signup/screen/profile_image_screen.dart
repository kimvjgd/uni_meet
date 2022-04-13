import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:uni_meet/app/ui/page/signup/screen/univ_check_screen.dart';
import '../widget/signup_button.dart';

class ProfileImageScreen extends StatefulWidget {
  const ProfileImageScreen({Key? key}) : super(key: key);

  @override
  _ProfileImageScreenState createState() => _ProfileImageScreenState();
}


class _ProfileImageScreenState extends State<ProfileImageScreen> {
  int selected_profile= -1;


  @override
  void initState() {
    selected_profile= -1;
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
              Text("새로운 만남을 대하는\n당신의 모습은 어떤가요?",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
              Spacer(flex:2,),
              Center(
                  child: selected_profile ==0 ? Column(
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
                      : selected_profile ==1 ? Column(
                    children: [
                      Container(
                        height:110,
                        width:110,
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                        ),
                      ),
                      SizedBox(height: 3,),
                      Text("어쩌고")
                    ],
                  )
                      : selected_profile ==2 ? Column(
                    children: [
                      Container(
                        height:110,
                        width:110,
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                        ),
                      ),
                      SizedBox(height: 3,),
                      Text("어쩌고")
                    ],
                  )
                      : selected_profile ==3 ? Column(
                    children: [
                      Container(
                        height:110,
                        width:110,
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                        ),
                      ),
                      SizedBox(height: 3,),
                      Text("어쩌고")
                    ],
                  )
                      : selected_profile ==4 ? Column(
                    children: [
                      Container(
                        height:110,
                        width:110,
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                        ),
                      ),
                      SizedBox(height: 3,),
                      Text("어쩌고")
                    ],
                  )
                      : selected_profile ==5 ? Column(
                    children: [
                      Container(
                        height:110,
                        width:110,
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                        ),
                      ),
                      SizedBox(height: 3,),
                      Text("어쩌고")
                    ],
                  )
                      :Container(height:110, width:110)
              ),
              Spacer(flex: 2,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        selected_profile=0;
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 90,
                          width:90,
                          child:
                          selected_profile==0? CircleAvatar(backgroundColor: Colors.grey,) :CircleAvatar(backgroundColor: Colors.blue),
                        ),
                        SizedBox(height: 3,),
                        Text("어쩌고")
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        selected_profile=1;
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 90,
                          width:90,
                          child: selected_profile==1
                              ? CircleAvatar(backgroundColor: Colors.grey,)
                              :CircleAvatar(backgroundColor: Colors.red),
                        ),
                        SizedBox(height: 3,),
                        Text("어쩌고")
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        selected_profile=2;
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 90,
                          width:90,
                          child: selected_profile==2
                              ? CircleAvatar(backgroundColor: Colors.grey,)
                              :CircleAvatar(backgroundColor: Colors.green),
                        ),
                        SizedBox(height: 3,),
                        Text("어쩌고")
                      ],
                    ),
                  ),],
              ),
              Spacer(flex: 1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 90,
                        width:90,
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                        ),
                      ),
                      SizedBox(height: 3,),
                      Text("어쩌고")
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 90,
                        width:90,
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 3,),
                      Text("어쩌고")
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 90,
                        width:90,
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                        ),
                      ),
                      SizedBox(height: 3,),
                      Text("어쩌고")
                    ],
                  ),],
              ),
              Spacer(flex: 6,),
              signup_button(
                size:MediaQuery.of(context).size,
                onPressed: onPressed,
              ),
            ],
          ),
        ),
      ),

    );
  }


  void onPressed() async {
      Get.to(UnivCheckScreen());
  }
}
