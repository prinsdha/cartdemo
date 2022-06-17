import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewtask/core/const/app_settings.dart';
import 'package:interviewtask/ui/screens/auth/controller/auth_controller.dart';
import 'package:interviewtask/ui/screens/home/home_screen.dart';
import 'package:interviewtask/ui/shared/app_functions.dart';
import 'package:interviewtask/ui/shared/custom_textfield.dart';

import 'count_down_time.dart';

class OTPScreen extends StatefulWidget {
  static const String routeName = "/OTPScreen";

  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController otp = TextEditingController();
  final AuthController authController = Get.find<AuthController>();
  bool resendEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Please enter a OTP",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomAppTextField(
                textEditingController: otp,
                textFieldType: TextFieldType.otpType),
            resendEnabled
                ? TextButton(
                    onPressed: () {
                      disposeKeyBoard();

                      authController.sendPhoneOtp(
                          phoneNumber: authController.mobileNumber,
                          codeSent: () {
                            showToast("Otp send successfully");
                          });
                    },
                    child: const Text("Resend OTP"))
                : CountDownTimer(whenComplete: () {
                    resendEnabled = true;
                    setState(() {});
                  }),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                disposeKeyBoard();
                authController.verifyOtp(otp.text.trim(), () {
                  Get.toNamed(HomeScreen.routeName);
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
                  "Verify",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
