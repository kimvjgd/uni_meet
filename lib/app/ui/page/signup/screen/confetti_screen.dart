import 'package:flutter/material.dart';
import 'package:uni_meet/app/ui/page/signup/widget/signup_button.dart';
import 'package:uni_meet/app/ui/page/signup/widget/confetti_effect.dart';


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
                onPressed: onPressed,
              ),
            ],
          ),
        ),
      ),

    );
  }
  void onPressed() {

  }
}
