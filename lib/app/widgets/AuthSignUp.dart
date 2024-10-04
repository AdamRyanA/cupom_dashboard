import 'package:brasil_fields/brasil_fields.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/Auth/auth_controller.dart';
import '../utils/colors.dart';
import 'InputRegister.dart';

class AuthSignUpStateless extends StatelessWidget {
  final void Function()? onPressed;
  final bool loading;
  final Key? formKey;
  final AuthController authController;
  final void Function()? onPressedElevatedButton;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController docController;
  final TextEditingController phoneController;
  final TextEditingController passwordConfirmlController;
  const AuthSignUpStateless(
      this.onPressed,
      this.loading,
      this.formKey,
      this.authController,
      this.onPressedElevatedButton,
      this.emailController,
      this.passwordController,
      this.nameController,
      this.docController,
      this.phoneController,
      this.passwordConfirmlController,
      {super.key}
      );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraint){
          return Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Faça seu cadastro.",
                                      style: GoogleFonts.fredoka(
                                        color: blackColor,
                                        fontSize: 34,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),

                        ValueListenableBuilder(
                          valueListenable: authController.name,
                          builder: (_, value, __) {
                            return InputRegister(
                              colorCard: Colors.transparent,
                              texto: 'Nome do estabelecimento',
                              controllerName: nameController,
                              hintText: 'Digite o nome da estabelecimento',
                              onChange: (value) {
                                authController.name.value = value;
                                authController.checkValidate();
                              },
                              validator: (valor) {
                                if (nameController.text.length > 3) {
                                  return null;
                                }else{
                                  return "Digite o nome da estabelecimento";
                                }
                              },
                              onSubmitted: (valor) {
                                onPressedElevatedButton!();
                              },
                            );
                          },
                        ),
                        ValueListenableBuilder(
                          valueListenable: authController.docNumber,
                          builder: (_, value, __) {
                            return InputRegister(
                              colorCard: Colors.transparent,
                              texto: 'CNPJ',
                              controllerName: docController,
                              hintText: 'Digite o CNPJ',
                              keyboardType: TextInputType.number,
                              onChange: (value) {
                                authController.docNumber.value = value;
                                authController.checkValidateRegister();
                              },
                              validator: (valor) {
                                if (UtilBrasilFields.isCNPJValido(docController.text)) {
                                  return null;
                                }else{
                                  return "CNPJ Inválido";
                                }
                              },
                              format: [
                                FilteringTextInputFormatter.digitsOnly,
                                CnpjInputFormatter(),
                              ],
                              onSubmitted: (valor) {
                                onPressedElevatedButton!();
                              },
                            );
                          },
                        ),
                        ValueListenableBuilder(
                          valueListenable: authController.email,
                          builder: (_, value, __) {
                            return InputRegister(
                              colorCard: Colors.transparent,
                              texto: 'E-mail',
                              controllerName: emailController,
                              hintText: 'Digite seu E-mail',
                              onChange: (value) {
                                authController.email.value = value;
                                authController.checkValidateRegister();
                              },
                              validator: (valor) {
                                if (EmailValidator.validate(emailController.text)) {
                                  return null;
                                }else{
                                  return "Digite um E-mail válido";
                                }
                              },
                              onSubmitted: (valor) {
                                onPressedElevatedButton!();                  },
                            );
                          },
                        ),
                        ValueListenableBuilder(
                          valueListenable: authController.phoneNumber,
                          builder: (_, value, __) {
                            return InputRegister(
                              colorCard: Colors.transparent,
                              texto: 'Telefone',
                              controllerName: phoneController,
                              hintText: 'Digite seu Telefone',
                              keyboardType: TextInputType.number,
                              onChange: (value) {
                                authController.phoneNumber.value = value;
                                authController.checkValidateRegister();
                              },
                              validator: (valor) {
                                if (UtilBrasilFields.removeCaracteres(phoneController.text).length == 11) {
                                  return null;
                                }else{
                                  return "Digite um telefone válido";
                                }
                              },
                              format: [
                                TelefoneInputFormatter(),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onSubmitted: (valor) {
                                onPressedElevatedButton!();                  },
                            );
                          },
                        ),
                        ValueListenableBuilder(
                          valueListenable: authController.password,
                          builder: (_, value, __) {
                            return InputRegister(
                              colorCard: primaryColor,
                              texto: 'Senha',
                              controllerName: passwordController,
                              password: true,
                              onChange: (value)  {
                                authController.password.value = value;
                                authController.checkValidateRegister();
                              },
                              hintText: "Digite a sua senha",
                              validator: (valor) {
                                if (passwordController.text.length > 6) {
                                  return null;
                                }else{
                                  return "Digite uma senha válida";
                                }
                              },
                              onSubmitted: (valor) {
                                onPressedElevatedButton!();
                              },
                            );
                          },
                        ),
                        ValueListenableBuilder(
                          valueListenable: authController.confirmPassword,
                          builder: (_, value, __) {
                            return InputRegister(
                              colorCard: primaryColor,
                              texto: 'Confirme a sua Senha',
                              controllerName: passwordConfirmlController,
                              password: true,
                              onChange: (value)  {
                                authController.confirmPassword.value = value;
                                authController.checkValidateRegister();
                              },
                              hintText: "Digite a confirmação da senha",
                              validator: (valor) {
                                if (passwordConfirmlController.text.length > 6 && passwordConfirmlController.text == passwordController.text) {
                                  return null;
                                }else{
                                  return "A senha tem que ser igual nos dois campos";
                                }
                              },
                              onSubmitted: (valor) {
                                onPressedElevatedButton!();
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                          width: 300,
                          child: ValueListenableBuilder(
                            valueListenable: authController.valid,
                            builder: (_, value, __) {
                              return ElevatedButton(
                                  onPressed: value ? () {
                                    if (loading) {
                                      if (kDebugMode) {
                                        print("Not to do");
                                      }
                                    }else{
                                      onPressedElevatedButton!();
                                    }
                                  } : null,
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: blackColor,
                                    backgroundColor: !loading ? primaryColor : Colors.grey,
                                    disabledBackgroundColor: Colors.grey,
                                    disabledForegroundColor: blackColor,
                                  ),
                                  child: Row(
                                      children: [
                                        Expanded(
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text("Cadastrar",
                                              style: GoogleFonts.fredoka(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]
                                  )
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.center,
                                      child: RichText(
                                        text: TextSpan(
                                            style: GoogleFonts.fredoka(
                                              color: blackColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            children: [
                                              const TextSpan(
                                                text: "Já possui uma conta? ",
                                              ),
                                              TextSpan(
                                                  text: "Acessar conta",
                                                  style: GoogleFonts.fredoka(
                                                      color: blueColor,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      decoration: TextDecoration.underline
                                                  ),
                                                  recognizer: TapGestureRecognizer()
                                                    ..onTap = onPressed
                                              )
                                            ]
                                        ),
                                      )
                                  ),
                                )
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}