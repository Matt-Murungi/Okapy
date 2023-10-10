import 'dart:io';

import 'package:flutter/material.dart';

import 'package:okapy/screens/createbooking/whereuSending.dart';
import 'package:okapy/screens/home/home.dart';
import 'package:okapy/screens/utils/colors.dart';
import 'package:okapy/state/auth.dart';
import 'package:okapy/state/bookings.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class Createbooking extends StatefulWidget {
  const Createbooking({Key? key}) : super(key: key);

  @override
  State<Createbooking> createState() => _CreatebookingState();
}

class _CreatebookingState extends State<Createbooking> {
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
        appBar: appBarCustom(''),
        body: Consumer<Bookings>(
          builder: (context, bookingsController, child) => bookingsController
                  .busy
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : bookingsController.errorInitializingBooking()
                  ? Consumer<Auth>(builder: (context, authController, child) {
                      return InkWell(
                        onTap: () {
                          final data = {'owner': authController.userModel!.id};
                          bookingsController.initializeBooking(
                             data: data);
                        },
                        child: const Center(
                          child:
                              Text("Error intializing booking. Tap to retry"),
                        ),
                      );
                    })
                  : SingleChildScrollView(
                      child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/stack1.png',
                                height: 30,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'What are you sending ?',
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      productName = '1';
                                      others = false;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 47,
                                        width: 47,
                                        decoration: productName == "1"
                                            ? BoxDecoration(
                                                border: Border.all(
                                                    color: themeColorAmber))
                                            : BoxDecoration(
                                                color: const Color.fromARGB(
                                                    70, 7, 36, 154),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                        child: const Icon(
                                          Icons.headphones,
                                          size: 30,
                                          color: Color(0xff07259A),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        'Electronics',
                                        style: TextStyle(fontSize: 10),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      productName = '2';
                                      others = false;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        // E1CAFF
                                        height: 47,
                                        width: 47,
                                        decoration: productName == "2"
                                            ? BoxDecoration(
                                                border: Border.all(
                                                    color: themeColorAmber))
                                            : BoxDecoration(
                                                color: const Color(0xffE1CAFF),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                        child: Center(
                                          child: Image.asset(
                                            'assets/giftBox.png',
                                            height: 27,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        'Gift',
                                        style: TextStyle(fontSize: 10),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      productName = '3';
                                      others = false;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        // E1CAFF
                                        height: 47,
                                        width: 47,
                                        decoration: productName == "3"
                                            ? BoxDecoration(
                                                border: Border.all(
                                                    color: themeColorAmber))
                                            : BoxDecoration(
                                                color: Color(0xffDDF4FF),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                        child: Center(
                                          child: Image.asset(
                                            'assets/doc.png',
                                            height: 27,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        'Document',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      productName = '4';
                                      others = false;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        // E1CAFF
                                        height: 47,
                                        width: 47,
                                        decoration: productName == "4"
                                            ? BoxDecoration(
                                                border: Border.all(
                                                    color: themeColorAmber))
                                            : BoxDecoration(
                                                color: Color(0xffE2FFE3),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                        child: Center(
                                          child: Image.asset(
                                            'assets/package.png',
                                            height: 27,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        'Package',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      productName = '';
                                      others = true;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Container(
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
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        'Others',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            others == false
                                ? SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 1),
                                    child: SizedBox(
                                      width: 326,
                                      child: Text(
                                        "Product type",
                                        style: TextStyle(
                                            color: themeColorGreen,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                            others == false
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 326,
                                      height: 45,
                                      child: TextFormField(
                                        controller: productNameController,
                                        onSaved: (newValue) => productName,
                                        decoration: const InputDecoration(
                                            // border: InputBorder()
                                            ),
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 1),
                              child: SizedBox(
                                width: 326,
                                child: Text(
                                  "Product Image",
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
                              // SizedBox(
                              //   height: 49,
                              //   width: 326,
                              //   child: TextButton(
                              //     style: ButtonStyle(
                              //         backgroundColor:
                              //             MaterialStateProperty.all(Colors.red)),
                              //     onPressed: () {
                              //       setState(() {
                              //         _doc = null;
                              //       });
                              //     },
                              //     child: Row(
                              //       children: const [
                              //         SizedBox(
                              //           width: 50,
                              //         ),
                              //         // SizedBox(
                              //         //   width: 200,
                              //         //   child: Center(
                              //         //     child: Text(
                              //         //       'Delete',
                              //         //       style: TextStyle(
                              //         //           color: Colors.white,
                              //         //           fontSize: 14,
                              //         //           fontWeight: FontWeight.w600),
                              //         //     ),
                              //         //   ),
                              //         // ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
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
                                                  leading:
                                                      const Icon(Icons.photo),
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
                                                  leading:
                                                      const Icon(Icons.camera),
                                                  title: const Text('Camera'),
                                                  onTap: () async {
                                                    final XFile? image =
                                                        await _picker.pickImage(
                                                            source: ImageSource
                                                                .camera);

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
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
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
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 1),
                              child: SizedBox(
                                width: 326,
                                child: Text(
                                  "Instructions (Optional)",
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
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: 49,
                              width: 326,
                              child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        themeColorAmber)),
                                onPressed: () {
                                  if (_doc == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Select product image")));
                                    return;
                                  }
                                  if (productName == null ||
                                      productName == "") {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Select/enter product type")));
                                    return;
                                  }

                                  bookingsController
                                      .bookingsProduct(
                                          doc: _doc!,
                                          productID: productName!,
                                          instructions: instructions!)
                                      .then((value) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Product Created."),
                                    ));

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const WhereUSending()),
                                    );
                                  }).catchError((onError) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("An Error Happened "),
                                    ));
                                  });
                                },
                                child: bookingsController.adding_product
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
                                                'Next',
                                                style: TextStyle(
                                                    color: themeColorGreen,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, bottom: 30),
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
