import 'package:flutter/material.dart';
import 'package:okapy/screens/authentication/login.dart';
import 'package:okapy/screens/mybooking/mybooking.dart';
import 'package:okapy/screens/notifications/notifications.dart';
import 'package:okapy/screens/partners/partners.dart';
import 'package:okapy/screens/profile/editProfile.dart';
import 'package:okapy/screens/utils/colors.dart';
import 'package:okapy/state/auth.dart';
import 'package:okapy/state/bookings.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

Drawer drawer(BuildContext context) {
  final auth = context.read<Auth>();
  final booking = context.read<Bookings>();
  return Drawer(
      child: Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 70.0),
        child: Column(
          children: [
            Image.asset(
              'assets/logo.png',
              width: 80,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Okapy Secure",
              style: TextStyle(fontWeight: FontWeight.w900),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: auth.busy
            ? const CircularProgressIndicator()
            : Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Image.network(
                  //   auth.userModel!.image!,
                  //   height: 70,
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          '${auth.userModel!.firstName} ${auth.userModel!.lastName}',
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EditProfile()),
                            );
                          },
                          child: const Text('Edit Profile'),
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),

      const Divider(
        height: 2,
      ),
      // Spacer(),
      const SizedBox(
        height: 20,
      ),
      Consumer<Bookings>(
        builder: (context, booking, child) => InkWell(
          onTap: () {
            booking.getallBookings();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BookingMyBooking()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * .18),
                  child: Image.asset(
                    'assets/timer.png',
                    height: 20,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    'My Bookings',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        ),
      ),

      const SizedBox(
        height: 20,
      ),
      InkWell(
        onTap: () {
          booking.getpartners();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Patners()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * .18),
                child: Image.asset(
                  'assets/cart.png',
                  height: 20,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Partners',
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Notifications()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * .18),
                child: Image.asset(
                  'assets/notification.png',
                  height: 20,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Notifications',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
      const Spacer(),
      const Divider(
        height: 2,
      ),
      const SizedBox(
        height: 10,
      ),
      FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (cont, snap) {
          if (snap.hasData) {
            return Text(
              'Version ${snap.data!.version}',
              style: TextStyle(fontSize: 12, color: themeColorGrey),
            );
          } else if (snap.hasError) {
            return Text(
              'Could not fetch version',
              style: TextStyle(fontSize: 12, color: themeColorGrey),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),

      Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextButton(
            onPressed: () {
              auth.logout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const Login(),
                  ),
                  (route) => false);
            },
            child: const Text(
              "Logout",
              style: TextStyle(color: Color(0xffBB1600), fontSize: 16),
            )),
      ),
    ],
  ) // Populate the Drawer in the next step.
      );
}
