// import 'dart:async';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// Future<void> onBackgroundMessage(RemoteMessage message) async {
//   await Firebase.initializeApp();
//
//   if (message.data.containsKey('data')) {
//     // Handle data message
//     final data = message.data['data'];
//   }
//   if (message.data.containsKey('notification')) {
//     // Handle notification message
//     final notification = message.data['notification'];
//   }
//
//   // Or do other work
// }
//
// class FCM {
//   final _firebaseMessaging = FirebaseMessaging.instance;
//   final streamCtrl = StreamController<String>.broadcast();
//   final titleCtrl = StreamController<String>.broadcast();
//   final bodyCtrl = StreamController<String>.broadcast();
//
//   setNotifications() {
//     FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
//
//     // Handle when app is in active state
//     foregroundNotification();
//
//     // Handle when app is running in background state
//     backgroundNotification();
//
//     // Handle when app is close by user or terminated
//     terminateNotification();
//     final totken = _firebaseMessaging.getToken().then((value)=>print('Token: $value'));
//   }
//
//   foregroundNotification() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       if (message.data.containsKey('data')) {
//         // Handle data message
//         streamCtrl.sink.add(message.data['data']);
//       }
//       if (message.data.containsKey('notification')) {
//         // Handle notification
//         streamCtrl.sink.add(message.data['notificaiton']);
//       }
//       // Or do other work
//       titleCtrl.sink.add(message.notification!.title!);
//       bodyCtrl.sink.add(message.notification!.body!);
//     });
//   }
//
//   backgroundNotification() {
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       if (message.data.containsKey('data')) {
//         // Handle data message
//         streamCtrl.sink.add(message.data['data']);
//       }
//       if (message.data.containsKey('notification')) {
//         // Handle notification
//         streamCtrl.sink.add(message.data['notificaiton']);
//       }
//       titleCtrl.sink.add(message.notification!.title!);
//       bodyCtrl.sink.add(message.notification!.body!);
//     });
//   }
//
//   terminateNotification() async {
//     RemoteMessage? initialMessage = await FirebaseMessaging.instance
//         .getInitialMessage();
//     if (initialMessage != null) {
//       if (initialMessage.data.containsKey('data')) {
//         // Handle data message
//         streamCtrl.sink.add(initialMessage.data['data']);
//       }
//       if (initialMessage.data.containsKey('notification')) {
//         // Handle notification
//         streamCtrl.sink.add(initialMessage.data['notificaiton']);
//       }
//       titleCtrl.sink.add(initialMessage.notification!.title!);
//       bodyCtrl.sink.add(initialMessage.notification!.body!);
//     }
//   }
//   dispose(){
//     streamCtrl.close();
//     titleCtrl.close();
//     bodyCtrl.close();
//   }
// }