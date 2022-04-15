import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:uni_meet/app/binding/init_bindings.dart';
import 'package:uni_meet/local_notification_service.dart';
import 'package:uni_meet/notification.dart';
import 'package:uni_meet/notification_screen.dart';
import 'package:uni_meet/notification_second_screen.dart';
import 'package:uni_meet/root_page.dart';

import 'app/ui/components/app_color.dart';


// Receive message when app ios in background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  Future<String?> getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print('@@@@@@@@@@@@@@@@@@$token@@@@@@@@@@@@@@@@@@');
    return token;
  }
  @override
  Widget build(BuildContext context) {
    getToken();
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
              color: Colors.white,
              shadowColor: Colors.white,
          ),
        dividerColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      initialBinding: InitBinding(),
      // home: RootPage(),
      home: RootPage(),
    );
  }
}

// sudo arch -x86_64 gem install ffi 다운받고
// ios folder로 가서 arch -x86_64 pod install --repo-update
// ->platform 10.0으로 바꿔라
