import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:okapy/screens/authentication/login.dart';
import 'package:okapy/screens/home/home.dart';
import 'package:okapy/screens/utils/colors.dart';

class GetPackage extends StatefulWidget {
  const GetPackage({Key? key}) : super(key: key);

  @override
  State<GetPackage> createState() => _RegistrationCOmpleteState();
}

class _RegistrationCOmpleteState extends State<GetPackage> {
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/sp2.png',
              height: 320,
              width: 329.74,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 39.0),
            child: Text(
              'Get your package delivered',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          Text(
            'in minutes',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          const SizedBox(
            height: 30,
          ),
          Image.asset(
            'assets/sp3.png',
            height: 14,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      SizedBox(
                        width: 326 * .7,
                        child: Center(
                          child: Text(
                            'Skip',
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
    );
  }
}
