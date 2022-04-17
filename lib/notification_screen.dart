// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:uni_meet/notification.dart';
//
// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({Key? key}) : super(key: key);
//
//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }
//
// class _NotificationScreenState extends State<NotificationScreen> {
//
//
//   Future<String?> getToken() async {
//     String? token = await FirebaseMessaging.instance.getToken();
//     print('@@@@@@@@@@@@@@@@@@$token@@@@@@@@@@@@@@@@@@');
//     return token;
//   }
//
//   String notificationTitle = 'No Title';
//
//   String notificationBody = 'No Body';
//
//   String notificationData = 'No Data';
//
//   @override
//   void initState() {
//     final firebaseMessaging = FCM();
//     firebaseMessaging.setNotifications();
//     firebaseMessaging.streamCtrl.stream.listen(_changeData);
//     firebaseMessaging.titleCtrl.stream.listen(_changeTitle);
//     firebaseMessaging.bodyCtrl.stream.listen(_changeBody);
//     super.initState();
//     Logger().d(getToken());
//
//   }
//   _changeData(String msg) => setState(()=>notificationData = msg);
//   _changeTitle(String msg) => setState(()=>notificationTitle = msg);
//   _changeBody(String msg) => setState(()=>notificationBody = msg);
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Flutter Notification Details",style: TextStyle(fontSize: 50),),
//             SizedBox(height: 30,),
//             Text("Notification Title: $notificationTitle",style: TextStyle(fontSize: 50),),
//             SizedBox(height: 30,),
//             Text("Notification Body: $notificationBody",style: TextStyle(fontSize: 50),),
//             SizedBox(height: 30,),
//           ],
//         ),
//       ),
//     );
//   }
// }
