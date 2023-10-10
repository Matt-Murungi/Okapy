import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:okapydriver/ChangePassword.dart';
import 'package:okapydriver/models/authmodel.dart';
import 'package:okapydriver/models/userModel.dart';
import 'package:okapydriver/state/auth.dart';
import 'package:okapydriver/utils/color.dart';
import 'package:okapydriver/utils/constants.dart';
import 'package:okapydriver/utils/keybordHelper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:okapydriver/models/user.dart';
import '../../core/api.dart';
import '../../core/locator.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({Key? key, required this.authModel}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
 final UserModel authModel;
}

class _BodyState extends State<Body> {
  int _index = 0;
  String? fname;
  String? lname;
  String? pNumber;
  String? email;
  bool busy = false;
  final Api _api = locator<Api>();
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'KE';
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBankingDetails();
  }
   String? bank_name,bank_branch,account_name,account_number;
   int? id=0;
  bool isLoading=true;
  getBankingDetails() async {
    await _api.getData(endpoint: 'payments/api/driver/banking/information/').then((value) {
      print("The banking details are ${value}");
       Map<String,dynamic>bankingDetails=jsonDecode(value.toString());

      setState(() {
        isLoading=false;
        bank_name=bankingDetails['bank_name'];
        bank_branch=bankingDetails['bank_branch'];
        account_name=bankingDetails['account_name'];
        account_number=bankingDetails['account_number'].toString();
        if(bankingDetails['id']!=null){
        id=bankingDetails['id'];
        }
      });
    });
  }
  createBanking() async {
    await _api.postHeaders(url: 'payments/api/driver/banking/information/', data:  {   "bank_name":bank_name!,
      "bank_branch":bank_branch!,
      "account_number":account_number!,
      "account_name":account_name!,
      "owner":widget.authModel.id.toString()
    }).then((value) {
      print("The banking details are ${value}");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Banking data updated")));
      setState(() {
        isLoading = false;

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
            width: 326,
            height: 49,
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(themeColorAmber)),
              onPressed: () async {
                if(_formKey.currentState!.validate())
                {
                  _formKey.currentState?.save();
                  setState(() {
                    isLoading=true;
                  });
                  if(id==0)
                    {

                      createBanking();
                      return;
                    }
                  final prefs = await SharedPreferences.getInstance();
                  User user = User.fromJson(jsonDecode(prefs.getString('creds')!));
                  AuthModel authModel= AuthModel.fromJson(jsonDecode(prefs.getString('token')!));

                  print(user.userName);
                  print("THe schedule set is ${{   "bank_name":bank_name!,
                    "ban_branch":bank_branch!,
                    "account_number":account_number!,
                    "account_name":account_name!,
                    "owner":widget.authModel.id.toString()
                  }}");
                  var headers = {'Authorization': 'Token ${authModel.key}'};
                  var request = http.MultipartRequest(
                      'PATCH', Uri.parse('https://$baseUrl/payments/api/driver/banking/information/update/${id!}/'));
                  request.fields.addAll(
                      {   "bank_name":bank_name!,
                          "bank_branch":bank_branch!,
                          "account_number":account_number!,
                          "account_name":account_name!,
                          "owner":widget.authModel.id.toString()
                      }
                  );

                  request.headers.addAll(headers);

                  http.StreamedResponse response = await request.send();
                  var data = jsonDecode(await response.stream.bytesToString());
                  print("THe schedule set is ${data}");
                  if (response.statusCode == 200) {

                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("Banking data updated")));
                    setState(() {
                      isLoading = false;

                    });

                  } else {
                    print("The error is ${response.reasonPhrase}");
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("An error occurred")));

                    setState(() {
                      isLoading = false;

                    });

                  }


                }
              },
              child:  Text(
                'Update bank details',
                style: TextStyle(
                    color:
                    themeColorGreen,
                    fontSize: 14),
              ),
            ),
          )),
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       setState(() {
//                         busy = true;
//                       });
//                       print('validate');
//                       _formKey.currentState!.save();
//                       KeyboardUtil.hideKeyboard(context);
//
//                       authController
//                           .updateUser(
//                               email: email!,
//                               pNumber: pNumber!,
//                               lname: lname!,
//                               fname: fname!)
//                           .then((value) {
//                         setState(() {
//                           busy = false;
//                         });
//                         authController.getUser();
//                         // Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(
//                         //       builder: (context) => const Home()),
//                         // );
//                         const snackBar = SnackBar(
//                           content: Text('User Data Updated Successfully'),
//                         );
//
// // Find the ScaffoldMessenger in the widget tree
// // and use it to show a SnackBar.
//                         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                       }).catchError((error) {
//                         print(error);
//                         setState(() {
//                           error = true;
//
//                           busy = false;
//                         });
//                       });
//                     }
//                   },
//                   child: busy
//                       ? CircularProgressIndicator(
//                           color: themeColorAmber,
//                         )
//                       : const Text('Done'))
//             ],,
      ),
      body:isLoading?Column(children: const [LinearProgressIndicator()],): SingleChildScrollView(
        child:Form(
          key:_formKey ,
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2.0),
                child: Text(
                  'Your banking details',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 1),
                child: SizedBox(
                  width: 326,
                  child: Text(
                    "Bank name",
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
                    onSaved: (newValue) => bank_name = newValue,
                    initialValue: bank_name,
                    decoration: InputDecoration(
                        hintText: "",
                        // border: InputBorder()
                        prefixIcon: Image.asset('assets/bank.png')),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 1),
                child: SizedBox(
                  width: 326,
                  child: Text(
                    "Bank branch",
                    style: TextStyle(color: themeColorGrey, fontSize: 12),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10),
                child: SizedBox(
                  width: 326,
                  height: 45,
                  child: TextFormField(
                    onSaved: (newValue) => bank_branch = newValue,
                    initialValue: bank_branch,
                    decoration: InputDecoration(
                        hintText: "",
                        prefixIcon:Image.asset('assets/bank.png')),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 326,
                  child: Text(
                    "Account name",
                    style: TextStyle(color: themeColorGrey, fontSize: 12),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10),
                child: SizedBox(
                  width: 326,
                  height: 45,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    onSaved: (newValue) => account_name = newValue,
                    initialValue: account_name,
                    decoration: InputDecoration(
                        hintText:"",
                        // border: InputBorder()
                        prefixIcon: Icon(
                          Icons.person,
                          color: themeColorGreen,
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 326,
                  child: Text(
                    "Account number",
                    style: TextStyle(color: themeColorGrey, fontSize: 12),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10),
                child: SizedBox(
                  width: 326,
                  height: 45,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    onSaved: (newValue) => account_number = newValue,
                    initialValue: account_number,
                    decoration: InputDecoration(
                        hintText:"",
                        // border: InputBorder()
                        prefixIcon: Icon(
                          Icons.format_list_numbered,
                          color: themeColorGreen,
                        )),
                  ),
                ),
              ),
              Row(
                children: [

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
