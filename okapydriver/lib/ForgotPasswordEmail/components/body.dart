import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:okapydriver/state/auth.dart';
import 'package:okapydriver/utils/color.dart';
import 'package:okapydriver/utils/keybordHelper.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String initialCountry = 'KE';
  PhoneNumber number = PhoneNumber(isoCode: 'KE');
  String? code;
  String? email;
  bool busy = false;
  final TextEditingController controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<Auth>(
        builder: (context, authController, child) => Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Forgot Password',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Enter your phonenumber to receive',
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
                    height: 45,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (newValue) => email = newValue,
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
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                    SizedBox(
                        height: 49,
                        width: 326,
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(themeColorAmber)),
                            onPressed: () {
                              setState(() {
                                busy = true;
                              });
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                KeyboardUtil.hideKeyboard(context);
                                authController
                                    .sendOTPNumber(emailReset: email!)
                                    .then((value) {
                                  print(value);
                                  setState(() {
                                    busy = false;
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                        "Check your Email for a reset link!."),
                                  ));
                                }).catchError((onError) {
                                  print(onError);
                                  setState(() {
                                    busy = false;
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content:
                                        Text("An Error Occured Try angain."),
                                  ));
                                });
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => const RegistrationOTP()),
                                // );
                              }
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const ResetCode()),
                              // );
                            },
                            child: busy
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
