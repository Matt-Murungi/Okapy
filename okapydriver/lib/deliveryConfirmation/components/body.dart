import 'package:flutter/material.dart';
import 'package:okapydriver/landing/dialog/RateClient.dart';
import 'package:okapydriver/state/auth.dart';
import 'package:okapydriver/state/jobs.dart';
import 'package:okapydriver/utils/color.dart';
import 'package:okapydriver/order/order.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(builder: (context, driver, child) {
      return Consumer<AvailableJobsController>(
          builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            automaticallyImplyLeading: true,
            title: Text(
              'Delivery confirmation',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 1),
                  child: SizedBox(
                    width: 326,
                    child: Text(
                      "Enter pickup code*",
                      style: TextStyle(color: themeColorGreen, fontSize: 12),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 326,
                    height: 45,
                    child: TextFormField(
                      decoration: InputDecoration(
                        // border: InputBorder()
                        prefixIcon: Icon(
                          Icons.location_on_outlined,
                          color: themeColorGreen,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 1),
                  child: SizedBox(
                    width: 326,
                    child: Text(
                      "Take a picture of the package",
                      style: TextStyle(color: themeColorGreen, fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 1, left: 20),
                        child: Image.asset(
                          'assets/addImage.png',
                          width: 152,
                        )),
                  ],
                ),
                Expanded(
                    child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      width: 326,
                      height: 49,
                      child: TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(themeColorAmber)),
                          onPressed: () {
                            controller.confirmUpdate(driver: driver);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RateClient()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Confirm delivery',
                                style: TextStyle(
                                    color: themeColorGreen, fontSize: 14),
                              ),
                              SizedBox(
                                width:
                                    (MediaQuery.of(context).size.width / 1.2) /
                                        3,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.keyboard_arrow_right,
                                        size: 25,
                                        color: themeColorGreen,
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_right,
                                        size: 25,
                                        color: themeColorGreen,
                                      ),
                                      Icon(Icons.keyboard_arrow_right,
                                          size: 25, color: themeColorGreen),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                ))
              ],
            ),
          ),
        );
      });
    });
  }
}
