import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/Auth/auth_controller.dart';
import '../utils/colors.dart';
import 'InputRegister.dart';

class AuthRegister extends StatelessWidget {
  final bool decision;
  final bool loading;
  final AuthController authController;
  final void Function()? onPressed;
  final void Function()? onPressedRecover;
  final void Function()? onPressedChange;
  final Key? formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final double altura;
  final double largura;
  final Animation<double> animationFade;

  const AuthRegister(
      this.decision,
      this.loading,
      this.authController,
      this.onPressed,
      this.onPressedRecover,
      this.onPressedChange,
      this.formKey,
      this.emailController,
      this.passwordController,
      this.altura,
      this.largura,
      this.animationFade,
      {super.key}
      );

  @override
  Widget build(BuildContext context) {
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
                                "Olá, faça seu login.",
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
                                          text: "Ainda não possui uma conta? ",
                                        ),
                                        TextSpan(
                                            text: "Faça seu cadastro",
                                            style: GoogleFonts.fredoka(
                                                color: blueColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                decoration: TextDecoration.underline
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = onPressedChange
                                        )
                                      ]
                                  ),
                                )
                            ),
                          )
                        ],
                      )
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
                          authController.checkValidate();
                        },
                        validator: (valor) {
                          if (EmailValidator.validate(emailController.text)) {
                            return null;
                          }else{
                            return "Digite um E-mail válido";
                          }
                        },
                        onSubmitted: (valor) {
                          onPressed!();                  },
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
                          authController.checkValidate();
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
                          onPressed!();
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
                                onPressed!();
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
                                      child: Text("Entrar",
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
                                          text: "Esqueceu a senha? ",
                                        ),
                                        TextSpan(
                                            text: "Recupere a sua senha",
                                            style: GoogleFonts.fredoka(
                                                color: blueColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                decoration: TextDecoration.underline
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = onPressedRecover
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
          )
        ],
      ),
    );
  }
}
