import 'package:flutter/material.dart';
import 'package:okapy/screens/createbooking/createbooking.dart';
import 'package:okapy/screens/utils/colors.dart';
import 'package:okapy/state/auth.dart';
import 'package:okapy/state/bookings.dart';
import 'package:provider/provider.dart';

class BookingInitiate extends StatelessWidget {
  const BookingInitiate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0),
      child: Consumer<Bookings>(
        builder: (context, bookingsController, child) {
          return Column(
            children: [
              const Text(
                "Bookings",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26.0,
                ),
              ),
              Image.asset(
                'assets/EmptyState.png',
                height: 140,
              ),
              const Text(
                'No Bookings',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const Text('Start by Creating '),
              const Text('a booking below '),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: 326,
                  height: 49,
                  child: Consumer<Auth>(
                    builder: (context, authController, child) => TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(themeColorAmber)),
                        onPressed: () async {
                          authController.getUser();
                          bookingsController.initializeBooking(data: {
                            'owner': authController.userModel!.id,
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Createbooking()),
                          );
                        },
                        child: const Text(
                          'Create bookings',
                          style: TextStyle(color: Color(0xff1A411D), fontSize: 14),
                        )),
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
