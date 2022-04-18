import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/ui/page/account/verify_number.dart';
import 'package:uni_meet/app/ui/page/account/widget/big_button.dart';

import '../../components/app_color.dart';

class LoginNumber extends StatefulWidget {
  const LoginNumber({Key? key}) : super(key: key,);
  @override
  _LoginNumberState createState() => _LoginNumberState();
}

class _LoginNumberState extends State<LoginNumber> {
  var _enterPhoneNumber = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool cuteMin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: BackButton(color: Colors.black,),
            title: Text("로그인",style: TextStyle(color: Colors.black),)),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(
                flex: 2,
              ),
              Text(
                "로고",
                style: TextStyle(
                  fontSize: 50,
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Text(
                "휴대폰 번호를 입력해주세요",
                style: TextStyle(
                    color: CupertinoColors.systemGrey.withOpacity(0.7),
                    fontSize: 20),
              ),
              Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "010",
                          style: TextStyle(
                              color: CupertinoColors.secondaryLabel, fontSize: 25),
                        ),
                        cuteMin?SizedBox():SizedBox(height: 23,),
                      ],
                    ),
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          cursorColor: app_red,
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: app_red))),
                          controller: _enterPhoneNumber,
                          validator: (number) {
                            if (number!.trim().length == 8)
                              return null;
                            else
                              return '번호를 다시 한 번 확인해주세요!';
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: CupertinoColors.secondaryLabel, fontSize: 25),
                        ),
                      ),
                    ),
                  ]),
              Spacer(
                flex: 1,
              ),
              BigButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()){
                        Get.to(VerifyNumber(number: "+8210" + _enterPhoneNumber.text.trim()));
                    }else {
                      cuteMin = false;
                      setState(() {});
                    }
                  },
                  btnText: "코드 전송하기"),
              Spacer(
                flex: 4,
              ),
            ],
          ),
        ));
  }
}
