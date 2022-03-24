import 'package:flutter/material.dart';
import 'package:uni_meet/screen/widget/signup_button.dart';

enum Gender {MAN,WOMAN}

class AuthInfoScreen extends StatefulWidget {
  @override
  State<AuthInfoScreen> createState() => _AuthInfoScreenState();
}

class _AuthInfoScreenState extends State<AuthInfoScreen> {
  var _isChecked = false;
  Gender _gender=Gender.MAN;

  final _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text("안녕하세요!\n즐거운 만남을 위해\n당신에 대해 알려주세요"),
              SizedBox(height: 30,),
              Text("성별"),
              ListTile(
                title:Text("남자"),
                leading: Radio(
                  value: Gender.MAN,
                  groupValue: _gender,
                  onChanged: (Gender? value) {
                    setState(() {
                    _gender = value!;
                    });
                  },

                ),
              ),
              ListTile(
                title:Text("여자"),
                leading: Radio(
                  value: Gender.WOMAN,
                  groupValue: _gender,
                  onChanged: (Gender? value) {
                    setState(() {

                    _gender = value!;
                    });
                  },
                ),
              ),
              signup_button(size: _size),
            ],
          ),
        ),
      ),

    );
  }
}

