import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:okapydriver/core/locationPermisionInit.dart';
import 'package:okapydriver/core/locator.dart';
import 'package:okapydriver/core/providers.dart';
import 'package:okapydriver/firebase_options.dart';
import 'package:okapydriver/home/home.dart';
import 'package:okapydriver/utils/color.dart';
import 'package:okapydriver/utils/routes.dart';
import 'package:provider/provider.dart';

import 'core/api.dart';
import 'models/NotificationModel.dart';
import 'models/availableJobs.dart';

final Api _api = locator<Api>();
int id = 0;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();
const String navigationActionId = 'id_3';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "okapydriver",
    options: DefaultFirebaseOptions.currentPlatform);
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
await FirebaseAnalytics.instance;
  setupLocator();
  determinePosition();

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) {
      switch (notificationResponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          selectNotificationStream.add(notificationResponse.payload);
          break;
        case NotificationResponseType.selectedNotificationAction:
          if (notificationResponse.actionId == navigationActionId) {
            selectNotificationStream.add(notificationResponse.payload);
          }
          break;
      }
    },
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );
  // startTimer();
  runApp(MultiProvider(providers: providers, child: const MyApp()));
}

void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

final List<AvailableJobs> _availableJobs = [];

void startTimer() {
  // Timer? _timer =
  //     Timer.periodic(const Duration(seconds: 5), (Timer t) => getJobsSilent());
}

getJobsSilent() async {
  // if (SharedPrefHelpers.getIsDriverActive() == false) {
  try {
    await _api.getData(endpoint: 'payments/api/driver/orders/').then((value) {
      print("getJobsSilent data to collect is ${value.data}");

      if (value.data.length > 0) {
        if (value.data.length > _availableJobs.length) {
          NotificationModel notificationModel =
              NotificationModel("You have a new Order", "You have a new Order");
          _showNotification(notificationModel);
        }
        for (var i = 0; i < value.data.length; i++) {
          print("job is ${value.data[i]}");
          _availableJobs.add(AvailableJobs.fromJson(value.data[i]));
        }
      }
    });
  } catch (error, stacktrace) {
    print("The getJobsSilent error is $error, $stacktrace");
  }
}

const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('logo');
const DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
  requestSoundPermission: false,
  requestBadgePermission: false,
  requestAlertPermission: false,
);
const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid, iOS: initializationSettingsDarwin);

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

Future<void> _showNotification(NotificationModel notificationModel) async {
  print("The init is 2");
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    '10001',
    'Notification',
    channelDescription: 'your channel notification',
    importance: Importance.max,
    priority: Priority.high,
    sound: RawResourceAndroidNotificationSound('retrowave'),
    playSound: true,
    ticker: 'ticker',
  );
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      id++, notificationModel.txt, notificationModel.txt, notificationDetails,
      payload: notificationModel.txt);
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Okapy Driver',
      theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: themeColorAmber),
            ),
            border: const OutlineInputBorder(),
            labelStyle: TextStyle(color: themeColorAmber, fontSize: 24.0),
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: themeColorAmber,
          ),
          // primarySwatch: themeColorAmber,
          fontFamily: 'Rubik'),
      initialRoute: Home.routerName,
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
