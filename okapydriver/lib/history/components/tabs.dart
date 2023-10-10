import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:okapydriver/utils/color.dart';
import 'package:okapydriver/orderData/OrderData.dart';

Widget partnersList(BuildContext context) {
  return Column(
    children: [
      InkWell(
        onTap: () {
          Navigator.pushNamed(context, OrderData.routerName);
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset('assets/clock-icon.png'),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text('22/07/2022'),
                    )
                  ],
                ),
                Container(
                  height: 108,
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  child: GoogleMapsWidget(
                    apiKey: "AIzaSyDwC5mBpcztehUHa3Gfjr9m8BtbNAve1LE",
                    sourceLatLng:
                        const LatLng(40.484000837597925, -3.369978368282318),
                    destinationLatLng:
                        const LatLng(40.48017307700204, -3.3618026599287987),
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
                    totalDistanceCallback: (distance) => print(distance),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: ListTile(
                    title: Text('Gift'),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Ksh.450',
                          style: TextStyle(
                              color: themeColorGreen,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '2.2Km',
                          style: TextStyle(color: themeColorGrey, fontSize: 12),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      'Small size - 1.1Kg',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/From.png'),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 4.0, left: 4.0),
                            child: Text(
                              'Pickup',
                              style: TextStyle(
                                  fontSize: 12, color: themeColorGrey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Dubai',
                              style: TextStyle(
                                  color: themeColorGreen,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Image.asset('assets/location-icon.png'),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 4.0, left: 4.0),
                            child: Text(
                              'Destination',
                              style: TextStyle(
                                  fontSize: 12, color: themeColorGrey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Turkey',
                              style: TextStyle(
                                  color: themeColorGreen,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    ],
  );
}
