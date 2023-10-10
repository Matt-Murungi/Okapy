import 'package:akar_icons_flutter/akar_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:intl/intl.dart';
import 'package:okapydriver/splash/splash.dart';
import 'package:okapydriver/state/auth.dart';
import 'package:okapydriver/state/vehicles.dart';
import 'package:okapydriver/utils/color.dart';
import 'package:okapydriver/utils/keybordHelper.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String? regNumber;
  String? vtype;
  String? model;
  String? color;
  String? insuranceExp="";
 // TextEditingController dateInput = TextEditingController();
  bool busy = false;
  // String? insuranceExp;

  String dropdownvalue = 'Motorbike';

  // List of items in our dropdown menu
  var items = [
    'Motorbike',
    'Vehicle',
    'Van',
    'Truck',
  ];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Consumer<VehiclesController>(
          builder: (context, vehicleController, child) => Consumer<Auth>(
            builder: (context, authController, child) => Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 39.0),
                      child: Text(
                        'Add your vehicle details',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        'assets/st2.png',
                        height: 31,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .8,
                        child: Text(
                          "Reg number *",
                          style:
                              TextStyle(color: themeColorGreen, fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: TextFormField(
                        onSaved: (newValue) => regNumber = newValue,
                        decoration: InputDecoration(
                            // border: InputBorder()

                            prefixIcon: Icon(
                          Boxicons.bx_id_card,
                          color: themeColorGreen,
                          size: 24,
                        )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 10),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .8,
                        child: Text(
                          "Vehicle type *",
                          style:
                              TextStyle(color: themeColorGreen, fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * .8,
                        child: DropdownButtonFormField(
                          elevation: 0,
                          isExpanded: true,
                          onSaved: (newValue) => vtype = newValue.toString(),
                          value: dropdownvalue,
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 10),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .8,
                        child: Text(
                          "Model  *",
                          style:
                              TextStyle(color: themeColorGreen, fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: TextFormField(
                        onSaved: (newValue) => model = newValue,
                        validator: (value) {
                          if (value == null) {
                            return "";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 10),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .8,
                        child: Text(
                          "Color*",
                          style:
                              TextStyle(color: themeColorGreen, fontSize: 12),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 15.0,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .8,
                        // height: 45,
                        child: TextFormField(
                          onSaved: (newValue) => color = newValue,
                          validator: (value) {
                            if (value == null) {
                              return "";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 10),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .8,
                        child: Text(
                          "Insurance expiry date*",
                          style:
                              TextStyle(color: themeColorGreen, fontSize: 12),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        print('object');
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          setState(() {
                            insuranceExp =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {}
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * .8,
                          child: Icon(
                            AkarIcons.calendar,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: const [
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                    SizedBox(
                        height: 49,
                        width: 326,
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(themeColorAmber)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  busy = true;
                                });
                                _formKey.currentState!.save();
                                KeyboardUtil.hideKeyboard(context);
                                vehicleController
                                    .addVehicle(
                                        rNumb: regNumber!,
                                        vType: vtype!,
                                        model: model!,
                                        color: color!,
                                        date: insuranceExp!,
                                        owner: authController.userModel!.id!)
                                    .then((value) {
                                  setState(() {
                                    busy = true;
                                  });
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                        const Splash(),
                                      ),
                                          (route) => false);

                                }).catchError((onError) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content:
                                        Text("An Error Occured Try Again!"),
                                  ));
                                });
                              }
                              // Navigator.pushNamed(context, Home.routerName);
                            },
                            child: busy
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Add vehicle',
                                    style: TextStyle(
                                        color: Color(0xff1A411D),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ))),
                    const SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
