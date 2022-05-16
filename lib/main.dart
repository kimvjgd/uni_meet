import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:uni_meet/app/binding/init_bindings.dart';
import 'package:uni_meet/app/data/utils/timeago_util.dart';
import 'package:uni_meet/app/ui/components/app_color.dart';
import 'package:uni_meet/app/ui/page/intro.dart';
import 'package:uni_meet/app/ui/splash_screen.dart';
import 'package:uni_meet/root_page.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:yaml/yaml.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/controller/auth_controller.dart';
import 'app/data/model/firestore_keys.dart';

// Receive message when app ios in background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

int? isviewed;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');

  Logger().d(isviewed);
  TimeAgo.setLocalMessages();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}


class MyApp extends StatelessWidget {

  Future<void> getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    FirebaseFirestore.instance
        .collection(COLLECTION_USERS)
        .doc(AuthController.to.user.value.uid)
        .update({KEY_USER_TOKEN: token});
   // return token;
  }


  @override
  Widget build(BuildContext context) {

    // final appcastURL =
    //     'https://raw.githubusercontent.com/larryaasen/upgrader/master/test/testappcast.xml';
    // final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);
     getToken();
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch:Colors.green,
        scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
              color: Colors.white,
              shadowColor: Colors.white,
          ),
        dividerColor: Colors.transparent,
        bottomSheetTheme:BottomSheetThemeData(backgroundColor: Colors.transparent),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.transparent),
        iconTheme: IconThemeData(color: Colors.black),
        highlightColor: Colors.transparent,

      ),
      debugShowCheckedModeBanner: false,
      initialBinding: InitBinding(),
      home:
      isviewed !=0
          ?IntroScreen()
          :SplashScreen(),
    );
  }
}

// sudo arch -x86_64 gem install ffi 다운받고
// ios folder로 가서 arch -x86_64 pod install --repo-update
// ->platform 10.0으로 바꿔라
