import 'package:brasil_fields/brasil_fields.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';

class AuthController {
  final ValueNotifier<String> email = ValueNotifier('');
  final ValueNotifier<String> password = ValueNotifier('');
  final ValueNotifier<String> confirmPassword = ValueNotifier('');
  final ValueNotifier<String> name = ValueNotifier('');
  final ValueNotifier<String> docNumber = ValueNotifier('');
  final ValueNotifier<String> phoneNumber = ValueNotifier('');
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

  checkValidateRegister() {
    if (EmailValidator.validate(
        email.value)
        && password.value.length >= 6
        && name.value.length >= 3 && UtilBrasilFields.isCNPJValido(docNumber.value)
        && UtilBrasilFields.removeCaracteres(phoneNumber.value).length == 11
        && password.value == confirmPassword.value
    ) {
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