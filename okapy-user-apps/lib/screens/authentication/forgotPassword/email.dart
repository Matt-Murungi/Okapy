import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:okapy/screens/authentication/forgotPassword/resetCode.dart';
import 'package:okapy/screens/home/home.dart';
import 'package:okapy/screens/utils/colors.dart';

class ForgotPasswordEmail extends StatefulWidget {
  const ForgotPasswordEmail({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordEmail> createState() => _ForgotPasswordEmailState();
}

class _ForgotPasswordEmailState extends State<ForgotPasswordEmail> {
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
                'Forgot Password',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                'Enter your email to receive',
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
                'a reset password Code ',
                style: TextStyle(
                  fontSize: 12,
                  color: themeColorGrey,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 1),
            child: SizedBox(
              width: 326,
              child: Text(
                "Email",
                style: TextStyle(color: themeColorGrey, fontSize: 12),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: 326,
              height: 45,
              child: TextFormField(
                decoration: InputDecoration(
                    // border: InputBorder()
                    prefixIcon: Icon(
                  Icons.email_outlined,
                  color: themeColorGreen,
                )),
              ),
            ),
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
                          builder: (context) => const ResetCode()),
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
