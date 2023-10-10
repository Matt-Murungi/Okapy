import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:okapy/screens/authentication/login.dart';
import 'package:okapy/screens/home/home.dart';
import 'package:okapy/screens/utils/colors.dart';
import 'package:okapy/state/auth.dart';
import 'package:okapy/utils/constants.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String? old_password;
  String? new_password1;
  String? new_password2;
  bool busy = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, authController, child) => Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Change Password',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 1),
                child: SizedBox(
                  width: 326,
                  child: Text(
                    "Old Password",
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
                    obscureText: true,
                    onSaved: (newValue) => old_password = newValue,
                    validator: (value) {
                      if (value == null) {
                        // addError(error: kPassNullError);
                        return "";
                      } else if (value.length < 5) {
                        return "";
                      }

                      // addError(error: kShortPassError);
                      return null;
                    },
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
                padding: const EdgeInsets.only(top: 10.0, bottom: 1),
                child: SizedBox(
                  width: 326,
                  child: Text(
                    "new Password",
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
                    obscureText: true,
                    onSaved: (newValue) => new_password1 = newValue,
                    validator: (value) {
                      if (value == null) {
                        // addError(error: kPassNullError);
                        return "";
                      } else if (value.length < 5) {
                        return "";
                      }

                      // addError(error: kShortPassError);
                      return null;
                    },
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
                padding: const EdgeInsets.only(top: 10.0, bottom: 1),
                child: SizedBox(
                  width: 326,
                  child: Text(
                    "Confirm new Password",
                    style: TextStyle(color: themeColorGreen, fontSize: 12),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 326,
                  height: 45,
                  child: TextFormField(
                    obscureText: true,
                    onSaved: (newValue) => new_password2 = newValue,
                    validator: (value) {
                      if (value == null) {
                        // addError(error: kPassNullError);
                        return "";
                      } else if (value.length < 5) {
                        return "";
                      }

                      // addError(error: kShortPassError);
                      return null;
                    },
                    decoration: InputDecoration(
                        // border: InputBorder()
                        prefixIcon: Icon(
                      Icons.lock_outline,
                      color: themeColorGreen,
                    )),
                  ),
                ),
              ),
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
                          authController
                              .changePassword(
                                  new_password1: new_password1!,
                                  new_password2: new_password2!,
                                  old_password: old_password!)
                              .then((value) {
                            setState(() {
                              busy = false;
                            });
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Password Changed Successfully"),
                            ));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                            );
                          }).catchError((onError) {
                            setState(() {
                              busy = false;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("$onError"),
                            ));
                          });
                        }
                      },
                      child: busy
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              'Save new password',
                              style: TextStyle(
                                  color: themeColorGreen,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ))),
              SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
