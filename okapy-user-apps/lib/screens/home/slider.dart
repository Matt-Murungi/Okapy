import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:okapy/screens/createbooking/createbooking.dart';
import 'package:okapy/screens/home/components/booking_initiate.dart';
import 'package:okapy/screens/home/components/delivery_status.dart';
import 'package:okapy/screens/utils/colors.dart';
import 'package:okapy/state/auth.dart';
import 'package:okapy/state/bookings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../core/api.dart';
import '../../core/locator.dart';
import '../../main.dart';
import '../../models/active_model.dart';
import '../../models/NotificationModel.dart';
import '../../models/auth.dart';
import 'components/outgoing.dart';

class HomePage2 extends StatefulWidget {
  HomePage2({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

Api _api = locator<Api>();

class _HomePageState extends State<HomePage2> {
  final double _initFabHeight = 400.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  final double _panelHeightClosed = 180.0;
  bool hasJob = false;
  double long = 36.81365893549354;
  double lat = -1.2987047617993221;

  @override
  void initState() {
    getLocation();
    super.initState();
    // print(widget.id);
    // print(widget.id);
    // print('widget.id');
    // widget.bookingsController.getBookingDetail(id: widget.id);

    _fabHeight = _initFabHeight;
  }

  dynamic channel;

  getLocation() async {
    LocationPermission per = await Geolocator.checkPermission();

    if (per == LocationPermission.denied ||
        per == LocationPermission.deniedForever) {
      print("permission denied");
    } else {
      Position currentLoc = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      setState(() {
        long = currentLoc.longitude;
        lat = currentLoc.latitude;
      });
    }
  }

  Future<void> _showNotification(NotificationModel notificationModel) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('10001', 'Notification',
            channelDescription: 'your channel notification',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        id++, notificationModel.txt, notificationModel.txt, notificationDetails,
        payload: notificationModel.txt);
  }

  int id = 0;

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .40;

    return Scaffold(
      body: Consumer<Bookings>(
        builder: (context, bookingsController, child) => Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            SlidingUpPanel(
              maxHeight: MediaQuery.of(context).size.height * .6,
              minHeight: _panelHeightClosed,
              parallaxEnabled: true,
              parallaxOffset: .5,
              body: _body(bookingsController),
              panelBuilder: (sc) => _panel(sc, bookingsController),
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
              right: 20.0,
              bottom: _fabHeight,
              child: FloatingActionButton(
                child: Icon(
                  Icons.gps_fixed,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  getLocation();
                },
                backgroundColor: Colors.white,
              ),
            ),

            Positioned(
              top: 0,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).padding.top,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),

            //the SlidingUpPanel Title
          ],
        ),
      ),
    );
  }

  Widget _panel(ScrollController sc, Bookings bookingsController) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: sc,
          children: <Widget>[
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            const SizedBox(
              height: 18.0,
            ),
            bookingsController.activeModel == null
                ? const BookingInitiate()
                :const DeliveryStatus()
          ],
        ));
  }

  Future<ActiveModel> getAmount({required int id}) async {
    print("The id is $id");
    Response<dynamic> returnData =
        await _api.getData(endpoint: 'payments/api/order/get/amount/$id');
    print("The data is ${returnData.data}");
    return ActiveModel.fromJson(returnData.data);
  }

  Widget _body(Bookings bookings) {
    return bookings.activeBookingBusy || bookings.busy
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : bookings.activeModel != null
            ? GoogleMapsWidget(
                defaultCameraLocation: LatLng(lat ?? 0, long ?? 0),

                apiKey: "AIzaSyALabqkm7xMLci3TqKQTebkBPgh3FJ1i-s",
                sourceLatLng: LatLng(
                    bookings.activeModel != null
                        ? bookings.bookingActiveModel!.booking!.latitude!
                        : lat,
                    bookings.activeModel != null
                        ? bookings.bookingActiveModel!.booking!.longitude!
                        : long),
                destinationLatLng: LatLng(
                    bookings.activeModel != null
                        ? bookings.bookingActiveModel!.receiver!.latitude!
                        : lat,
                    bookings.activeModel != null
                        ? bookings.bookingActiveModel!.receiver!.longitude!
                        : long),
                routeWidth: 5,
                destinationMarkerIconInfo: const MarkerIconInfo(
                    assetPath: 'assets/flag.png',
                    assetMarkerSize: Size.square(100)),
                sourceMarkerIconInfo: const MarkerIconInfo(
                    assetPath: "assets/start.png",
                    assetMarkerSize: Size.square(100)
                    // assetMarkerSize: Size.square(12)
                    ),
                routeColor: themeColorAmber,
                // destinationMarkerIconInfo: const MarkerIconInfo(
                //     assetPath: 'assets/flag.png', assetMarkerSize: Size.square(100)),
                // sourceMarkerIconInfo: const MarkerIconInfo(
                //     assetPath: "assets/start.png", assetMarkerSize: Size.square(100)
                //     // assetMarkerSize: Size.square(12)
                //     ),
                updatePolylinesOnDriverLocUpdate: true,
                sourceName: "This is source name",
                driverName: "Alex",
                onTapDriverMarker: (currentLocation) {
                  print("Driver is currently at $currentLocation");
                },
                totalTimeCallback: (time) => print(time),
                totalDistanceCallback: (distance) => print(distance),
              )
            : GoogleMapsWidget(
                defaultCameraLocation: LatLng(lat, long),

                apiKey: "AIzaSyALabqkm7xMLci3TqKQTebkBPgh3FJ1i-s",
                sourceLatLng: LatLng(lat, long),
                destinationLatLng: LatLng(lat, long),
                routeWidth: 5,
                destinationMarkerIconInfo: const MarkerIconInfo(
                    assetPath: 'assets/flag.png',
                    assetMarkerSize: Size.square(100)),
                sourceMarkerIconInfo: const MarkerIconInfo(
                    assetPath: "assets/start.png",
                    assetMarkerSize: Size.square(100)
                    // assetMarkerSize: Size.square(12)
                    ),
                routeColor: themeColorAmber,
                // destinationMarkerIconInfo: const MarkerIconInfo(
                //     assetPath: 'assets/flag.png', assetMarkerSize: Size.square(100)),
                // sourceMarkerIconInfo: const MarkerIconInfo(
                //     assetPath: "assets/start.png", assetMarkerSize: Size.square(100)
                //     // assetMarkerSize: Size.square(12)
                //     ),
                updatePolylinesOnDriverLocUpdate: true,
                sourceName: "This is source name",
                driverName: "Alex",
                onTapDriverMarker: (currentLocation) {
                  print("Driver is currently at $currentLocation");
                },
                totalTimeCallback: (time) => print(time),
                totalDistanceCallback: (distance) => print(distance),
              );
  }
}
