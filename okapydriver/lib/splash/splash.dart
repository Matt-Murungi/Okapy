import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:okapydriver/login/login.dart';
import 'package:okapydriver/utils/color.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .5,
            child: Image.asset(
              'assets/amico.png',
              height: 31,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 39.0),
            child: Text(
              'Waiting approval',
              style: TextStyle(
                  fontSize: 31,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                'Thank your for submitting your application  ',
                style: TextStyle(
                  fontSize: 14,
                  color: themeColorGrey,
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                'Our team will review your application and   ',
                style: TextStyle(
                  fontSize: 14,
                  color: themeColorGrey,
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                'communicate to you through email . ',
                style: TextStyle(
                  fontSize: 14,
                  color: themeColorGrey,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: 326,
                  height: 49,
                  child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(themeColorAmber)),
                      onPressed: () {


                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                              const Login(),
                            ),
                                (route) => false);

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Proceed',
                            style:
                                TextStyle(color: themeColorGreen, fontSize: 14),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
