import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toast({required String message}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: Colors.grey.shade900,
    gravity: ToastGravity.BOTTOM,
  );
}