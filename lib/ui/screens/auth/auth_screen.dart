import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewtask/core/const/app_icon.dart';
import 'package:interviewtask/core/const/app_settings.dart';
import 'package:interviewtask/ui/screens/auth/controller/auth_controller.dart';
import 'package:interviewtask/ui/screens/auth/widget/otp_screen.dart';
import 'package:interviewtask/ui/screens/home/home_screen.dart';
import 'package:interviewtask/ui/shared/app_functions.dart';
import 'package:interviewtask/ui/shared/custom_textfield.dart';
import 'package:loader_overlay/loader_overlay.dart';

enum LoginButtonType { googleLogin, mobileLogin }

class AuthScreen extends StatefulWidget {
  static const String routeName = "/authScreen";

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController mobileNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (authController.isMobileNumberScreen) {
          authController.isMobileNumberScreen = false;
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: GetBuilder(
            builder: (AuthController controller) {
              if (controller.isMobileNumberScreen) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Please enter a Mobile number",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomAppTextField(
                          textEditingController: mobileNumber,
                          textFieldType: TextFieldType.mobileNumber),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          disposeKeyBoard();

                          context.loaderOverlay.show();
                          controller.sendPhoneOtp(
                              phoneNumber: mobileNumber.text.trim(),
                              codeSent: () {
                                showToast("Otp send successfully");
                                Get.toNamed(OTPScreen.routeName);
                              });
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8.0)),
                          child: const Center(
                              child: Text(
                            "Send otp",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )),
                        ),
                      )
                    ],
                  ),
                );
              }
              return Column(
                children: [
                  const Spacer(),
                  Image.asset(
                    AppIcon.firebaseLogo,
                    height: 200,
                  ),
                  const Spacer(),
                  const SizedBox(
                    height: 10,
                  ),
                  getButton(LoginButtonType.googleLogin),
                  const SizedBox(
                    height: 10,
                  ),
                  getButton(LoginButtonType.mobileLogin),
                  const Spacer(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget getButton(LoginButtonType loginButtonType) {
    return GestureDetector(
      onTap: () async {
        if (loginButtonType == LoginButtonType.googleLogin) {
          context.loaderOverlay.show();
          final response = await authController.googleLogin();
          context.loaderOverlay.hide();
          if (response != null) {
            Get.toNamed(HomeScreen.routeName);
          }
        } else {
          authController.isMobileNumberScreen = true;
        }
      },
      child: Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: loginButtonType == LoginButtonType.googleLogin
                ? Colors.blue
                : Colors.green),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: loginButtonType == LoginButtonType.googleLogin
                  ? Image.asset(
                      AppIcon.google,
                      height: 25,
                    )
                  : const Icon(Icons.phone, color: Colors.white),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                loginButtonType == LoginButtonType.googleLogin
                    ? "Google"
                    : "Phone",
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
