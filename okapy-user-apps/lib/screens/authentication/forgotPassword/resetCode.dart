import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:okapy/screens/authentication/forgotPassword/newPassword.dart';
import 'package:okapy/screens/home/home.dart';
import 'package:okapy/screens/utils/colors.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class ResetCode extends StatefulWidget {
  const ResetCode({Key? key}) : super(key: key);

  @override
  State<ResetCode> createState() => _ForgotPasswordEmailState();
}

class _ForgotPasswordEmailState extends State<ResetCode> {
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                'Enter Reset Code',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
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
                'dan*****@gmail.com',
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewPassword()),
                    );
                  },
                  child: const Text(
                    'Send Code',
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
                children: const [
                  Text(
                    'Do you remember your password ? ',
                    style: TextStyle(
                      color: Color(0xff1A411D),
                    ),
                  ),
                  Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
