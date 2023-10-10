import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:okapy/screens/createbooking/sendPackage.dart';
import 'package:okapy/screens/utils/colors.dart';
import 'package:okapy/state/auth.dart';
import 'package:okapy/state/bookings.dart';
import 'package:place_picker/place_picker.dart';
import 'package:provider/provider.dart';

import '../home/home.dart';

const kGoogleApiKey = "AIzaSyDwC5mBpcztehUHa3Gfjr9m8BtbNAve1LE";

class WhereUSending extends StatefulWidget {
  const WhereUSending({Key? key}) : super(key: key);

  @override
  State<WhereUSending> createState() => _WhereUSendingState();
}

class _WhereUSendingState extends State<WhereUSending> {
  String? senderLocation;
  String? receiverLocation;
  String? name;
  String? phone;
  bool active = false;

  final TextEditingController phoneNumberController = TextEditingController();
  String initialCountry = 'KE';
  PhoneNumber number = PhoneNumber(isoCode: 'KE');

  TextEditingController senderLoc = TextEditingController();
  TextEditingController receiverLoc = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool busy = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<Bookings>(
      builder: (context, bookingController, child) => Consumer<Auth>(
        builder: (context, authcontroller, child) => WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
            ),
            backgroundColor: Colors.white,
            body: Consumer<Bookings>(
              builder: (context, bookingController, child) =>
                  SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/stepper2.png',
                          height: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Where are you sending ?',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      bookingController.bookingsModel!.latitude != null
                          ? const SizedBox.shrink()
                          : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 1),
                                  child: SizedBox(
                                    width: 326,
                                    child: Text(
                                      "Sender’s Location",
                                      style: TextStyle(
                                          color: themeColorGreen, fontSize: 14),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    child: GooglePlaceAutoCompleteTextField(
                                        textEditingController: senderLoc,
                                        googleAPIKey:
                                            "AIzaSyALabqkm7xMLci3TqKQTebkBPgh3FJ1i-s",
                                        inputDecoration: InputDecoration(
                                          hintText:
                                              'Tap to select sender location',
                                          prefixIcon: Icon(
                                            Icons.location_on_outlined,
                                            color: themeColorGreen,
                                          ),
                                        ),
                                        debounceTime: 800,
                                        isLatLngRequired:
                                            true, // if you required coordinates from place detail
                                        getPlaceDetailWithLatLng:
                                            (Prediction prediction) {
                                          // this method will return latlng with place detail
                                          print("placeDetails " +
                                              prediction.lat.toString());
                                          senderLoc.text =
                                              prediction.description!;
                                          senderLoc.selection =
                                              TextSelection.fromPosition(
                                                  TextPosition(
                                                      offset: prediction
                                                          .description!
                                                          .length));
                                          // print("placeDetails " + prediction.lat.toString());
                                          bookingController
                                              .setSenderLocation(prediction);
                                        }, // this callback is called when isLatLngRequired is true
                                        itmClick: (Prediction prediction) {}),
                                    width: 326,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 48.0),
                                      child: Image.asset(
                                        'assets/d.png',
                                        height: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 1),
                        child: SizedBox(
                          width: 326,
                          child: Text(
                            "Receiver’s Details",
                            style:
                                TextStyle(color: themeColorGreen, fontSize: 14),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: GooglePlaceAutoCompleteTextField(
                              textEditingController: receiverLoc,
                              googleAPIKey:
                                  "AIzaSyALabqkm7xMLci3TqKQTebkBPgh3FJ1i-s",
                              inputDecoration: InputDecoration(
                                hintText: 'Tap to select receiver location',
                                prefixIcon: Icon(
                                  Icons.location_on_outlined,
                                  color: themeColorGreen,
                                ),
                              ),
                              debounceTime: 800,
                              isLatLngRequired:
                                  true, // if you required coordinates from place detail
                              getPlaceDetailWithLatLng:
                                  (Prediction prediction) {
                                // this method will return latlng with place detail
                                print(
                                    "placeDetails" + prediction.lng.toString());
                                receiverLoc.text = prediction.description!;
                                receiverLoc.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset:
                                            prediction.description!.length));
                                bookingController
                                    .setReceiversLocation(prediction);
                              }, // this callback is called when isLatLngRequired is true
                              itmClick: (Prediction prediction) {}),
                          width: 326,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: 326,
                          height: 45,
                          child: TextFormField(
                            onSaved: (newValue) => name = newValue,
                            decoration: InputDecoration(
                                hintText: "Receiver's Name",
                                // border: InputBorder()
                                prefixIcon: Image.asset('assets/userIcon.png')),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          width: 326,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.amber)),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: InternationalPhoneNumberInput(
                              onInputChanged: (PhoneNumber number) {
                                print("Number is ${number.phoneNumber}");
                                phone = number.phoneNumber;
                                if (phone == null) {
                                  setState(() {
                                    active = false;
                                  });
                                } else {
                                  if (phone!.isEmpty) {
                                    setState(() {
                                      active = false;
                                    });
                                  } else {
                                    if (phone!.length == 13) {
                                      setState(() {
                                        active = true;
                                      });
                                    } else {
                                      setState(() {
                                        active = false;
                                      });
                                    }
                                  }
                                }
                              },
                              onInputValidated: (bool value) {
                                print(value);
                                return null;
                              },
                              textAlignVertical: TextAlignVertical.top,
                              selectorConfig: const SelectorConfig(
                                selectorType:
                                    PhoneInputSelectorType.BOTTOM_SHEET,
                              ),
                              ignoreBlank: false,
                              // inputDecoration: ,
                              autoValidateMode: AutovalidateMode.disabled,
                              selectorTextStyle:
                                  const TextStyle(color: Colors.black),
                              initialValue: number,
                              textFieldController: phoneNumberController,
                              formatInput: false,
                              spaceBetweenSelectorAndTextField: 0,
                              selectorButtonOnErrorPadding: 0,
                              inputDecoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Receiver PhoneNumber',
                                  disabledBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              inputBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),

                              onSaved: (PhoneNumber number) {
                                print('On Saved: $number');
                                phone = number.phoneNumber;
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      SizedBox(
                          height: 49,
                          width: 326,
                          child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      themeColorAmber)),
                              onPressed: () {
                                _formKey.currentState!.save();

                                if (receiverLoc.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Set receiver location")));
                                  return;
                                }

                                if (senderLoc.text.isEmpty &&
                                    bookingController.bookingsModel!.latitude ==
                                        null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Set sender location")));
                                  return;
                                }

                                if (name == null || name == "") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Set name")));
                                  return;
                                }

                                if (phone == null || phone == "") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Set phone")));
                                  return;
                                }
                                setState(() {
                                  busy = true;
                                });
                                bookingController
                                    .setReceiverDetails(
                                        receiverLoc: receiverLoc.text,
                                        senderLocation: senderLoc.text,
                                        name: name!,
                                        phone: phone!)
                                    .then((value) {
                                  print("The receiver details are $value");

                                  if (value) {
                                    if (bookingController
                                            .bookingsModel!.latitude !=
                                        null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SendPackage()),
                                      );
                                    } else {
                                      bookingController
                                          .patchSender(
                                              authId:
                                                  authcontroller.userModel!.id!)
                                          .then((value) => {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content: Text(
                                                      "Receiver Details Recorded Successfully."),
                                                )),
                                                setState(() {
                                                  busy = false;
                                                }),
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const SendPackage()),
                                                )
                                              })
                                          .catchError((value) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "An Error Happened Try again Later !.$value"),
                                        ));
                                        setState(() {
                                          busy = false;
                                        });
                                      });
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "An Error Happened Try again Later !.$value"),
                                    ));
                                  }
                                }).catchError((value) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        "An Error Happened Try again Later !.$value"),
                                  ));
                                  setState(() {
                                    busy = false;
                                  });
                                });
                              },
                              child: busy
                                  ? const Center(
                                      child: CircularProgressIndicator(
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
                                                  color: themeColorGreen,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: themeColorGreen,
                                        )
                                      ],
                                    ))),
                      Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: GestureDetector(
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600),
                            ),
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const Home(),
                                  ),
                                  (route) => false);
                            },
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showPlacePicker() async {
    LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PlacePicker("AIzaSyDwC5mBpcztehUHa3Gfjr9m8BtbNAve1LE")));

    // Handle the result in your way
    print(result);
  }
}
