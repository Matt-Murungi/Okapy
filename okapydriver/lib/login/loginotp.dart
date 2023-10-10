import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:okapydriver/state/auth.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../home/home.dart';
import '../utils/color.dart';

class LoginOTP extends StatefulWidget {
  const LoginOTP({Key? key}) : super(key: key);

  @override
  State<LoginOTP> createState() => _LoginOTP();
}

class _LoginOTP extends State<LoginOTP> {
  OtpFieldController otpController = OtpFieldController();
  bool busy = false;
  Timer? _timer;
  int _start = 20;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, authController, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  'Enter OTP Code',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  'Enter the OTP code sent to ',
                  style: TextStyle(
                    fontSize: 12,
                    color: themeColorGrey,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  '${authController.phoneNumber}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: themeColorGrey,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            OTPTextField(
              controller: otpController,
              otpFieldStyle: OtpFieldStyle(
                  enabledBorderColor: themeColorAmber,
                  focusBorderColor: themeColorRed,
                  borderColor: themeColorAmber),
              length: 5,
              width: MediaQuery.of(context).size.width * .9,
              fieldWidth: 53,
              style: const TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceEvenly,
              fieldStyle: FieldStyle.box,
              onChanged: (s) {},
              onCompleted: (pin) {
                print("Completed: " + pin);
                setState(() {
                  busy = true;
                });
                authController
                    .sendOTPConfirmation(
                        otp: pin, phone: authController.phoneNumber!)
                    .then((value) {
                  if (value) {
                    authController.getUser();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const Home(),
                        ),
                        (route) => false);
                  } else {

                    setState(() {
                      busy = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("${authController.errorMessage}"),
                    ));
                  }
                });
              },
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
                height: 49,
                width: 326,
                child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(themeColorAmber)),
                    onPressed: () {
                      setState(() {
                        busy = true;
                      });
                      authController
                          .sendOTPConfirmation(
                              otp: otpController.toString(),
                              phone: authController.phoneNumber!)
                          .then((value) {
                        if (value == true) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => const Home(),
                              ),
                              (route) => false);
                        } else {
                          setState(() {
                            busy = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("${authController.errorMessage}"),
                          ));
                        }
                      });
                    },
                    child: busy
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Confirm OTP',
                            style: TextStyle(
                                color: Color(0xff1A411D),
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ))),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 30,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'resend OTP? ',
                      style: TextStyle(
                        color: Color(0xff1A411D),
                      ),
                    ),
                    if (_start == 0)
                      InkWell(
                        onTap: () {
                          authController.sendOTP();
                          setState(() {
                            _start = 20;
                          });
                          startTimer();
                        },
                        child: Text(
                          'resend',
                          style: const TextStyle(
                            color: Colors.amber,
                          ),
                        ),
                      )
                    else
                      Text(
                        '$_start',
                        style: const TextStyle(
                          color: Colors.amber,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
