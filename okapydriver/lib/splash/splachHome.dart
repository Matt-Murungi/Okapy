import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:okapydriver/login/login.dart';
import 'package:okapydriver/state/auth.dart';
import 'package:okapydriver/utils/color.dart';
import 'package:provider/provider.dart';

class SplashHome extends StatefulWidget {
  const SplashHome({super.key});

  @override
  State<SplashHome> createState() => _SplashState();
}

class _SplashState extends State<SplashHome> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, value, child) => Scaffold(
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
          ],
        ),
      ),
    );
  }
}
