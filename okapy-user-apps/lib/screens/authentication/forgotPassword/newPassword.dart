import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:okapy/screens/authentication/forgotPassword/resetCode.dart';
import 'package:okapy/screens/authentication/login.dart';
import 'package:okapy/screens/home/home.dart';
import 'package:okapy/screens/utils/colors.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  State<NewPassword> createState() => _ForgotPasswordEmailState();
}

class _ForgotPasswordEmailState extends State<NewPassword> {
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
                'Enter New Password',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 1),
            child: SizedBox(
              width: 326,
              child: Text(
                "New Password",
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
                  Icons.lock_outline,
                  color: themeColorGreen,
                )),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 1),
            child: SizedBox(
              width: 326,
              child: Text(
                "Confirm Password",
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
                  Icons.lock_outline,
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
                      MaterialPageRoute(builder: (context) => const Login()),
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
