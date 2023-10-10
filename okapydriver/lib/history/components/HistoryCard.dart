import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:okapydriver/models/BookingDetailsModel.dart';
import 'package:okapydriver/models/completed.dart';
import 'package:okapydriver/orderData/OrderData.dart';
import 'package:okapydriver/state/auth.dart';
import 'package:okapydriver/state/jobs.dart';
import 'package:okapydriver/utils/color.dart';

class HistoryCard extends StatefulWidget {
  final AvailableJobsController availableJobsController;
  final Auth auth;
  final CompletedJobs e;
  const HistoryCard(
      {super.key,
      required this.availableJobsController,
      required this.auth,
      required this.e});

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  BookingDetailsModel? _bookingDetailsModel;
  String? _distance;
  @override
  void initState() {
    // TODO: implement initState
    getBookingId();
    super.initState();
  }

  getBookingId() {
    widget.availableJobsController
        .getBookingDetailID(id: widget.e.booking!.id!)
        .then((value) {
      setState(() {
        _bookingDetailsModel = BookingDetailsModel.fromJson(value.data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _bookingDetailsModel == null
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, OrderData.routerName, arguments: {
                  'bookings': _bookingDetailsModel,
                  "completed": widget.e
                });
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
                            child: Text('${widget.e.createdAt}'),
                          )
                        ],
                      ),
                      Container(
                        height: 208,
                        padding: const EdgeInsets.all(5),
                        width: double.infinity,
                        child: GoogleMapsWidget(
                          apiKey: "AIzaSyALabqkm7xMLci3TqKQTebkBPgh3FJ1i-s",
                          sourceLatLng: LatLng(widget.e.booking!.latitude!,
                              widget.e.booking!.longitude!),
                          destinationLatLng: LatLng(
                              _bookingDetailsModel!.receiver!.latitude!,
                              _bookingDetailsModel!.receiver!.longitude!),
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
                          totalDistanceCallback: (distance) => setState(() {
                            _distance = distance;
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: ListTile(
                          title: _bookingDetailsModel!.product?.productType == 1
                              ? const Text('Electronics')
                              : _bookingDetailsModel!.product?.productType == 2
                                  ? const Text('Gift')
                                  : _bookingDetailsModel!
                                              .product?.productType ==
                                          3
                                      ? const Text('Document')
                                      : _bookingDetailsModel!
                                                  .product?.productType ==
                                              4
                                          ? const Text('Package')
                                          : Text(
                                              "${_bookingDetailsModel?.product?.productType}"),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Ksh. ${widget.e.amount}',
                                style: TextStyle(
                                    color: themeColorGreen,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '${_distance}',
                                style: TextStyle(
                                    color: themeColorGrey, fontSize: 12),
                              ),
                            ],
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
                                  padding: const EdgeInsets.only(
                                      right: 4.0, left: 4.0),
                                  child: Text(
                                    'Pickup',
                                    style: TextStyle(
                                        fontSize: 12, color: themeColorGrey),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      '${widget.e.booking?.formatedAddress}',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: themeColorGreen,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            Row(
                              children: [
                                Image.asset('assets/location-icon.png'),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 4.0, left: 4.0),
                                  child: Text(
                                    'Destination',
                                    style: TextStyle(
                                        fontSize: 12, color: themeColorGrey),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      '${_bookingDetailsModel?.receiver?.formatedAddress}',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: themeColorGreen,
                                          fontWeight: FontWeight.bold),
                                    ),
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
            ),
          );
  }
}
