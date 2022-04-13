import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/data/model/app_user_model.dart';
import 'package:uni_meet/root_page.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: TextButton(child: Text('Log Out'),
        onPressed: signOut,
        ),
      ),
    );
  }


  // TextButton(child: Text('Log Out'),
  // onPressed: signOut,
  // )

  Future<void> signOut() async {
    AuthController.to.signOut();
    await auth.signOut();
    Get.to(()=>RootPage());
  }
}
