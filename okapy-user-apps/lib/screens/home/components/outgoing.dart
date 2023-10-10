import 'package:flutter/material.dart';
import 'package:okapy/chat/chat.dart';
import 'package:okapy/core/ui/components/address_widget.dart';
import 'package:okapy/core/ui/components/buttons.dart';
import 'package:okapy/core/ui/constants/colors.dart';
import 'package:okapy/screens/createbooking/createbooking.dart';
import 'package:okapy/screens/outgoin/outgoing.dart';
import 'package:okapy/screens/utils/colors.dart';
import 'package:okapy/state/bookings.dart';
import 'package:okapy/state/order.dart';
import 'package:okapy/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/api.dart';
import '../../../core/locator.dart';
import '../../payment/addCard.dart';

Api _api = locator<Api>();

Consumer ongoing(BuildContext context) {
  Size size = MediaQuery.of(context).size;

  return Consumer<Bookings>(builder: (context, bookingController, child) {
    return bookingController.activeModel?.status == "5"
        ? Column(
            children: [
              const SizedBox(
                height: 18.0,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 25.0),
                    child: Center(
                      child: Text(
                        "Driver arrived,make payment to continue",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: bookingController
                              .bookingActiveModel?.product?.productType ==
                          "1"
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
                      : bookingController
                                  .bookingActiveModel?.product?.productType ==
                              "2"
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
                          : bookingController.bookingActiveModel?.product
                                      ?.productType ==
                                  "3"
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
                              : bookingController.bookingActiveModel?.product
                                          ?.productType ==
                                      "4"
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
                  title: bookingController
                              .bookingActiveModel?.product?.productType ==
                          "1"
                      ? const Text('Electronics')
                      : bookingController
                                  .bookingActiveModel?.product?.productType ==
                              "2"
                          ? const Text('Gift')
                          : bookingController.bookingActiveModel?.product
                                      ?.productType ==
                                  "3"
                              ? const Text('Document')
                              : bookingController.bookingActiveModel?.product
                                          ?.productType ==
                                      "4"
                                  ? const Text('Package')
                                  : const Text(""),
                  subtitle: Text(
                    '${bookingController.bookingActiveModel?.booking?.formatedAddress}',
                    style: TextStyle(fontSize: 13),
                  ),
                  trailing: Text(
                    'Ksh.${bookingController.activeModel!.amount!}',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              bookingController.activeModel!.amount != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: 326,
                        height: 49,
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(themeColorAmber)),
                            onPressed: () async {
                              // authController.getUser();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddCard(
                                          amount: double.parse(bookingController
                                              .activeModel!.amount!),
                                        )),
                              );
                            },
                            child: const Text(
                              'Make payment',
                              style: TextStyle(
                                  color: Color(0xff1A411D), fontSize: 14),
                            )),
                      ),
                    )
                  : SizedBox()
            ],
          )
        : Column(
            children: [
              Text(
                "Order ${bookingController.translateOrderStatus(bookingController.activeModel!.status!)}",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.themeColorGreen),
              ),
              ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "$serverUrlAssets${bookingController.activeModel!.driver!.image}"),
                  ),
                  title: Text(
                      "${bookingController.activeModel!.driver!.firstName}"),
                  subtitle: Text(
                      "${bookingController.activeModel!.driver!.lastName}"),
                  trailing: PrimaryButton(
                    text: "More info",
                    isOutlined: true,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Outgoing(
                            bookingDetailsModel:
                                bookingController.bookingsDetailsModelActive!,
                            driver:
                                bookingController.bookingsDetailsModelActive!,
                          ),
                        ),
                      );
                    },
                  )),
              AddressDetail(
                addressType: "Pickup",
                address:
                    "${bookingController.bookingsDetailsModelActive?.booking?.formatedAddress}",
                image: "assets/From.png",
              ),
              const Divider(),
              AddressDetail(
                addressType: "Destination",
                address:
                    "${bookingController.bookingsDetailsModelActive?.receiver?.formatedAddress}",
                image: "assets/location-icon.png",
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton.extended(
                        elevation: 0,
                        heroTag: 'cancel',
                        backgroundColor: Colors.transparent,
                        onPressed: () async {
                          print(
                              "On cancel id ${bookingController.bookingsDetailsModelActive?.booking?.id}");
                          await _api.patchToken(
                              url: 'payments/api/owner/order/cancel/',
                              data: {
                                "booking_id": bookingController
                                    .bookingsDetailsModelActive?.booking?.id
                              }).then((value) {
                            print("On cancel ${value.data}");
                          });
                        },
                        label: const Row(
                          children: [
                            Icon(
                              Icons.close_rounded,
                              size: 35,
                              color: Color(0xffBB1600),
                            ),
                            Text('Cancel')
                          ],
                        )),
                    FloatingActionButton.extended(
                        elevation: 0,
                        heroTag: 'chat',
                        backgroundColor: Colors.transparent,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                      driver:
                                          bookingController.activeModel?.driver,
                                      bookingDetailsModel: bookingController
                                          .bookingsDetailsModelActive!,
                                      userModel: bookingController.userModel!,
                                    )),
                          );
                        },
                        label: Row(
                          children: [
                            Icon(
                              Icons.chat_outlined,
                              size: 30,
                              color: themeColorAmber,
                            ),
                            Text(
                              'Chat',
                              style: TextStyle(
                                color: themeColorGreen,
                              ),
                            )
                          ],
                        )),
                    FloatingActionButton.extended(
                        elevation: 0,
                        heroTag: 'call',
                        backgroundColor: Colors.transparent,
                        onPressed: () async {
                          print(
                              "The phone number is ${bookingController.activeModel?.driver.toString()}");
                          var url = Uri.parse(
                              "tel:${bookingController.activeModel?.driver?.phonenumber}");

                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        label: Row(
                          children: [
                            Icon(
                              Icons.phone_outlined,
                              size: 30,
                              color: themeColorAmber,
                            ),
                            Text(
                              'Call',
                              style: TextStyle(
                                color: themeColorGreen,
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ],
          );
  });
}

Column scheduled(BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            // color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) =>  Outgoing(bookingDetailsModel: ,)),
                  // );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 25),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        // color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            "assets/1.png",
                          ),
                        )),
                  ),
                ),
              ),
              Positioned(
                right: 35,
                top: 15,
                child: Container(
                  height: 20,
                  width: 99,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                    child: Text(
                      'From walmart',
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff1A411D),
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage("assets/2.png"),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: const [
                  Text(
                    "KCB 3470K",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    "Muhu Njenga",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Row(
                children: const [
                  Icon(
                    Icons.star,
                    size: 18,
                    color: Color(0xffF2C110),
                  ),
                  Icon(
                    Icons.star,
                    size: 18,
                    color: Color(0xffF2C110),
                  ),
                  Icon(
                    Icons.star,
                    size: 18,
                    color: Color(0xffF2C110),
                  ),
                  Icon(
                    Icons.star,
                    size: 18,
                    color: Color(0xffF2C110),
                  ),
                  Icon(
                    Icons.star_half_rounded,
                    size: 18,
                    color: Color(0xffF2C110),
                  ),
                  Text(
                    '4.5',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffF2C110),
                    ),
                  )
                ],
              )
            ],
          ),
          trailing: Column(
            children: [
              Image.asset('assets/clock-icon.png'),
              const Padding(
                padding: EdgeInsets.only(top: 2.0),
                child: Text(
                  '12:30 PM',
                  style: TextStyle(fontSize: 11),
                ),
              ),
              const Text(
                '22/07/2022',
                style: TextStyle(fontSize: 11),
              )
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset('assets/From.png'),
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0, left: 4.0),
                      child: Text(
                        'Pickup',
                        style: TextStyle(fontSize: 12, color: themeColorGrey),
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
                      padding: const EdgeInsets.only(right: 4.0, left: 4.0),
                      child: Text(
                        'Destination',
                        style: TextStyle(fontSize: 12, color: themeColorGrey),
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
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton.extended(
                elevation: 0,
                heroTag: 'cancel',
                backgroundColor: Colors.transparent,
                onPressed: () {},
                label: Row(
                  children: const [
                    Icon(
                      Icons.close_rounded,
                      size: 20,
                      color: Color(0xffBB1600),
                    ),
                    Text('Cancel')
                  ],
                )),
            FloatingActionButton.extended(
                elevation: 0,
                heroTag: 'chat',
                backgroundColor: Colors.transparent,
                onPressed: () {},
                label: Row(
                  children: [
                    Icon(
                      Icons.chat_outlined,
                      size: 20,
                      color: themeColorAmber,
                    ),
                    Text(
                      'Chat',
                      style: TextStyle(
                        color: themeColorGreen,
                      ),
                    )
                  ],
                )),
            FloatingActionButton.extended(
                elevation: 0,
                heroTag: 'call',
                backgroundColor: Colors.transparent,
                onPressed: () {},
                label: Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      size: 30,
                      color: themeColorAmber,
                    ),
                    Text(
                      'Call',
                      style: TextStyle(
                        color: themeColorGreen,
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SizedBox(
          width: 326,
          height: 49,
          child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(themeColorAmber)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Createbooking()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Create bookings',
                    style: TextStyle(color: Color(0xff1A411D), fontSize: 14),
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width / 1.2) / 3,
                    child: const Center(
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        size: 25,
                        color: Color(0xff1A411D),
                      ),
                    ),
                  )
                ],
              )),
        ),
      )
    ],
  );
}
