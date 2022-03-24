import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {

  TextEditingController phoneController = TextEditingController();
  TextEditingController otpCodeController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  String verificaitonIdReceived = "";

  bool otpCodeVisible = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Auth'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Phone"),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              visible: otpCodeVisible,
              child: TextField(
                controller: otpCodeController,
                decoration: const InputDecoration(labelText: "Code"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: () {
              if(otpCodeVisible){
                verifyCode();
              }
              verifyNumber();
            }, child: Text(otpCodeVisible ? "Login": "Verify"))
          ],
        ),
      ),
    );
  }

  void verifyNumber() {
    auth.verifyPhoneNumber(phoneNumber: phoneController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((Value){
            print("You are logged in successfully");
          });
        },
        verificationFailed: (FirebaseAuthException exception){
          print(exception.message);
        },
        codeSent: (String verificationId, int? resendToken){
          verificaitonIdReceived = verificationId;
          setState(() {
            otpCodeVisible = true;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId){

        });
  }

  void verifyCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificaitonIdReceived, smsCode: otpCodeController.text);
    await auth.signInWithCredential(credential).then((value) => print("You are logged in successfully"));
  }
}
