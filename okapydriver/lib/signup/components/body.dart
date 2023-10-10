import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:okapydriver/docs/docs.dart';
import 'package:okapydriver/login/login.dart';
import 'package:okapydriver/state/auth.dart';
import 'package:okapydriver/utils/color.dart';
import 'package:okapydriver/utils/constants.dart';
import 'package:okapydriver/utils/keybordHelper.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _index = 0;
  String fname="";
  String email="";
  String lname="";
  String? password1;
  String? password2;
  bool confirmNumber = false;
  final _formKey = GlobalKey<FormState>();

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

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'KE';
  PhoneNumber number = PhoneNumber(isoCode: 'KE');
  String code="";
  String phoneNumber="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Consumer<Auth>(
          builder: (context, authController, child) => SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 2.0),
                    child: Text(
                      'Let’s get your details',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      'assets/st1.png',
                      height: 31,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 1),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * .4,
                                child: Text(
                                  "First Name",
                                  style: TextStyle(
                                      color: themeColorGreen, fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width * .8) / 2,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: TextFormField(
                                  onChanged: (newValue) => {
                                    setState((){
                                      fname = newValue;
                                    })
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      addError(error: kNamelNullError);
                                      return "";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      // border: InputBorder()
                                      prefixIcon:
                                          Image.asset('assets/userIcon.png')),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 1),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * .4,
                                child: Text(
                                  "Last Name",
                                  style: TextStyle(
                                      color: themeColorGrey, fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width * .8) / 2,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 5.0, right: 10),
                                child: TextFormField(
                                  onChanged: (newValue) => {
                                    setState((){
                                      lname = newValue;
                                    })
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      addError(error: kNamelNullError);
                                      return "";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      // border: InputBorder()
                                      prefixIcon:
                                          Image.asset('assets/userIcon.png')),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 1),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: Text(
                        "Email",
                        style: TextStyle(color: themeColorGreen, fontSize: 12),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      // height: 45,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (newValue) => {
                          setState((){
                            email = newValue;
                          })
                        },
                        // initialValue: authController.userModel!.email!,
                        decoration: InputDecoration(
                            // hintText: authController.userModel!.email!,
                            // border: InputBorder()
                            prefixIcon: Icon(
                          Icons.email_outlined,
                          color: themeColorGreen,
                        )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: Text(
                        "Mobile number",
                        style: TextStyle(color: themeColorGrey, fontSize: 12),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // border: Border.all(color: Colors.amber)
                      ),
                      child: InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          print(number.phoneNumber);
                          code = number.phoneNumber!;
                         setState(() {
                           phoneNumber = number.phoneNumber!;
                         });
                        },
                        onInputValidated: (bool value) {
                          print(value);
                          return null;
                        },

                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.DROPDOWN,
                        ),
                        ignoreBlank: false,
                        // inputDecoration: ,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: const TextStyle(color: Colors.black),
                        initialValue: number,
                        textFieldController: controller,
                        formatInput: false,
                        inputDecoration: const InputDecoration(
                            border: InputBorder.none, hintText: '796XX'),
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        inputBorder: InputBorder.none,

                        onSaved: (PhoneNumber number) {
                          print('On Saved: $number');
                          code = number.phoneNumber!;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  confirmNumber
                      ? OTPTextField(
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
                          onCompleted: (pin) {
                            print("Completed: " + pin);
                            setState(() {
                              busy = true;
                            });
                            authController
                                .sendOTPConfirmation(otp: pin,phone:code!)
                                .then((value) {
                                  if(value){
                              print('true');
                              Navigator.pushNamed(context, Docs.routerName);
                                  }else{
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                      Text("Otp used is invalid,kindly use a valid one"),
                                    ));
                                  }
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => const Login()),
                              // );
                            }).catchError((onError) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content:
                                    Text("Otp is invalid"),
                              ));
                            });
                          },
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 20,
                  ),
                  confirmNumber
                      ? InkWell(
                          onTap: () {
                            authController.sendOTP();
                          },
                          child: SizedBox(
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
                        )
                      : SizedBox(
                          height: 49,
                          width: 326,
                          child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(validateData()?themeColorAmber:Colors.grey.shade300)),
                              onPressed: () {
                                if(validateData()==false){
                                  return;
                                }
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    busy = true;
                                  });
                                  print('validate');
                                  _formKey.currentState!.save();
                                  KeyboardUtil.hideKeyboard(context);
                                  authController
                                      .register(
                                          email: email!,
                                          first_name: fname!,
                                          last_name: lname!,
                                          pn: code!)
                                      .then((value) {
                                    setState(() {
                                      busy = false;
                                      confirmNumber = true;
                                      _start = 20;
                                    });
                                    print(value);

                                    startTimer();
                                    // Navigator.pushNamed(
                                    //     context, Docs.routerName);

                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           const RegistrationCOmplete()),
                                    // );
                                  }).catchError((error) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Phone number or email already used"),
                                    ));
                                    setState(() {
                                      error = true;

                                      busy = false;
                                    });
                                    addError(error: 'An Error Occured');
                                    addError(
                                        error:
                                            'Check your email and password fields!');
                                  });
                                }
                              },
                              child: busy
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children:  [
                                        SizedBox(width: 20,),
                                        SizedBox(
                                          width: 326 * .7,
                                          child: Center(
                                            child: Text(
                                              'Proceed',
                                              style: TextStyle(
                                                  color: validateData()?themeColorGreen:Colors.grey,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_sharp,
                                          color: validateData()?themeColorGreen:Colors.grey,
                                        )
                                      ],
                                    ))),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ));
  }
  bool validateData(){
    return phoneNumber.length==13 && fname.isNotEmpty && lname.isNotEmpty && email.isNotEmpty;
  }
}
