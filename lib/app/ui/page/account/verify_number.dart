import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/app_color.dart';
import 'edit_info.dart';
enum Status {Waiting,Error}

class VerifyNumber extends StatefulWidget {
  const VerifyNumber({Key? key, this.number}) : super(key: key);
  final number;
  @override
  _VerifyNumberState createState() => _VerifyNumberState(number);
}

class _VerifyNumberState extends State<VerifyNumber> {
  final phoneNumber;
  var _status = Status.Waiting;
  var _verificationId ;
  var _textEditingController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  _VerifyNumberState(this.phoneNumber);

  @override
  void initState() {
    super.initState();
    _verifyPhoneNumber();
  }

  Future _verifyPhoneNumber() async {
    _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneCuthCredentials) async {},
        verificationFailed: (verificationFailed) async {},
        codeSent: (verificationId,resendingToken) async {
          setState(() {
            this._verificationId = verificationId;
          });

        },
        codeAutoRetrievalTimeout:  (verificationId) async {}
    );
  }

  Future _sendCodeToFirebase({String? code}) async {
    if(this._verificationId != null){
      var credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: code!);

      await _auth
          .signInWithCredential(credential)
          .then((value){
            Get.offAll(() => EditInfo(uid: _auth.currentUser!.uid));
      })
          .whenComplete(() {})
          .onError((error, stackTrace) {
            setState(() {
              this._status = Status.Error;
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(flex: 2,),
          Text("로고",style: TextStyle(fontSize: 50,),),
          Spacer(flex: 1,),
          _status != Status.Error
              ? Text("전송된 6자리 코드를 입력해주세요",style: TextStyle(color: CupertinoColors.systemGrey.withOpacity(0.7),fontSize: 20),)
          :Text("코드가 올바르지 않습니다",style: TextStyle(color: Colors.redAccent,fontSize: 20),),
          TextFormField(
            cursorColor: app_red,
            decoration: InputDecoration(
              isDense: true,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: app_red),
                )
            ),
            textAlign: TextAlign.center,
            style: TextStyle(letterSpacing: 30,fontSize: 30,),
            maxLength: 6,
            controller: _textEditingController,
            keyboardType: TextInputType.number,
            autofillHints: <String>[AutofillHints.telephoneNumber],
            onChanged: (value) async {
              print(value);
              if(value.length == 6){
                _sendCodeToFirebase(code: value);
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("전화번호를 잘못 입력하셨나요?",style: TextStyle(color: CupertinoColors.systemGrey.withOpacity(0.7)),),
              MaterialButton(
                  child: Text("재입력하기"),
                  onPressed: () async {
                    setState(() {
                      Get.back();
                    });
                    _verifyPhoneNumber();
                  }
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("코드를 받지 못 하셨나요?",style: TextStyle(color: CupertinoColors.systemGrey.withOpacity(0.7)),),
              MaterialButton(
                child: Text("재전송하기"),
                onPressed: () async {
              setState(() {
              this._status = Status.Waiting;
              });
              _verifyPhoneNumber();
              }
              )
            ],
          ),
          Spacer(flex: 4,),
        ],
      ),)
    );
  }
}