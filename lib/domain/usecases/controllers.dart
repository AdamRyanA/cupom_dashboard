import 'package:flutter/material.dart';

class PasswordObscureController {
  final ValueNotifier<bool> obscure = ValueNotifier(true);
  changeObscure(){
    obscure.value = !obscure.value;
  }
}
