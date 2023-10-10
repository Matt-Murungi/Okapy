import 'package:flutter/material.dart';
import 'package:okapy_dashboard/auth/domain/auth_controller.dart';
import 'package:okapy_dashboard/core/data/local_data_source/local_storage.dart';
import 'package:okapy_dashboard/core/ui/component/loader.dart';
import 'package:okapy_dashboard/core/ui/constants.dart';
import 'package:provider/provider.dart';

class Greetings extends StatelessWidget {
  const Greetings({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: LocalStorage.getUserName(),

        builder: (context, snapshot) => snapshot.hasData
            ? Consumer<AuthController>(builder: (context, controller, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Hi ${snapshot.data} ,",
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors.themeColorGreen,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Have a look at today’s activities',
                      style: TextStyle(
                        color: AppColors.themeColorGreen,
                      ),
                    ),
                    const Divider(),
                  ],
                );
              })
            : const LoadingWidget());
  }
}
