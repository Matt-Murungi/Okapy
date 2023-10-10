import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:okapy/screens/home/components/drawer.dart';
import 'package:okapy/screens/utils/colors.dart';
import 'package:okapy/state/auth.dart';
import 'package:okapy/state/bookings.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class GetADriver extends StatefulWidget {
  const GetADriver({Key? key}) : super(key: key);

  @override
  State<GetADriver> createState() => _GetADriverState();
}

class _GetADriverState extends State<GetADriver> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Consumer<Bookings>(
      builder: (context, bookingsController, child) => Consumer<Auth>(
        builder: (context, authController, child) => Scaffold(
          key: _key,
          drawer: drawer(context),
          body: Stack(
            children: [
              HomePage3(),
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

class HomePage3 extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage3> {
  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 95.0;

  @override
  void initState() {
    super.initState();

    _fabHeight = _initFabHeight;
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .80;

    return Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .5,
            body: Consumer<Bookings>(
                builder: (context, bookingsController, child) {
              return _body(bookingsController);
            }),
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
    return Consumer<Bookings>(
      builder: (context, bookingsController, child) => MediaQuery.removePadding(
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
                    child: Center(
                      child: Text(
                        "Great ! Now let us get you a driver",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              const LinearProgressIndicator(
                value: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: bookingsController
                              .bookingActiveModel?.product?.productType ==
                          1
                      ? Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(71, 7, 36, 154),
                              borderRadius: BorderRadius.circular(5)),
                          child: const Icon(
                            Icons.headphones,
                            size: 30,
                            color: Color(0xff07259A),
                          ),
                        )
                      : bookingsController
                                  .bookingActiveModel?.product?.productType ==
                              2
                          ? Container(
                              // E1CAFF
                              height: 47,
                              width: 47,
                              decoration: BoxDecoration(
                                  color: const Color(0xffE1CAFF),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Image.asset(
                                  'assets/giftBox.png',
                                  height: 27,
                                ),
                              ),
                            )
                          : bookingsController.bookingActiveModel?.product
                                      ?.productType ==
                                  3
                              ? Container(
                                  // E1CAFF
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffDDF4FF),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/doc.png',
                                      height: 27,
                                    ),
                                  ),
                                )
                              : bookingsController.bookingActiveModel?.product
                                          ?.productType ==
                                      4
                                  ? Container(
                                      // E1CAFF
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffE2FFE3),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Center(
                                        child: Image.asset(
                                          'assets/package.png',
                                          height: 27,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      // E1CAFF
                                      height: 47,
                                      width: 47,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffFFECB3),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Center(
                                          child: Icon(
                                        Icons.add,
                                        size: 30,
                                      )),
                                    ),
                  title: bookingsController
                              .bookingActiveModel?.product?.productType ==
                          1
                      ? const Text('Electronics')
                      : bookingsController
                                  .bookingActiveModel?.product?.productType ==
                              2
                          ? const Text('Gift')
                          : bookingsController.bookingActiveModel?.product
                                      ?.productType ==
                                  3
                              ? const Text('Document')
                              : bookingsController.bookingActiveModel?.product
                                          ?.productType ==
                                      4
                                  ? const Text('Package')
                                  : const Text(""),
                  subtitle: Text(
                    '${bookingsController.bookingActiveModel?.booking?.formatedAddress}',
                    style: TextStyle(fontSize: 13),
                  ),
                  trailing: Text(
                    'Ksh.450',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          )),
    );
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
          decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                  blurRadius: 8.0,
                )
              ]),
        ),
        const SizedBox(
          height: 12.0,
        ),
        Text(label),
      ],
    );
  }

  Widget _body(Bookings bookings) {
    return GoogleMapsWidget(
      apiKey: "AIzaSyDwC5mBpcztehUHa3Gfjr9m8BtbNAve1LE",
      sourceLatLng: bookings.bookingActiveModel == null
          ? LatLng(0, 0)
          : bookings.bookingActiveModel!.getSenderLocation(),
      destinationLatLng: bookings.bookingActiveModel == null
          ? LatLng(0, 0)
          : bookings.bookingActiveModel!.getReceiverLocation(),
      routeWidth: 5,
      routeColor: themeColorAmber,
      destinationMarkerIconInfo: const MarkerIconInfo(
          assetPath: 'assets/flag.png', assetMarkerSize: Size.square(100)),
      sourceMarkerIconInfo: const MarkerIconInfo(
          assetPath: "assets/start.png", assetMarkerSize: Size.square(100)
          // assetMarkerSize: Size.square(12)
          ),
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
