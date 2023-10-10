import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:okapydriver/ForgotPasswordEmail/ForgotPasswordEmail.dart';
import 'package:okapydriver/home/home.dart';
import 'package:okapydriver/signup/signup.dart';
import 'package:okapydriver/state/auth.dart';
import 'package:okapydriver/utils/color.dart';
import 'package:okapydriver/utils/constants.dart';
import 'package:okapydriver/utils/formerror.dart';
import 'package:okapydriver/utils/keybordHelper.dart';
import 'package:provider/provider.dart';
import 'package:okapydriver/home/components/body.dart' as HomeBody;
import 'package:url_launcher/url_launcher.dart';

import '../loginotp.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool remember = false;
  bool busy = false;
  bool error = false;
  bool active = false;
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'KE';
  PhoneNumber number = PhoneNumber(isoCode: 'KE');
  String? code;
  String? phoneNumber;
  final List<String> errors = [];

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, authController, child) => authController.isLoggedIn
          ? const HomeBody.Body()
          : Scaffold(
              body: SafeArea(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 150,
                        ),
                        Image.asset('assets/logo.png'),
                        const Text(
                          'Welcome back',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        Text(
                          'Please login to continue',
                          style: TextStyle(fontSize: 12, color: themeColorGrey),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 1),
                          child: SizedBox(
                            width: 326,
                            child: Text(
                              "Phone number",
                              style: TextStyle(
                                  color: themeColorGrey, fontSize: 12),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Container(
                            width: 326,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.amber)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: InternationalPhoneNumberInput(
                                onInputChanged: (PhoneNumber number) {
                                  print(number.phoneNumber);
                                  code = number.phoneNumber;
                                  if (code == null) {
                                    setState(() {
                                      active = false;
                                    });
                                  } else {
                                    if (code!.isEmpty) {
                                      setState(() {
                                        active = false;
                                      });
                                    } else {
                                      if (code!.length == 13) {
                                        setState(() {
                                          active = true;
                                        });
                                      } else {
                                        setState(() {
                                          active = false;
                                        });
                                      }
                                    }
                                  }
                                },
                                onInputValidated: (bool value) {
                                  print(value);
                                  return null;
                                },
                                textAlignVertical: TextAlignVertical.top,
                                selectorConfig: const SelectorConfig(
                                  selectorType:
                                      PhoneInputSelectorType.BOTTOM_SHEET,
                                ),
                                ignoreBlank: false,
                                // inputDecoration: ,
                                autoValidateMode: AutovalidateMode.disabled,
                                selectorTextStyle:
                                    const TextStyle(color: Colors.black),
                                initialValue: number,
                                textFieldController: controller,
                                formatInput: false,
                                spaceBetweenSelectorAndTextField: 0,
                                selectorButtonOnErrorPadding: 0,
                                inputDecoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '796XX',
                                    disabledBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: true, decimal: true),
                                inputBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),

                                onSaved: (PhoneNumber number) {
                                  print('On Saved: $number');
                                  phoneNumber = number.phoneNumber;
                                  code = number.phoneNumber;
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            height: 49,
                            width: 326,
                            child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        active
                                            ? themeColorAmber
                                            : Colors.grey.shade300)),
                                onPressed: () {
                                  if (active == false) {
                                    return;
                                  }
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      busy = true;
                                    });
                                    _formKey.currentState!.save();
                                    KeyboardUtil.hideKeyboard(context);

                                    authController.setPhone(
                                      pNumber: code!,
                                    );
                                    authController
                                        .sendOTPNumber1(code!)
                                        .then((value) async {
                                      setState(() {
                                        busy = false;
                                      });
                                      if (value) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginOTP()),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "The phone number entered does not exist"),
                                        ));
                                      }
                                    });
                                  }
                                },
                                child: busy
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        'Login',
                                        style: TextStyle(
                                            color: active
                                                ? themeColorGreen
                                                : Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ))),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()),
                            );
                          },
                          child: SizedBox(
                            height: 30,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Don’t have an account?',
                                    style: TextStyle(
                                      color: Color(0xff1A411D),
                                    ),
                                  ),
                                  Text(
                                    'Create account',
                                    style: TextStyle(
                                      color: Colors.amber,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'By Continuing you have accepted our',
                                  style: TextStyle(
                                      color: Color(0xff1A411D), fontSize: 10),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      child: const Text(
                                        'Terms and conditions',
                                        style: TextStyle(
                                            color: Colors.amber, fontSize: 10),
                                      ),
                                      onTap: () {
                                        _launchInBrowser(Uri.parse(
                                            'https://okapy.world/terms.html'));
                                      },
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    const Text(
                                      'and ',
                                      style: TextStyle(
                                          color: Color(0xff1A411D),
                                          fontSize: 10),
                                    ),
                                    GestureDetector(
                                      child: const Text(
                                        'Privacy Policy',
                                        style: TextStyle(
                                            color: Colors.amber, fontSize: 10),
                                      ),
                                      onTap: () {
                                        _launchInBrowser(Uri.parse(
                                            'https://okapy.world/privacy.html'));
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
