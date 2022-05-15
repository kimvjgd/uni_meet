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
import 'package:flutter/foundation.dart' show TargetPlatform;

import '../../components/app_color.dart';

class EditNumber extends StatefulWidget {
  const EditNumber({Key? key})
      : super(
          key: key,
        );
  @override
  _EditNumberState createState() => _EditNumberState();
}

class _EditNumberState extends State<EditNumber> {
  bool _isagreed_A = false;
  bool _isagreed_B = false;
  var _enterPhoneNumber = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool cuteMin = true;

  @override
  Widget build(BuildContext context) {
    var platform = Theme.of(context).platform;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              color: Colors.black,
            ),
            title: Text(
              "회원가입",
              style: TextStyle(color: Colors.black),
            ),
            elevation: 0.0,
          ),
          resizeToAvoidBottomInset: true,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(flex: 1,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "휴대폰 번호를 입력해주세요",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20),
                  ),
                ),
                SizedBox(height: 30,),
                Row(children: [
                  Column(
                    children: [
                      Text(
                        "010",
                        style: TextStyle(
                            color: app_systemGrey1, fontSize: 20),
                      ),
                      cuteMin
                          ? SizedBox()
                          : SizedBox(
                              height: 23,
                            ),
                    ],
                  ),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          cursorColor: Colors.green,
                          decoration: InputDecoration(
                              isDense: true,
                              hintText: "1234 5678",
                              hintStyle: TextStyle(color: app_systemGrey4),
                              enabledBorder:  OutlineInputBorder(borderSide: BorderSide(color: app_systemGrey4)),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: app_systemGrey2),
                              )),
                          controller: _enterPhoneNumber,
                          validator: (number) {
                            if (number!.trim().length == 8)
                              return null;
                            else
                              return '번호를 다시 한 번 확인해주세요!';
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: CupertinoColors.secondaryLabel,
                              fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ]),
                Spacer(
                  flex: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(onPressed: () async {
                      if(platform == TargetPlatform.iOS){
                        final url = "https://sites.google.com/view/momodu-terms-system-ap/%ED%99%88";
                        if(await canLaunch(url)){
                          await launch(
                            url,forceWebView:true,
                            enableJavaScript:true,
                          );
                        }
                      }
                      else{
                        final url = "https://sites.google.com/view/momodu-terms-system-gg/%ED%99%88";
                        if(await canLaunch(url)){
                          await launch(
                            url,forceWebView:true,
                            enableJavaScript:true,
                          );
                        }
                      }
                    }, child: Text("이용 약관",style: TextStyle(color: Colors.green))),
                    Text("동의합니다"),
                    Checkbox(
                      checkColor: Colors.black,
                      activeColor: Colors.white,
                      value: _isagreed_A,
                      onChanged: (value) {
                        setState(() {
                          _isagreed_A = value!;
                        });
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () async {
                          if (platform == TargetPlatform.iOS) {
                            final url =
                                "https://sites.google.com/view/momodu-pi-ap/%ED%99%88";
                            if (await canLaunch(url)) {
                              await launch(
                                url,
                                forceWebView: true,
                                enableJavaScript: true,
                              );
                            }
                          } else {
                            final url =
                                "https://sites.google.com/view/momodu-pi-gg/%ED%99%88";
                            if (await canLaunch(url)) {
                              await launch(
                                url,
                                forceWebView: true,
                                enableJavaScript: true,
                              );
                            }
                          }
                        },
                        child: Text(
                          "개인정보 처리방침",
                          style: TextStyle(color: Colors.green),
                        )),
                    Text("동의합니다"),
                    Checkbox(
                      checkColor: Colors.black,
                      activeColor: Colors.white,
                      value: _isagreed_B,
                      onChanged: (value) {
                        setState(() {
                          _isagreed_B = value!;
                        });
                      },
                    )
                  ],
                ),
                Spacer(
                  flex: 7,
                ),
                BigButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_isagreed_A && _isagreed_B) {
                          Get.to(VerifyNumber(
                              number: "+8210" + _enterPhoneNumber.text.trim()));
                        }
                      } else {
                        cuteMin = false;
                        setState(() {});
                      }
                    },
                    btnText: "NEXT"),
                Spacer(
                  flex: 1,
                ),
              ],
            ),
          )),
    );
  }
}
