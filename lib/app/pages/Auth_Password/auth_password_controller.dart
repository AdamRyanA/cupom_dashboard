import 'package:flutter/foundation.dart';

class AuthPasswordController {
  final ValueNotifier<String> password = ValueNotifier('');
  final ValueNotifier<String> confirmPassword = ValueNotifier('');
  final ValueNotifier<bool> valid = ValueNotifier(false);

  checkValidate() {

    if (password.value == confirmPassword.value && password.value.length >= 6) {
      if (kDebugMode) {
        print("True");
      }
      valid.value = true;
    }else{
      if (kDebugMode) {
        print("False");
      }
      valid.value = false;
    }
  }

}