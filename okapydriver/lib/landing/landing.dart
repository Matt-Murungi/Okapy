import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:geolocator/geolocator.dart';
import 'package:okapydriver/core/components/loading_indicator.dart';
import 'package:okapydriver/core/utils/logger.dart';
import 'package:okapydriver/landing/components/default.dart';
import 'package:okapydriver/landing/components/ongoing.dart';
import 'package:okapydriver/state/jobs.dart';
import 'package:okapydriver/utils/color.dart';
import 'package:okapydriver/order/order.dart';
import 'package:okapydriver/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe/swipe.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../main.dart';
import '../models/NotificationModel.dart';
import '../models/authmodel.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
  static bool isPlaying = false;
}

class _LandingState extends State<Landing> {
  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 95.0;
  bool jobState = false;
  int id = 0;

  Position? position = Position(
      longitude: 36.88982988633302,
      latitude: -1.2190815698072406,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0);
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

  dynamic channel;
  websocketSreamerInit() async {
    print('init sockets');
    final prefs = await SharedPreferences.getInstance();
    AuthModel userToken =
        AuthModel.fromJson(jsonDecode(prefs.getString('token')!));
    channel = WebSocketChannel.connect(
      Uri.parse(
          // 'ws://apidev.okapy.world:8000/chats/${widget.availableJobs.bookingsDetailsModelActive?.booking?.owner?.id}__${widget.authController.userModel?.id}/?token=${userToken.key}'),
          'ws://$baseUrl/notifications:8000/?token=${userToken.key}'),
    );

    channel.stream.listen((message) {
      print("The notifications are " + message);
      Map<String, dynamic> dataMessages = jsonDecode(message);

      if (dataMessages['type'] == 'order_notifications') {
        NotificationModel notificationModel =
            NotificationModel.fromJson(jsonDecode(message)['notification']);
        _showNotification(notificationModel);
      } else if (dataMessages['type'] == "new_message_notification") {
        NotificationModel notificationModel =
            NotificationModel.fromJson(jsonDecode(message)['message']);
        _showNotification(notificationModel);
      }
    });
    channel.sink.add(jsonEncode({
      "type": "get_notifications",
    }));
    Position posit = await getUserCurrentLocation();
    setState(() {
      position = posit;
      print("Position $position");
    });
    channel.sink.add(jsonEncode({
      "type": "add_location",
      "latitude": posit.latitude,
      "longitude": posit.longitude,
      "formated_address": "Driver"
    }));
  }

  @override
  void initState() {
    super.initState();

    _fabHeight = _initFabHeight;
    websocketSreamerInit();
  }

  Completer<GoogleMapController> _controller = Completer();

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .40;
    // bool isLoading = context.watch<AvailableJobsController>().isLoading;

    print(
        "the online is ${context.watch<AvailableJobsController>().isDriverOnline}");

    return Consumer<AvailableJobsController>(
      builder: (context, availableJobsController, child) => Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness:
                Brightness.light, //<-- For iOS SEE HERE (dark icons)
          ),
          title: availableJobsController.isLoading
              ? const LoadingIndicator()
              : Center(
                  child: FlutterSwitch(
                    value: availableJobsController.isDriverOnline,
                    activeColor: themeColorAmber,
                    activeText: 'online',
                    activeTextColor: themeColorGreen,
                    inactiveText: 'offline',
                    inactiveTextColor: Colors.white,
                    toggleColor: themeColorGreen,
                    width: MediaQuery.of(context).size.width / 2,
                    height: 47.0,
                    valueFontSize: 14.0,
                    toggleSize: 32.0,
                    borderRadius: 30.0,
                    padding: 2.0,
                    showOnOff: availableJobsController.isDriverOnline,
                    onToggle: (val) {
                      availableJobsController
                          .setDriverAvailability(val)
                          .then((value) => {
                                if (value)
                                  {
                                    availableJobsController
                                        .setIsDriverOnline(val)
                                  }
                                else
                                  {}
                              });
                    },
                  ),
                ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            SlidingUpPanel(
              maxHeight: MediaQuery.of(context).size.height * .5,
              minHeight: MediaQuery.of(context).size.height * .348,
              parallaxEnabled: true,
              parallaxOffset: .5,
              body: position == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : _body(availableJobsController, position!),
              panelBuilder: (sc) => availableJobsController.activeJobState ==
                          null ||
                      availableJobsController.availableJobs.isEmpty
                  ? Default(availableJobsController: availableJobsController)
                  : Ongoing(
                      availableJobsController: availableJobsController,
                      sc: sc,
                      context: context,
                    ),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0)),
              onPanelSlide: (double pos) => setState(() {
                _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
                    _initFabHeight;
              }),
            ),

            // the fab

            Positioned(
                top: 0,
                child: ClipRRect(
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).padding.top,
                          color: Colors.transparent,
                        )))),

            //the SlidingUpPanel Title
          ],
        ),
      ),
    );
  }
}

