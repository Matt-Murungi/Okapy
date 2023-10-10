import 'package:flutter/material.dart';
import 'package:okapydriver/utils/color.dart';
import 'package:okapydriver/home/home.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _OtpState();
}

class _OtpState extends State<Body> {
  OtpFieldController otpController = OtpFieldController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
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
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                'Ener the reset code sent to ',
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
                '+254 701 567 890 ',
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
            length: 4,
            width: MediaQuery.of(context).size.width * .9,
            fieldWidth: 53,
            style: const TextStyle(fontSize: 17),
            textFieldAlignment: MainAxisAlignment.spaceEvenly,
            fieldStyle: FieldStyle.box,
            onCompleted: (pin) {
              print("Completed: " + pin);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45.0),
            child: SizedBox(
              height: 30,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Did not receive the code ?  ',
                      style: TextStyle(color: Color(0xff1A411D), fontSize: 10),
                    ),
                    Text(
                      'Resend code',
                      style: TextStyle(color: Colors.amber, fontSize: 10),
                    ),
                  ],
                ),
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
                      backgroundColor:
                          MaterialStateProperty.all(themeColorAmber)),
                  onPressed: () {
                    Navigator.pushNamed(context, Home.routerName);
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: Color(0xff1A411D),
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ))),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
