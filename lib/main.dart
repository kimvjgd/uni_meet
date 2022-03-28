import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/binding/init_bindings.dart';
import 'package:uni_meet/screen/AuthImage_screen.dart';
import 'package:uni_meet/screen/PersonalInfo.dart';
import 'package:uni_meet/screen/Profile_set.dart';
import 'package:uni_meet/screen/University_check.dart';
import 'package:uni_meet/screen/phone_number_screen.dart';
import 'package:uni_meet/screen/temp_screen.dart';
import 'package:uni_meet/screen/widget/mbti_selection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialBinding: InitBinding(),
    home: mbtiSelector(),));
}

// sudo arch -x86_64 gem install ffi 다운받고
// ios folder로 가서 arch -x86_64 pod install --repo-update
// ->platform 10.0으로 바꿔라

