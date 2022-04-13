import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        appBar: AppBar(
          title: Text("번호 인증하기"),
        ),
      body: _status != Status.Error
        ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text("OTP 인증",style: TextStyle(color: Color(0xFF08C187).withOpacity(0.7),fontSize: 30),),),
          Text("Enter OTP sent to",style: TextStyle(color: CupertinoColors.secondaryLabel,fontSize: 20),),
          Text(phoneNumber == null? "" :phoneNumber),
          TextFormField(
            textAlign: TextAlign.center,
            style: TextStyle(letterSpacing: 30,fontSize: 30,),
            maxLength: 6,
            controller: _textEditingController,
            keyboardType: TextInputType.number,
            autofillHints: <String>[AutofillHints.telephoneNumber],
            onChanged: (value) async{
              print(value);
              if(value.length == 6){
                _sendCodeToFirebase(code: value);
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("코드를 받지 못 하셨나요?"),
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
          )
        ],
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Center(child: Text("OTP 인증"),),
            Text("코드가 올바르지 않습니다"),
            MaterialButton(
              child: Text("휴대폰 번호 재입력하기"),
                onPressed: () => Navigator.pop(context)),
          MaterialButton(
              child: Text("코드 재전송하기"),
              onPressed: () async {
                setState(() {
                  this._status = Status.Waiting;
                });
                _verifyPhoneNumber();
              })
      ],)
    );
  }
}
