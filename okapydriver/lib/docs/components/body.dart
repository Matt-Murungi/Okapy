import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:okapydriver/regAddVehecle/regaddVehicle.dart';
import 'package:okapydriver/state/auth.dart';
import 'package:okapydriver/state/jobs.dart';
import 'package:okapydriver/utils/color.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/authmodel.dart';
import '../../splash/splash.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  File? _doc;
  File? _doc2;
  bool busy = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<Auth>(
        builder: (context, authController, child) => Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 39.0),
              child: Text(
                'Upload your documents',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                'assets/st2.png',
                height: 31,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 1),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: Text(
                  "Upload your driving license",
                  style: TextStyle(color: themeColorGreen, fontSize: 12),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 1),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();
                        if (result != null) {
                          PlatformFile file = result.files.first;

                          setState(() {
                            _doc = File(file.path!);
                          });
                        } else {
                          // User canceled the picker
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child:_doc==null? Image.asset(
                      'assets/addImage.png',
                        width: 152,
                        height: 75,
                      ):Image.file(_doc!,width: 152,height: 75,fit: BoxFit.cover,),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 1),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: Text(
                  "Upload your Insurance",
                  style: TextStyle(color: themeColorGreen, fontSize: 12),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .7,
              child: Row(
                children: [
                  InkWell(
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['jpg', 'png'],
                          );
                      if (result != null) {
                        PlatformFile file = result.files.first;

                        setState(() {
                          _doc2 = File(file.path!);
                        });
                      } else {
                        // User canceled the picker
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child:_doc2==null? Image.asset(
                        'assets/addImage.png',
                        width: 152,
                        height: 75,
                      ):Image.file(_doc2!,width: 152,height: 75,fit: BoxFit.cover,),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: SizedBox(
                    height: 49,
                    width: 326,
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.amber)),
                        onPressed: () {
                          setState(() {
                            busy = true;
                          });
                          authController
                              .uploadDocs(lincese: _doc!, insurance: _doc2!)
                              .then((value) {

                            setState(() {
                              busy = false;
                            });
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                  const Splash(),
                                ),
                                    (route) => false);
                          }).catchError((onError) async {
                            print(onError);
                            final prefs = await SharedPreferences.getInstance();
                            AuthModel user = AuthModel.fromJson(jsonDecode(prefs.getString('token')!));
                            print("The token is ${user.key}");
                            setState(() {
                              busy = false;
                            });
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("An Error Occurred tried"),
                            ));
                          });
                        },
                        child: busy
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  SizedBox(
                                    width: 326 * .7,
                                    child: Center(
                                      child: Text(
                                        'Proceed',
                                        style: TextStyle(
                                            color: Color(0xff1A411D),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    color: Color(0xff1A411D),
                                  )
                                ],
                              ))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
