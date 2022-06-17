import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:interviewtask/ui/shared/app_functions.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AuthController extends GetxController {
  bool _isMobileNumberScreen = false;

  bool get isMobileNumberScreen => _isMobileNumberScreen;

  set isMobileNumberScreen(bool value) {
    _isMobileNumberScreen = value;
    update();
  }

  GoogleSignIn googleSignIn = GoogleSignIn();

  String code = "+91";
  String mobileNumber = "";

  Future<UserCredential?> googleLogin() async {
    try {
      await googleSignIn.signOut();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount!.authentication;
      OAuthCredential? credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      debugPrint("GOOGLE AUTH ERROR $e");
      return null;
    }
  }

  String? _verificationId;

  String? get verificationId => _verificationId;

  set verificationId(String? value) {
    _verificationId = value;
    update();
  }

  Future<void> sendPhoneOtp(
      {required String phoneNumber, required Function() codeSent}) async {
    mobileNumber = phoneNumber;
    verificationId = null;
    Get.context!.loaderOverlay.show();
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "$code$phoneNumber",
        timeout: const Duration(seconds: 10),
        verificationCompleted: (phoneAuthCredential) {},
        codeSent: (String id, int? n) {
          Get.context!.loaderOverlay.hide();
          codeSent();
          _verificationId = id;
        },
        verificationFailed: (FirebaseAuthException e) async {
          Get.context!.loaderOverlay.hide();
          debugPrint(e.message);
          showToast(e.code);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          Get.context!.loaderOverlay.hide();
        });
  }

  Future<void> verifyOtp(String otp, Function() onVerified) async {
    try {
      final phoneAuthCredentials = PhoneAuthProvider.credential(
          verificationId: verificationId!, smsCode: otp);
      await FirebaseAuth.instance.signInWithCredential(phoneAuthCredentials);
      onVerified();
    } on FirebaseAuthException catch (e) {
      showToast(e.code);
    }
  }
}
