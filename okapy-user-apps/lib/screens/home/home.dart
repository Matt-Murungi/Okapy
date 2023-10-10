import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:okapy/core/utils/logger.dart';
import 'package:okapy/screens/home/components/drawer.dart';
import 'package:okapy/screens/home/slider.dart';
import 'package:okapy/state/auth.dart';
import 'package:okapy/state/bookings.dart';
import 'package:okapy/state/order.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Position? position;
  Future<void> _isAndroidPermissionGranted() async {
    final bool granted = await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.areNotificationsEnabled() ??
        false;

    setState(() {
      _notificationsEnabled = granted;
    });
  }

  Future<void> _requestPermissions() async {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    final bool? granted = await androidImplementation?.requestPermission();
    setState(() {
      _notificationsEnabled = granted ?? false;
    });
  }

  late bool _notificationsEnabled = false;
  late FirebaseMessaging messaging;
  @override
  void initState() {
    super.initState();
    logger.d("home initState called");

    context.read<Auth>().getUserCurrentLocation().then((value) {
      logger.d(value.latitude.toString() + " " + value.longitude.toString());
      context.read<Bookings>().setCurrentLatLng(value);
      // marker added for current users location
      // specified current users locatio
      setState(() {
        position = value;
      });
    });
    _isAndroidPermissionGranted();
  _requestPermissions();
    var booking = context.read<Bookings>();
    var auth = context.read<Auth>();

    // counter.initBookings();

    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) => auth.saveFCMToken(token: value!));

    FirebaseMessaging.onMessage.listen((event) {

      booking.getOrder(id: booking.activeModel!.id!);
    });
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, authController, child) => Consumer<Bookings>(
        builder: (context, bookingsController, child) => Scaffold(
          key: _key,
          drawer: drawer(context),
          body: Stack(
            children: [
              HomePage2(),
              // maps(context),
              Positioned(
                top: 30,
                left: 15,
                child: InkWell(
                  onTap: () {
                    _key.currentState!.openDrawer();
                  },
                  child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.menu,
                        size: 30,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
