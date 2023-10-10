import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:okapy/screens/authentication/RequestDelivery.dart';
import 'package:okapy/screens/authentication/registrationotp.dart';
import 'package:okapy/screens/utils/colors.dart';
import 'package:okapy/state/auth.dart';
import 'package:provider/provider.dart';

class RegistrationCOmplete extends StatefulWidget {
  const RegistrationCOmplete({Key? key}) : super(key: key);

  @override
  State<RegistrationCOmplete> createState() => _RegistrationCOmpleteState();
}

class _RegistrationCOmpleteState extends State<RegistrationCOmplete> {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/confirmReg.png',
                height: 53.13,
                width: 54,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 39.0),
              child: Text(
                'Registration Completed',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Enter the OTP code sent to',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: themeColorGrey),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${authController.phoneNumber} ',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: themeColorGrey),
                ),
              ],
            ),
            SizedBox(
              height: 200,
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
                            builder: (context) => const RegistrationOTP()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        SizedBox(
                          width: 326 * .7,
                          child: Center(
                            child: Text(
                              'Confirm Phone Number',
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
          ],
        ),
      ),
    );
  }
}
