import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppToasts {
  errorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      toastLength: Toast.LENGTH_LONG,
    );
  }
}
