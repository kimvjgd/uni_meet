import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:uni_meet/app/ui/page/account/verify_number.dart';

class EditNumber extends StatefulWidget {
  const EditNumber({Key? key}) : super(key: key);

  @override
  _EditNumberState createState() => _EditNumberState();
}

class _EditNumberState extends State<EditNumber> {
  var _enterPhoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("회원가입"),),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("코드를 전송받을 휴대폰 번호를\n 입력해주세요",style: TextStyle(color: CupertinoColors.systemGrey.withOpacity(0.7),fontSize: 20),),
            Row(
              children: [
                Text("010",style: TextStyle(color: CupertinoColors.secondaryLabel,fontSize: 25),),
                Expanded(
                  child: TextField(
                    controller: _enterPhoneNumber,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: CupertinoColors.secondaryLabel,fontSize: 25),
                  ),
                ),]),
            Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: ElevatedButton(
                      child: Text("코드 전송하기"),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder:(_) => VerifyNumber(number: "+8210"+_enterPhoneNumber.text,),
                        ));
                      }
                  ),
                )
            ],),
      )
    );
  }
}
