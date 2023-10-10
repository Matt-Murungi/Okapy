import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseFCM {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  getFCMToken() async {
    return await messaging.getToken();
  }

  listenForMessage() {
    return FirebaseMessaging.onMessage.listen((event) {
      print("fcm message title  ${event.notification?.title}");
      print("fcm message body ${event.notification?.body}");
      print("fcm message android  ${event.notification?.android}");
    });
  }
}
