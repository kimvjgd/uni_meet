// import 'dart:convert';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:logger/logger.dart';
// import 'package:uni_meet/green_screen.dart';
// import 'package:uni_meet/local_notification_service.dart';
// import 'package:uni_meet/red_screen.dart';
// import 'package:http/http.dart' as http;
//
// class NotificationSecondScreen extends StatefulWidget {
//   const NotificationSecondScreen({Key? key}) : super(key: key);
//
//   @override
//   State<NotificationSecondScreen> createState() =>
//       _NotificationSecondScreenState();
// }
//
// class _NotificationSecondScreenState extends State<NotificationSecondScreen> {
//   @override
//   void initState() {
//     super.initState();
//     LocalNotificationService.initialize(context);
//
//     // gives you the message on which user taps
//     // and it opened the app from terminated state
//     FirebaseMessaging.instance.getInitialMessage().then((message) {
//       if (message != null) {
//         final routeFromMessage = message.data["routePage"];
//         Logger().d('그린 스크린');
//         Get.to(GreenScreen());
//       }
//     });
//
//     // foreground
//     FirebaseMessaging.onMessage.listen((message) {
//       if (message.notification != null) {
//         Logger().d(message.notification!.body);
//         Logger().d(message.notification!.title);
//       }
//
//       LocalNotificationService.display(message);
//     });
//
//     // background but opened and user taps
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       final routeFromMessage = message.data["routePage"];
//       Logger().d(routeFromMessage);
//       Logger().d('레드 스크린');
//       Get.to(RedScreen());
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//       child: TextButton(
//         child: Text('푸쉬알림 보내기'),
//         onPressed: () async {
//           // FirebaseMessaging.instance.sendMessage(
//           //     to: 'f2VEurxYNk99hfetHmH56Y:APA91bHMpSorCdWeHcbtPDxm3aRF3avK0t5WhNvfdx7KyujqnKlmip16uLHGErOMHCHPAG0xloojskPnde5KtCQ58MkrEynBNjoK_oGqYVeRmNu4EiXuP8wUD-OU8Aiz5iTUUilabG3j',
//           //     data: {'data': 'title'});
//           sendMessage(
//               userToken:
//                   'ezSTiD5tR9GD8IhP_zShZh:APA91bFpS6CPLnP3XY6ep6-bJybBxKBYNFzzGqH3oguJoEhAKAXMm1M334rnl4AGU7fE00149Su7CxdRWblaM8z_wLAMRUetYptxzN6uYv0Spf7_OEkwz27kTV3wy8_wTOXtxNd1wfQX',
//               title: 'asd',
//               message: 'asdfjnadkfjsd');
//         },
//       ),
//     ));
//   }
//
//   Future<StatusData> sendMessage(
//       {required String userToken,
//       required String title,
//       required String message}) async {
//     StatusData statusData = StatusData();
//     late http.Response response;
//     try {
//       response =
//           await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
//               headers: <String, String>{
//                 'Content-Type': 'application/json',
//                 'Authorization':
//                     'AAAAkC8crgM:APA91bE3-1zY7PJ826ENVSQXSMrbdXQaW4lPUQ7MoM46Ht0T9fG5n8EuqDxcGjTnbgetheSnbJLrBIuSB0wd7PawTwMECZ-JSF6tojfJV4i7Re3lXo7PFwvHoK3GvkyGV5L5Yh-GuRRl'
//               },
//               body: jsonEncode({
//                 'notification': {
//                   'title': title,
//                   'body': message,
//                   'sound': 'true'
//                 },
//                 'priority': 'high',
//                 'ttl': '60s',
//                 'data': {
//                   'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//                   'id': '1',
//                   'status': 'done',
//                 },
//                 'to': userToken
//               }));
//     } catch (e) {
//       statusData.hasError();
//       statusData.errorStack = e.toString();
//     }
//     print('statusCode : ${response.statusCode}');
//     return statusData;
//   }
// }
//
// class StatusData {
//   bool isFailed;
//   String errorStack;
//
//   StatusData({this.isFailed = false, this.errorStack = ''});
//
//   void hasError() {
//     isFailed = true;
//   }
// }
