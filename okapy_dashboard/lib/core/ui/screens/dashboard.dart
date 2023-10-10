import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:okapy_dashboard/auth/domain/auth_controller.dart';
import 'package:okapy_dashboard/core/routes/route_strings.dart';
import 'package:okapy_dashboard/core/ui/component/navigation_bar.dart';
import 'package:okapy_dashboard/core/ui/constants.dart';
import 'package:okapy_dashboard/core/utils/logger.dart';
import 'package:okapy_dashboard/order/controller/order_controller.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  final Widget child;
  const Dashboard({super.key, required this.child});

  @override
  State<Dashboard> createState() => _DashboardState();
}

Future<void> getPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  logger.d('User granted permission: ${settings.authorizationStatus}');
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    getPermission();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging
        .getToken(
            vapidKey:
                "BPdOVSwQrj8egvm9TXTc1F32bO9KFNLiw2e9ccjV8xKxsNaa4R3KDxWkJ9GibJTGrLRxTRTvdHW33FfPw7q97FU")
        .then((token) {
      if (token!.isNotEmpty) {
        logger.d("Token is $token");
        context.read<AuthController>().saveFCMToken(token: token);
      } else {
        logger.d("Empty value");
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      logger.d('Got a message whilst in the foreground!');
      logger.d('Message data: ${message.data}');
      logger.d(
          'Message also contained a notification: ${message.notification?.body}');
      context.read<OrderController>().setIsNewBookingAvailable(true);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      logger.d('Got a message whilst in the foreground!');
      logger.d('Message data: ${message.data}');
      logger.d(
          'Message also contained a notification: ${message.notification?.body}');
      context.read<OrderController>().setIsNewBookingAvailable(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Image.network(
          "https://res.cloudinary.com/dtgjkzsiz/image/upload/v1686700795/logo.png",
          scale: 7,
        ),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primaryColor,
        actions: [
          InkWell(
            onTap: () {
              context.go(profile);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                  backgroundColor: AppColors.themeColorAmberLight,
                  child: Icon(
                    Icons.person,
                    color: AppColors.primaryColor,
                  )),
            ),
          )
        ],
      ),
      body: Row(
        children: [
          const NavBar(),
          Expanded(child: widget.child),
        ],
      ),
    );
  }
}
