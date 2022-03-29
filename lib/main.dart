import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/binding/init_bindings.dart';
import 'package:uni_meet/root_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialBinding: InitBinding(),
    home: RootPage(),));
}

// sudo arch -x86_64 gem install ffi 다운받고
// ios folder로 가서 arch -x86_64 pod install --repo-update
// ->platform 10.0으로 바꿔라
