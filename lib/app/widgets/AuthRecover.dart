import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/Auth/auth_controller.dart';
import '../utils/colors.dart';
import '../utils/paths.dart';
import 'InputRegister.dart';

class AuthRecover extends StatelessWidget {
  final bool decision;
  final bool recover;
  final bool loading;
  final AuthController authController;
  final void Function()? onPressed;
  final void Function()? onPressedRecover;
  final Key? formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final double altura;
  final double largura;
  final Animation<double> animationFade;
  const AuthRecover(
      this.decision,
      this.recover,
      this.loading,
      this.authController,
      this.onPressed,
      this.onPressedRecover,
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
            flex: 1,
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
                                "Recuperar senha.",
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
                                      children: const [
                                        TextSpan(
                                          text: "Um e-mail será enviado para sua conta com instruções para recuperar sua senha.",
                                        ),
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
                          authController.checkValidateRecover();
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
                              foregroundColor: !loading ? primaryColor : blackColor,
                              backgroundColor: !loading ? whiteColor : Colors.grey,
                              disabledBackgroundColor: Colors.grey,
                              disabledForegroundColor: blackColor,
                            ),
                            child: const Row(
                                children: [
                                  Expanded(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text("Enviar E-mail"),
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
                                            text: "Voltar para tela de acesso",
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
