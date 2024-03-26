import 'package:cupom_dashboard/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: const Duration(seconds: 3),
          content: Text(message)
      )
  );
}

showToast(BuildContext context, String message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: greyColor,
      textColor: blackColor87);
}

/*
showToast(BuildContext context, String message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: primaryColor,
      textColor: Colors.white);
}
 */