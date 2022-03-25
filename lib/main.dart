import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uni_meet/screen/AuthImage_screen.dart';
import 'package:uni_meet/screen/PersonalInfo.dart';
import 'package:uni_meet/screen/Profile_set.dart';
import 'package:uni_meet/screen/phone_number_screen.dart';
import 'package:uni_meet/screen/temp_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AuthInfoScreen(),));
}

// sudo arch -x86_64 gem install ffi 다운받고
// ios folder로 가서 arch -x86_64 pod install --repo-update
// ->platform 10.0으로 바꿔라

