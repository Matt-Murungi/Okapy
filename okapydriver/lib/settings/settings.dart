import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:okapydriver/banking/profile.dart';
import 'package:okapydriver/login/login.dart';
import 'package:okapydriver/state/auth.dart';
import 'package:okapydriver/state/vehicles.dart';
import 'package:okapydriver/utils/color.dart';
import 'package:okapydriver/notification/notification.dart';
import 'package:okapydriver/profile/profile.dart';
import 'package:okapydriver/vehicles/vehicles.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text('Settings'),
      ),
      body: Consumer<Auth>(
        builder: (context, authController, child) => authController.busy
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      // leading:
                      //     Image.network('${authController.userModel?.image}'),
                      title: Text(
                          '${authController.userModel?.firstName}  ${authController.userModel?.lastName}'),
                      subtitle:
                          Text('${authController.userModel?.phonenumber}'),
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, Profile.routerName,
                            arguments: {'user': authController.userModel});
                      },
                      leading: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/profile.png')),
                            color: themeColorAmber.withOpacity(.38),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      title: Text(
                        'Profile',
                        style: TextStyle(color: themeColorGreen),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: themeColorGreen,
                      ),
                    ),
                    Consumer<VehiclesController>(
                      builder: (context, vehiclesController, child) => ListTile(
                        onTap: () {
                          vehiclesController.getVehicles();
                          Navigator.pushNamed(context, Vehicles.routerName);
                        },
                        leading: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                'assets/vehicleIcon.png',
                              )),
                              color: themeColorAmber.withOpacity(.38),
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        title: Text(
                          'Vehicles',
                          style: TextStyle(color: themeColorGreen),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: themeColorGreen,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(
                            context, NotificationScreen.routerName);
                      },
                      leading: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/notification.png')),
                            color: themeColorAmber.withOpacity(.38),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      title: Text(
                        'Notifications',
                        style: TextStyle(color: themeColorGreen),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: themeColorGreen,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BankingDetails(
                                    authModel: authController.userModel!,
                                  )),
                        );
                      },
                      leading: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/wallet.png'),
                                scale: 3),
                            color: themeColorAmber.withOpacity(.38),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      title: Text(
                        'Banking details',
                        style: TextStyle(color: themeColorGreen),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: themeColorGreen,
                      ),
                    ),
                    Consumer<Auth>(
                      builder: (context, value, child) => ListTile(
                        onTap: () {
                          value.logout();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const Login(),
                              ),
                              (route) => false);
                        },
                        leading: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              color: themeColorAmber.withOpacity(.38),
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(Icons.logout),
                        ),
                        title: Text(
                          'Logout',
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Consumer<Auth>(
                      builder: (context, value, child) => ListTile(
                        onTap: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                "Your account will be deleted in 30 days. You will receive a notification via email. To reactivate your account, log in before the 30 days elapse"),
                          ));
                          value.logout();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const Login(),
                              ),
                              (route) => false);
                        },
                        leading: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              color: themeColorAmber.withOpacity(.38),
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(Icons.logout),
                        ),
                        title: Text(
                          'Delete Account',
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