Widget _body(AvailableJobsController availableJobs, Position position) {
  if (availableJobs.availableJobs.isEmpty) {
    return GoogleMapsWidget(
      apiKey: googleApiKey,
      sourceLatLng: LatLng(position.latitude, position.longitude),
      destinationLatLng: LatLng(position.latitude, position.longitude),
      routeWidth: 0,
      routeColor: themeColorAmber,
      destinationMarkerIconInfo: const MarkerIconInfo(
          assetPath: 'assets/flag.png', assetMarkerSize: Size.square(100)),
      sourceMarkerIconInfo: const MarkerIconInfo(
          assetPath: "assets/start.png", assetMarkerSize: Size.square(100)
          // assetMarkerSize: Size.square(12)
          ),
      updatePolylinesOnDriverLocUpdate: true,
      totalTimeCallback: (time) => print(time),
      totalDistanceCallback: (distance) => print(distance),
    );
  }
  return Consumer<AvailableJobsController>(
    builder: (context, availableJobsController, child) =>
        availableJobsController.availableJobs.isNotEmpty
            ? availableJobsController.bookingsDetailsModelActive != null
                ? GoogleMapsWidget(
                    apiKey: googleApiKey,
                    sourceLatLng: LatLng(
                        availableJobsController
                            .bookingsDetailsModelActive!.booking!.latitude!,
                        availableJobsController
                            .bookingsDetailsModelActive!.booking!.longitude!),
                    destinationLatLng: LatLng(
                        availableJobsController
                            .bookingsDetailsModelActive!.receiver!.latitude!,
                        availableJobsController
                            .bookingsDetailsModelActive!.receiver!.longitude!),
                    routeWidth: 5,
                    routeColor: themeColorAmber,
                    destinationMarkerIconInfo: const MarkerIconInfo(
                        assetPath: 'assets/flag.png',
                        assetMarkerSize: Size.square(100)),
                    sourceMarkerIconInfo: const MarkerIconInfo(
                        assetPath: "assets/start.png",
                        assetMarkerSize: Size.square(100)
                        // assetMarkerSize: Size.square(12)
                        ),
                    updatePolylinesOnDriverLocUpdate: true,
                    totalTimeCallback: (time) => print(time),
                    totalDistanceCallback: (distance) => availableJobsController
                        .setDistance(distance: distance!),
                  )
                : SizedBox()
            : GoogleMapsWidget(
                apiKey: googleApiKey,
                routeWidth: 0,
                routeColor: themeColorAmber,
                destinationMarkerIconInfo: const MarkerIconInfo(
                    assetPath: 'assets/flag.png',
                    assetMarkerSize: Size.square(100)),
                sourceMarkerIconInfo: const MarkerIconInfo(
                    assetPath: "assets/start.png",
                    assetMarkerSize: Size.square(100)
                    // assetMarkerSize: Size.square(12)
                    ),
                updatePolylinesOnDriverLocUpdate: true,
                totalTimeCallback: (time) => print(time),
                totalDistanceCallback: (distance) => print(distance),
                sourceLatLng: LatLng(position.latitude, position.longitude),
                destinationLatLng:
                    LatLng(position.latitude, position.longitude),
              ),
  );
}
