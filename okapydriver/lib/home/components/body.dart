import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:okapydriver/core/streamer.dart';
import 'package:okapydriver/core/utils/logger.dart';
import 'package:okapydriver/models/driverProfile.dart';
import 'package:okapydriver/splash/splachHome.dart';
import 'package:okapydriver/state/auth.dart';
import 'package:okapydriver/state/jobs.dart';
import 'package:okapydriver/utils/color.dart';
import 'package:okapydriver/history/history.dart';
import 'package:okapydriver/landing/landing.dart';

import 'package:okapydriver/myearnings/myearnings.dart';
import 'package:okapydriver/settings/settings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/api.dart';
import '../../core/locator.dart';
import '../../login/login.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final Api _api = locator<Api>();
  final WebsocketSreamer _websocketSreamer = WebsocketSreamer();

  late FirebaseMessaging messaging;

  _getPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    logger.i("User granted permission: ${settings.authorizationStatus}");
  }

  @override
  void initState() {
    // TODO: implement initState
    _websocketSreamer.websocketSreamerInit();

    setUpAuth();
    messaging = FirebaseMessaging.instance;
    _getPermission();
    context.read<AvailableJobsController>().getDriverAvailability();
    messaging
        .getToken()
        .then((token) => context.read<Auth>().saveFCMToken(token: token!));
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      context.read<AvailableJobsController>().getJobs();
      logger.d("Firebase message received");
    });
    super.initState();
  }

  Future<bool> setUpAuth() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('creds') == null) {
      ('noUser');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const Login(),
          ),
          (route) => false);
      return false;
    } else {
      return true;
    }
  }

  int _selectedIndex = 0;
  bool state = false;
  static const List<Widget> _widgetOptions = <Widget>[
    Landing(),
    History(),
    MyEarnings(),
    Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<ProfileDriver?> getProfileFuture() async {
    ProfileDriver? returnData;
    await _api.getData(endpoint: 'users/api/user/profile/').then((value) {
      returnData = ProfileDriver.fromJson(value.data);
    }).catchError((onError) {
    });
    return returnData;
  }

  // String svgHome =  svgHome;
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getProfileFuture(),
      builder: (context, snapshot) {
        print("The snapshot is ${snapshot.data}");
        return snapshot.hasData
            ? (snapshot.data as ProfileDriver).isApproved == false
                ? const SplashHome()
                : Scaffold(
                    body: Center(
                      child: _widgetOptions.elementAt(_selectedIndex),
                    ),
                    bottomNavigationBar: BottomNavigationBar(
                        items: const <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                              icon: Icon(CupertinoIcons.home),
                              label: 'Home',
                              backgroundColor: Colors.white),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.access_time_rounded),
                              label: 'History',
                              backgroundColor: Colors.white),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.bar_chart),
                              label: 'Earnings',
                              backgroundColor: Colors.white),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.settings_outlined),
                            label: 'Settings',
                            backgroundColor: Colors.white,
                          ),
                        ],
                        type: BottomNavigationBarType.fixed,
                        currentIndex: _selectedIndex,
                        selectedItemColor: themeColorAmber,
                        unselectedItemColor: themeColorGrey,
                        backgroundColor: Colors.white,
                        iconSize: 25,
                        onTap: _onItemTapped,
                        elevation: 5),
                  )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    ));
  }
}
