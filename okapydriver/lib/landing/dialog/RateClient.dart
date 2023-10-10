import 'package:flutter/material.dart';
import 'package:okapydriver/core/components/buttons.dart';
import 'package:okapydriver/core/components/loading_indicator.dart';
import 'package:okapydriver/core/constants/colors.dart';
import 'package:okapydriver/landing/landing.dart';
import 'package:okapydriver/state/auth.dart';
import 'package:okapydriver/state/jobs.dart';
import 'package:provider/provider.dart';

class RateClient extends StatefulWidget {
  const RateClient({super.key});

  @override
  State<RateClient> createState() => _RateClient();
}

class _RateClient extends State<RateClient> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Success',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        backgroundColor: Colors.white,
        body: Consumer<Auth>(builder: (context, driver, child) {
          return Consumer<AvailableJobsController>(
            builder: (context, availableJobsController, child) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Thank you for a successful delivery",
                    style: TextStyle(
                        color: AppColors.themeColorGreen,
                        fontSize: 17,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: mediaHeight / 5,
                  ),
                  isLoading
                      ? const LoadingIndicator()
                      : PrimaryButton(
                          text: "Done",
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });
                            availableJobsController
                                .confirmUpdate(driver: driver)
                                .then((value) => {
                                      if (value)
                                        {
                                          setState(() {
                                            isLoading = false;
                                          }),
                                          availableJobsController
                                              .clearJobData(),
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Landing()),
                                          )
                                        }
                                      else
                                        {
                                          setState(() {
                                            isLoading = false;
                                          })
                                        }
                                    });
                          },
                        )
                ],
              ),
            ),
          );
        }));
  }
}
