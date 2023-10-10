import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:okapy/screens/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../models/bookingModel.dart';
import '../../../models/user.dart';
import '../../../models/userModel.dart';

class RecentBookings extends StatefulWidget {
  const RecentBookings({Key? key}) : super(key: key);

  @override
  State<RecentBookings> createState() => _RecentBookingsState();
}

class _RecentBookingsState extends State<RecentBookings> {
  late SharedPreferences sharedPref;
  List allBookings = [];

  getRecentBookings() async {
    sharedPref = await SharedPreferences.getInstance();
    User user = User.fromJson(jsonDecode(sharedPref.getString('creds')!));

    var headers = {
      'Authorization':
          'Basic ${base64.encode(utf8.encode('${user.userName}:${user.password}'))}'
    };
    var request = http.Request(
        'GET', Uri.parse('https://apidev.okapy.world/bookings/api/bookings/'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      print(data);
      if (data != null) {
        setState(() {
          allBookings = data as List;
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    getRecentBookings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: allBookings.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:  BoxDecoration(
                    border: Border.all(
                      color: themeColorAmber,
                      width: 2,
                    ),
                    gradient:  LinearGradient(
                      colors: [
                        themeColorAmber,
                        themeColorAmber
                      ],
                    ),
                    borderRadius: const BorderRadius.all(
                        Radius.circular(10))),

                child:Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      allBookings[index]['booking_id'],
                      style: TextStyle(color: Color(0xff1A411D), fontSize: 15),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
