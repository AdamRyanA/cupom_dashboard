import 'package:flutter/foundation.dart';

class PasswordObscureController {
  final ValueNotifier<bool> obscure = ValueNotifier(true);
  changeObscure(){
    obscure.value = !obscure.value;
    if (kDebugMode) {
      print(obscure.value);
    }
  }
}