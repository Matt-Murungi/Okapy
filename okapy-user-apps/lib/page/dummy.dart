import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:okapy/page/components/tabs.dart';
import 'package:okapy/screens/home/tabs.dart';
import 'package:okapy/screens/utils/colors.dart';
import 'package:okapy/state/bookings.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/services.dart';

import 'package:cached_network_image/cached_network_image.dart';

class HomePageDummy extends StatefulWidget {
  final Bookings bookingsController;

  const HomePageDummy({Key? key, required this.bookingsController})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageDummy> {
  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 95.0;

  @override
  void initState() {
    super.initState();

    _fabHeight = _initFabHeight;
  }

  String time = "";

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .80;

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .5,
            body: _body(),
            panelBuilder: (sc) => _panel(sc),
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
              onPressed: () {},
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
                      )))),

          //the SlidingUpPanel Title
        ],
      ),
    );
  }

  Widget _panel(ScrollController sc) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Text(
                    "Bookings",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            const HomeTabsDumy()
          ],
        ));
  }

  Widget _button(String label, IconData icon, Color color) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            icon,
            color: Colors.white,
          ),
          decoration:
              BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              blurRadius: 8.0,
            )
          ]),
        ),
        SizedBox(
          height: 12.0,
        ),
        Text(label),
      ],
    );
  }

  Widget _body() {
    return GoogleMapsWidget(
      apiKey: "AIzaSyDwC5mBpcztehUHa3Gfjr9m8BtbNAve1LE",
      sourceLatLng: const LatLng(-1.3032051, 36.7073091),
      destinationLatLng: const LatLng(-4.0351857, 39.5962223),
      routeWidth: 5,
      routeColor: themeColorAmber,
      sourceMarkerIconInfo: const MarkerIconInfo(
          assetPath: 'assets/flag.png', assetMarkerSize: Size.square(100)),
      destinationMarkerIconInfo: const MarkerIconInfo(
        assetPath: "assets/start.png", assetMarkerSize: Size.square(100),

        // assetMarkerSize: Size.square(12)
      ),
      updatePolylinesOnDriverLocUpdate: true,
      sourceName: "This is source name",
      driverName: "Alex",
      // destinationName: time,

      onTapDriverMarker: (currentLocation) {
        print("Driver is currently at $currentLocation");
      },
      totalTimeCallback: (times) {
        print(times);
        setState(() {
          time = times!;
        });
      },
      totalDistanceCallback: (distance) => print(distance),
    );
  }
}
