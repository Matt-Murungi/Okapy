import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:okapydriver/landing/dialog/RateClient.dart';

import 'package:okapydriver/state/auth.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../state/jobs.dart';
import '../utils/color.dart';

class ConfirmBooking extends StatefulWidget {
  const ConfirmBooking({Key? key}) : super(key: key);

  @override
  State<ConfirmBooking> createState() => _ConfirmBooking();
}

class _ConfirmBooking extends State<ConfirmBooking> {
  String? productName;
  bool others = false;
  File? _doc;
  String instructions = "";

  TextEditingController productNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    productNameController.addListener(() {
      productName = productNameController.text;
    });
  }

  @override
  void dispose() {
    productNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBarCustom('Confirm booking'),
        body: Consumer<AvailableJobsController>(
          builder: (context, bookingsController, child) => bookingsController
                  .completedbusy
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 1),
                          child: SizedBox(
                            width: 326,
                            child: Text(
                              "Enter pickup code",
                              style: TextStyle(
                                  color: themeColorGreen, fontSize: 14),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            width: 387,
                            height: 131,
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              onChanged: (value) => {
                                instructions = value,
                                print('${value.length}')
                              },
                              maxLength: 72,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 1),
                          child: SizedBox(
                            width: 326,
                            child: Text(
                              "Take a picture of the image",
                              style: TextStyle(
                                  color: themeColorGreen, fontSize: 14),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (_doc != null) ...[
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Center(
                                child: SizedBox(
                                  height: 250,
                                  child: Image.file(
                                    _doc!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      _doc = null;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                    size: 30,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ] else ...[
                          Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  final ImagePicker _picker = ImagePicker();
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            ListTile(
                                              leading: const Icon(Icons.photo),
                                              title: const Text('Photo'),
                                              onTap: () async {
                                                final XFile? image =
                                                    await _picker.pickImage(
                                                        source: ImageSource
                                                            .gallery);
                                                setState(() {
                                                  _doc = File(image!.path);
                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(Icons.camera),
                                              title: const Text('Camera'),
                                              onTap: () async {
                                                final XFile? image =
                                                    await _picker.pickImage(
                                                        source:
                                                            ImageSource.camera);

                                                setState(() {
                                                  _doc = File(image!.path);
                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Image.asset(
                                    'assets/addImage.png',
                                    width: 152,
                                    height: 75,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(
                          height: 30,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 49,
                          width: 326,
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(themeColorAmber)),
                            onPressed: () {
                              bookingsController
                                  .confirmBooking(otp: int.parse(instructions))
                                  .then((value) => {
                                        print("Confirm value is $value"),
                                        if (value)
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RateClient()),
                                            )
                                          }
                                        else
                                          {}
                                      });
                            },
                            child: bookingsController.activeBookingBusy
                                ? const CircularProgressIndicator()
                                : Row(
                                    children: [
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: Center(
                                          child: Text(
                                            'Confirm',
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
                                  ),
                          ),
                        ),
                      ]),
                ),
        ),
      ),
    );
  }
}

AppBar appBarCustom(String? title) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    actionsIconTheme: const IconThemeData(color: Colors.black),
    automaticallyImplyLeading: true,
    title: Text('$title'),
  );
}
