// import 'dart:io';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// class FirebasePushNotificationService {
//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
//   Future initialize() {
//     if (Platform.isIOS) {
//       _fcm.requestPermission(IosNotificationSettings());
//     }
//     _fcm.pluginConstants(
//       onMessage: (Map<String, dynamic> message) async {
//         print("onMessage: $message");
//         // _showItemDialog(message);
//       },
//       onLaunch: (Map<String, dynamic> message) async {
//         print("onLaunch: $message");
//         // _navigateToItemDetail(message);
//       },
//       onResume: (Map<String, dynamic> message) async {
//         print("onResume: $message");
//         // _navigateToItemDetail(message);
//       },
//     );
//   }
// }