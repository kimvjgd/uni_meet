import 'package:flutter/material.dart';
import 'package:uni_meet/screen/widget/confetti_effect.dart';
import 'package:uni_meet/screen/widget/signup_button.dart';


class ProfileCongratsScreen extends StatefulWidget {
  const ProfileCongratsScreen({Key? key,required this.selected_profile}) : super(key: key);
  final int selected_profile;
  @override
  State<ProfileCongratsScreen> createState() => _ProfileCongratsScreenState();
}

class _ProfileCongratsScreenState extends State<ProfileCongratsScreen> {
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
              Text("환영합니다!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
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
                      : widget.selected_profile ==1 ? Column(
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
                      : widget.selected_profile ==2 ? Column(
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
                      : widget.selected_profile ==3 ? Column(
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
                      : widget.selected_profile ==4 ? Column(
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
                      : widget.selected_profile ==5 ? Column(
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
              Confetti(),
              Spacer(flex: 6,),
              signup_button(
                size:MediaQuery.of(context).size,
              ),
            ],
          ),
        ),
      ),

    );
  }
}
