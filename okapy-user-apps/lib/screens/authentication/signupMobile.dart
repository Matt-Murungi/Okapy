import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:okapy/screens/authentication/passwordSignup.dart';
import 'package:okapy/state/auth.dart';
import 'package:okapy/utils/KeyboardUtil.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';

class SignUpMobile extends StatefulWidget {
  const SignUpMobile({Key? key}) : super(key: key);

  @override
  State<SignUpMobile> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpMobile> {
  int _index = 0;
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'KE';
  PhoneNumber number = PhoneNumber(isoCode: 'KE');
  String? code;
  String? phoneNumber;
  bool active=false;
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
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        'assets/stepper2.png',
                        height: 31,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 39.0),
                      child: Text(
                        'What’s your Mobile number ?',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: SizedBox(
                        width: 326,
                        child: Text(
                          "Mobile number",
                          style: TextStyle(color: themeColorGrey, fontSize: 12),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        width: 326,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                           border: Border.all(color: Colors.amber)
                        ),
                        child:Padding(
                          padding: EdgeInsets.only(left: 20),
                          child:  InternationalPhoneNumberInput(
                            onInputChanged: (PhoneNumber number) {
                              print(number.phoneNumber);
                              code = number.phoneNumber;
                              if(code==null)
                              {
                                setState(() {
                                  active=false;
                                });
                              }
                              else{
                                if(code!.isEmpty)
                                {
                                  setState(() {
                                    active=false;
                                  });
                                }
                                else{
                                  if(code!.length==13)
                                  {
                                    setState(() {
                                      active=true;
                                    });
                                  }
                                  else{
                                    setState(() {
                                      active=false;
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
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
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
                                border: InputBorder.none, hintText: '796XX',
                              disabledBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none
                            ),
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            inputBorder: OutlineInputBorder(borderSide: BorderSide.none),

                            onSaved: (PhoneNumber number) {
                              print('On Saved: $number');
                              code = number.phoneNumber;
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                    SizedBox(
                        height: 49,
                        width: 326,
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(
                                    active?themeColorAmber:Colors.grey.shade300)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                print('validate');
                                _formKey.currentState!.save();
                                KeyboardUtil.hideKeyboard(context);
                                authController.setPhone(
                                  pNumber: code!,
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUpPass()),
                                );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children:  [
                                const SizedBox(width: 20,),
                                SizedBox(
                                  width: 326 * .7,
                                  child: Center(
                                    child: Text(
                                      'Proceed',
                                      style: TextStyle(
                                          color:  active?themeColorGreen:Colors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color:  active?themeColorGreen:Colors.grey,
                                )
                              ],
                            ))),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
