import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:okapydriver/utils/color.dart';

class DeliveryConfirm extends StatefulWidget {
  const DeliveryConfirm({final Key? key, required this.context,required this.onTap})
      : super(key: key);
  final BuildContext context;
  final Function()onTap;

  @override
  _DeliveryConfirm createState() => _DeliveryConfirm();
}

class _DeliveryConfirm extends State<DeliveryConfirm> {
  String email = "";
  late final XFile? photo;
  bool isUpdated=false;
  @override
  Widget build(BuildContext context) {
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.black,
        fontSize: 40,
        fontWeight: FontWeight.normal,
        fontFamily: 'Causten',
        height: 1);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Delivery confirmation',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        backgroundColor: Colors.white,
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              width: 326,
              height: 49,
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(themeColorAmber)),
                onPressed: () {
                  // setState(() {
                  //   jobState = true;
                  //   busy = true;
                  // });
                  // availableJobsController
                  //     .confirmUpdate(
                  //         driver:
                  //             authController
                  //                 .userModel!
                  //                 .id!,
                  //         state: availableJobsController
                  //                 .activeJobState! +
                  //             1)
                  //     .then((res) {
                  //   setState(() {
                  //     busy = false;
                  //   });
                  //   ScaffoldMessenger.of(
                  //           context)
                  //       .showSnackBar(
                  //           const SnackBar(
                  //     content: Text(
                  //         "Status Updated"),
                  //   ));
                  // }).catchError((onerror) {
                  //   setState(() {
                  //     busy = false;
                  //   });
                  //   print(onerror);
                  //   ScaffoldMessenger.of(
                  //           context)
                  //       .showSnackBar(
                  //           SnackBar(
                  //     content:
                  //         Text("$onerror"),
                  //   ));
                  // });
                  widget.onTap();
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .end,
                  children: [
                    Text(
                      'Confirm delivery',
                      style: TextStyle(
                          color:
                          themeColorGreen,
                          fontSize: 14),
                    ),
                    SizedBox(
                      width: (MediaQuery.of(
                          context)
                          .size
                          .width /
                          1.2) /
                          3,
                      child: Center(
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .center,
                          children: [
                            Icon(
                              Icons
                                  .keyboard_arrow_right,
                              size: 25,
                              color:
                              themeColorGreen,
                            ),
                            Icon(
                              Icons
                                  .keyboard_arrow_right,
                              size: 25,
                              color:
                              themeColorGreen,
                            ),
                            Icon(
                                Icons
                                    .keyboard_arrow_right,
                                size:
                                25,
                                color:
                                themeColorGreen),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 1, left: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                child: Text(
                  "Enter pickup code",
                  style: TextStyle(color: themeColorGreen, fontSize: 15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 5,right: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                height: 45,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (newValue) => email = newValue!,
                  // initialValue: authController.userModel!.email!,
                  decoration: InputDecoration(
                      // hintText: authController.userModel!.email!,
                      // border: InputBorder()
                      prefixIcon: Icon(
                    Icons.location_on,
                    color: themeColorGreen,
                  )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 1),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        final ImagePicker _picker = ImagePicker();
                         photo = await _picker.pickImage(source: ImageSource.camera);
                         setState(() {
                           isUpdated=true;
                         });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child:!isUpdated? Image.asset(
                          'assets/addImage.png',
                          width: 152,
                          height: 75,
                        ):Image.file(
                          File(photo!.path),
                          fit: BoxFit.contain,
                          width: 152,
                          height: 75,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ));
  }
}
