import 'dart:js_interop';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:okapy_dashboard/auth/data/partner_model.dart';
import 'package:okapy_dashboard/auth/data/user_model.dart';
import 'package:okapy_dashboard/auth/domain/auth_controller.dart';
import 'package:okapy_dashboard/core/controller/core_controller.dart';
import 'package:okapy_dashboard/core/routes/route_strings.dart';
import 'package:okapy_dashboard/core/ui/component/buttons.dart';
import 'package:okapy_dashboard/core/ui/component/heading_text.dart';
import 'package:okapy_dashboard/core/ui/component/list_tile.dart';
import 'package:okapy_dashboard/core/ui/component/loader.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var authController = context.read<AuthController>();
    var coreController = context.read<CoreController>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder<UserModel?>(
                future: authController.fetchUserDetails(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? const LoadingWidget()
                      : Card(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    const SubHeadingText(text: "Profile"),
                                    PaddedListTile(
                                        title: "Name",
                                        trailing:
                                            "${snapshot.data?.firstName} ${snapshot.data?.lastName}"),
                                    PaddedListTile(
                                        title: "Phone Number",
                                        trailing:
                                            "${snapshot.data?.phonenumber}"),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        );
                }),
            FutureBuilder<PartnerModel?>(
                future: authController.fetchPartnerDetails(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? const LoadingWidget()
                      : Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const SubHeadingText(text: "Partner"),
                                PaddedListTile(
                                    title: "Name",
                                    trailing: "${snapshot.data?.name}"),
                                PaddedListTile(
                                    title: "Description",
                                    trailing: "${snapshot.data?.description}"),
                                PaddedListTile(
                                    title: "Latitude",
                                    trailing: "${snapshot.data?.latitude}"),
                                PaddedListTile(
                                    title: "Longitude",
                                    trailing: "${snapshot.data?.longitude}"),
                              ],
                            ),
                          ),
                        );
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
            ),
            PrimaryButton(
              text: "Log Out",
              onPressed: () => authController
                  .logout()
                  .then((value) => context.go(loginRoute)),
              isOutlined: true,
            )
          ],
        ),
      ),
    );
  }
}
