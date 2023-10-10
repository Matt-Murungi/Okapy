import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:okapy_dashboard/auth/domain/auth_controller.dart';
import 'package:okapy_dashboard/core/routes/route_strings.dart';
import 'package:okapy_dashboard/core/ui/component/buttons.dart';
import 'package:okapy_dashboard/core/ui/component/heading_text.dart';
import 'package:okapy_dashboard/core/ui/component/loader.dart';
import 'package:okapy_dashboard/core/ui/component/snack_bar.dart';
import 'package:okapy_dashboard/core/ui/component/text_input.dart';
import 'package:okapy_dashboard/core/ui/utils/utils.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static const String route = "login";
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<AuthController>(
            builder: (context, controller, child) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(controller.logo),
                    const SizedBox(
                      height: 15,
                    ),
                    Card(
                      child: Container(
                        height: AppUtils.getAppHeight(context) / 1.8,
                        width: AppUtils.getAppWidth(context) / 2,
                        padding:
                            EdgeInsets.all(AppUtils.getAppWidth(context) / 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const HeadingText(
                              text: "LOGIN",
                            ),
                            SizedBox(
                              height: AppUtils.getAppHeight(context) / 15,
                            ),
                            CustomTextInputField(
                              title: "Email",
                              hint: "email@gmail.com",
                              icon: Icons.email_outlined,
                              textEditingController: controller.emailController,
                            ),
                            SizedBox(
                              height: AppUtils.getAppHeight(context) / 80,
                            ),
                            CustomTextInputField.withPassword(
                              title: "Password",
                              hint: "password",
                              textEditingController:
                                  controller.passwordController,
                            ),
                            SizedBox(
                              height: AppUtils.getAppHeight(context) / 30,
                            ),
                            isLoading
                                ? const LoadingWidget()
                                : PrimaryButton(
                                    text: "Login",
                                    onPressed: () {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      controller.loginUser().then((user) {
                                        if (user) {
                                          controller
                                              .fetchUserDetails()
                                              .then((value) {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            context.go(bookingRoute);
                                          });
                                        } else {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          buildSnackbar(
                                              context, controller.errorMessage);
                                        }
                                    
                                      });
                                    }),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
      ),
    );
  }
}
