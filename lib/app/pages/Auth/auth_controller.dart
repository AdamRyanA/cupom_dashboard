import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';

class AuthController {
  final ValueNotifier<String> email = ValueNotifier('');
  final ValueNotifier<String> password = ValueNotifier('');
  final ValueNotifier<bool> valid = ValueNotifier(false);

  checkValidate() {
    if (EmailValidator.validate(email.value) && password.value.length >= 6) {
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

  checkValidateRecover() {
    if (EmailValidator.validate(email.value)) {
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