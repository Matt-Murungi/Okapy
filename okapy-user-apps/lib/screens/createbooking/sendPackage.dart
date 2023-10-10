import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:okapy/models/VehicleModel.dart';
import 'package:okapy/screens/createbooking/confirmbooking.dart';
import 'package:okapy/screens/createbooking/createbooking.dart';
import 'package:okapy/screens/utils/colors.dart';
import 'package:okapy/state/auth.dart';
import 'package:okapy/state/bookings.dart';
import 'package:provider/provider.dart';

import '../../core/api.dart';
import '../../core/locator.dart';

class SendPackage extends StatefulWidget {
  const SendPackage({Key? key}) : super(key: key);

  @override
  State<SendPackage> createState() => _SendPackageState();
}

class _SendPackageState extends State<SendPackage> {
  String? active;
  double? price;
  bool busy = false;
  final Api _api = locator<Api>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getBankingDetails(int id) async {
    await _api
        .getData(endpoint: 'payments/api/order/get/amount/$id/')
        .then((value) {
      print("The banking details are ${value}");
      Map<String, dynamic> bankingDetails = jsonDecode(value.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarCustom(''),
      body: Consumer<Bookings>(
        builder: (context, bookingsController, child) => bookingsController
                    .bookingsModel ==
                null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : FutureBuilder<List<VehicleModel>>(
                future: bookingsController.getBookingPrices(bookingsController),
                builder: (context, snapshot) {
                  print("Snapshot data is ${snapshot.data}");
                  print("Snapshot data is ${snapshot.error}");
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/stepper3.png',
                                height: 30,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Delivery',
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ...snapshot.data!
                                .map((e) => Padding(
                                      padding: EdgeInsets.only(top: 30),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            active = e.name;
                                            price = e.value;
                                          });
                                        },
                                        child: SizedBox(
                                          height: 70,
                                          child: Container(
                                            color: active == e.name
                                                ? themeColorAmber
                                                    .withOpacity(.2)
                                                : Colors.transparent,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .4,
                                                  child: Row(
                                                    children: [
                                                      if (e.name ==
                                                              'Motorbike' ||
                                                          e.name ==
                                                              'Motorcycle') ...[
                                                        Image.asset(
                                                          'assets/motorcycle.png',
                                                          height: 49,
                                                          width: 49,
                                                        )
                                                      ] else if (e.name ==
                                                          'Car') ...[
                                                        Image.asset(
                                                          'assets/vehicle.png',
                                                          height: 49,
                                                          width: 49,
                                                        )
                                                      ] else if (e.name ==
                                                          'Van') ...[
                                                        Image.asset(
                                                          'assets/van.png',
                                                          height: 49,
                                                          width: 49,
                                                        )
                                                      ] else ...[
                                                        Image.asset(
                                                          'assets/truck.png',
                                                          height: 49,
                                                          width: 49,
                                                        )
                                                      ],
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 18.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              e.name ==
                                                                      "Motorcycle"
                                                                  ? "Motorbike"
                                                                  : e.name!,
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            Text(
                                                              '',
                                                              style: TextStyle(
                                                                  fontSize: 11,
                                                                  color:
                                                                      themeColorGrey),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  '${e.value?.toInt()} KSH',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                            const SizedBox(
                              height: 60,
                            ),
                            Consumer<Auth>(
                              builder: (context, authController, child) =>
                                  SizedBox(
                                      height: 49,
                                      width: 326,
                                      child: TextButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      themeColorAmber)),
                                          onPressed: () {
                                            if (active == null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content:
                                                      Text("Select vehicle"),
                                                ),
                                              );
                                              return;
                                            }
                                            setState(() {
                                              busy = true;
                                            });
                                            bookingsController
                                                .setVehiclePrice(price!);
                                            bookingsController
                                                .patchVehicle(
                                                    vehivleId: active == "Truck"
                                                        ? 4
                                                        : active == "Van"
                                                            ? 3
                                                            : active == "Car"
                                                                ? 2
                                                                : 1,
                                                    authId: authController
                                                        .userModel!.id!)
                                                .then((value) async {
                                              setState(() {
                                                busy = false;
                                              });

                                              bool result =
                                                  await bookingsController
                                                      .getBookingDetails();
                                              print("booking result $result");
                                              if (result) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ConfirmBooking()),
                                                );
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            "Error getting booking details")));
                                              }
                                            }).catchError((onError, stack) {
                                              print("Error is $onError $stack");
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "An Error Happened Try again Later !."),
                                              ));
                                              setState(() {
                                                busy = false;
                                              });
                                            });
                                          },
                                          child: busy
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 50,
                                                    ),
                                                    SizedBox(
                                                      width: 200,
                                                      child: Center(
                                                        child: Text(
                                                          'Next',
                                                          style: TextStyle(
                                                              color:
                                                                  themeColorGreen,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: themeColorGreen,
                                                    )
                                                  ],
                                                ))),
                            ),
                            const SizedBox(
                              height: 60,
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
      ),
    );
  }
}
