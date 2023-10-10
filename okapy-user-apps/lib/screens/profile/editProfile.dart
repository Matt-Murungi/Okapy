import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:okapy/screens/profile/changePassowrd.dart';
import 'package:okapy/screens/utils/colors.dart';
import 'package:okapy/state/auth.dart';
import 'package:okapy/utils/KeyboardUtil.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  int _index = 0;
  String? fname;
  String? lname;
  String? pNumber;
  String? email;
  bool busy = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'KE';
  PhoneNumber number = PhoneNumber(isoCode: 'KE');
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, authController, child) => Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title:  Text(
              'Profile',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        busy = true;
                      });
                      print('validate');
                      _formKey.currentState!.save();
                      KeyboardUtil.hideKeyboard(context);

                      authController
                          .updateUser(
                              email: email!,
                              pNumber: pNumber!,
                              lname: lname!,
                              fname: fname!)
                          .then((value) {
                        setState(() {
                          busy = false;
                        });
                        authController.getUser();
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const Home()),
                        // );
                        const snackBar = SnackBar(
                          content: Text('User Data Updated Successfully'),
                        );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }).catchError((error) {
                        print(error);
                        setState(() {
                          error = true;

                          busy = false;
                        });
                      });
                    }
                  },
                  child: busy
                      ? CircularProgressIndicator(
                          color: themeColorAmber,
                        )
                      : const Text('Done'))
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  authController.userModel!.image!,
                  height: 101,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 1),
                  child: SizedBox(
                    width: 326,
                    child: Text(
                      "First Name",
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
                      onSaved: (newValue) => fname = newValue,
                      initialValue: authController.userModel!.firstName!,
                      decoration: InputDecoration(
                          hintText: authController.userModel!.firstName!,
                          // border: InputBorder()
                          prefixIcon: Image.asset('assets/userIcon.png')),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 1),
                  child: SizedBox(
                    width: 326,
                    child: Text(
                      "Last Name",
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
                      onSaved: (newValue) => lname = newValue,
                      initialValue: authController.userModel!.lastName!,
                      decoration: InputDecoration(
                          hintText: authController.userModel!.lastName!,
                          prefixIcon: Image.asset('assets/userIcon.png')),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 326,
                    child: Text(
                      "Mobile number",
                      style: TextStyle(color: themeColorGrey, fontSize: 12),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 326,
                    // height: 50,
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        print(number.phoneNumber);
                        pNumber = number.phoneNumber;
                      },
                      onInputValidated: (bool value) {
                        print(value);
                      },
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.DROPDOWN,
                      ),
                      ignoreBlank: false,
                      // inputDecoration: ,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: const TextStyle(color: Colors.black),
                      initialValue: PhoneNumber(isoCode: 'KE',phoneNumber:authController.phoneNumber ),
                      textFieldController: controller,
                      formatInput: false,
                      inputDecoration: const InputDecoration(
                          border: InputBorder.none, hintText: '796XX'),
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputBorder: InputBorder.none,

                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                        pNumber = number.phoneNumber;
                      },
                    ),
                  ),
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
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (newValue) => email = newValue,
                      initialValue: authController.userModel!.email!,
                      decoration: InputDecoration(
                          hintText: authController.userModel!.email!,
                          // border: InputBorder()
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: themeColorGreen,
                          )),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ChangePassword()),
                            );
                          },
                          child: const Text(
                            'Change password ',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17),
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
