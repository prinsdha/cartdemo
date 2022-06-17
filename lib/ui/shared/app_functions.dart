import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String msg) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(msg: msg);
}

void disposeKeyBoard() {
  FocusManager.instance.primaryFocus?.unfocus();
}
