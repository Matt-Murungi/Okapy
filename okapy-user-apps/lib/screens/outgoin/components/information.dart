import 'package:flutter/material.dart';
import 'package:okapy/models/BookingsDetailsModel.dart';
import 'package:okapy/screens/utils/colors.dart';
import 'package:okapy/state/bookings.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationTab extends StatefulWidget {
  final BookingDetailsModel? bookingActiveModel;
  final BookingDetailsModel? driver;
  const InformationTab({Key? key, this.bookingActiveModel, this.driver})
      : super(key: key);

  @override
  State<InformationTab> createState() => _InformationTabState();
}

class _InformationTabState extends State<InformationTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<Bookings>(builder: (context, controller, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListTile(
                leading: widget.bookingActiveModel?.product?.productType == 1
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
                    : widget.bookingActiveModel?.product?.productType == 2
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
                        : widget.bookingActiveModel?.product?.productType == 3
                            ? Container(
                                // E1CAFF
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: Color(0xffDDF4FF),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Image.asset(
                                    'assets/doc.png',
                                    height: 27,
                                  ),
                                ),
                              )
                            : widget.bookingActiveModel?.product?.productType ==
                                    4
                                ? Container(
                                    // E1CAFF
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: Color(0xffE2FFE3),
                                        borderRadius: BorderRadius.circular(5)),
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
                                        borderRadius: BorderRadius.circular(5)),
                                    child: const Center(
                                        child: Icon(
                                      Icons.add,
                                      size: 30,
                                    )),
                                  ),
                title: widget.bookingActiveModel?.product?.productType == 1
                    ? Text('Electronics')
                    : widget.bookingActiveModel?.product?.productType == 2
                        ? Text('Gift')
                        : widget.bookingActiveModel?.product?.productType == 3
                            ? Text('Document')
                            : widget.bookingActiveModel?.product?.productType ==
                                    4
                                ? Text('Package')
                                : Text(""),
                subtitle: Text(
                  '${widget.bookingActiveModel?.product?.instructions}',
                  style: TextStyle(
                      fontSize: 12,
                      color: themeColorGrey,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Driver Information',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 7.0),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage("assets/2.png"),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${controller.activeModel?.driver?.firstName} ",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          "${controller.activeModel?.driver?.lastName}",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: GestureDetector(
                  onTap: () async {
                    var url = Uri.parse(
                        "tel:${controller.activeModel?.driver?.phonenumber}");

                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Container(
                    height: 39,
                    width: 105,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.amber),
                      // color: const Color(0xff1A411D),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.amber,
                          size: 22,
                        ),
                        Text(
                          'Call Rider',
                          style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Pickup Location',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, top: 15),
                  child: Image.asset('assets/locationblack-icon.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Text(
                    ' ${widget.bookingActiveModel?.booking?.formatedAddress}',
                    style: TextStyle(color: themeColorGrey, fontSize: 14),
                  ),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Receiver’s Details',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 15),
                  child: Image.asset('assets/locationblack-icon.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 15),
                  child: Text(
                    '  ${widget.bookingActiveModel?.receiver?.formatedAddress}',
                    style: TextStyle(color: themeColorGrey, fontSize: 14),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 15),
                  child: Image.asset('assets/profile.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 15),
                  child: Text(
                    '${widget.bookingActiveModel?.receiver?.name}',
                    style: TextStyle(color: themeColorGrey, fontSize: 14),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 15),
                  child: Image.asset('assets/phone-icon.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 15),
                  child: Text(
                    '${widget.bookingActiveModel?.receiver?.phonenumber}',
                    style: TextStyle(color: themeColorGrey, fontSize: 14),
                  ),
                )
              ],
            ),
          ],
        );
      }),
    );
  }
}
