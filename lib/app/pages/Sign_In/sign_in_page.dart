import 'package:brasil_fields/brasil_fields.dart';
import 'package:cupom_dashboard/app/utils/utils.dart';
import 'package:cupom_dashboard/app/widgets/widgets.dart';
import 'package:cupom_dashboard/data/models/models.dart';
import 'package:cupom_dashboard/domain/usecases/controllers.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  bool focus = false;
  FocusNode focusEmail = FocusNode();
  FocusNode focusCNPJ = FocusNode();
  FocusNode focusPassword = FocusNode();

  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerCNPJ = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  PasswordObscureController passwordObscureController = PasswordObscureController();

  signIn(){
    setState(() => focus = false);
    if (_formKey.currentState!.validate()) {
      Company company = Company.toNull();
      company.email = controllerEmail.text;
      company.cnpj = controllerCNPJ.text;

      String? result = 'Teste'; //TODO
      if(result != null){
        Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.rCompanyPanel, (route) => false);
      }else{
        showSnackBar(context, 'Erro ao fazer o login');
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: primaryLightColor,
              child: Center(
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.rCompanyPanel, (route) => false);
                  },
                  child: Icon(
                      Icons.ac_unit,
                    //color: whiteColor,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'Olá, faça seu login.',
                      style: heading4.copyWith(color: blackColor),
                    ),
                    const SizedBox(height: 16),
                    RichText(
                        text: TextSpan(
                          text: 'Ainda não possui uma conta? ',
                          style: body2,
                          children: [
                            TextSpan(
                              text: 'Faça seu cadastro',
                              style: body2.copyWith(
                                color: blueLightColor,
                                decoration: TextDecoration.underline
                              ),
                              recognizer: TapGestureRecognizer()..onTap = (){
                                Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.rSignUp, (route) => false);
                              },
                            )
                          ]
                        ),
                    ),
                    const SizedBox(height: 35),
                    SizedBox(
                      width: 496,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            InputCustom(
                                controller: controllerEmail,
                                hint: 'Digite seu email aqui',
                                label: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (EmailValidator.validate("$value")) {
                                  return null;
                                } else {
                                  if(!focus){
                                    focusEmail.requestFocus();
                                    setState(() => focus = true);
                                    print('focusEmail');
                                  }
                                  return "Insira um e-mail válido";
                                }
                              },
                              focusNode: focusEmail,
                              autofocus: true,
                              onFieldSubmitted: (value){
                                focusCNPJ.requestFocus();
                                return null;
                              },
                            ),
                            InputCustom(
                                controller: controllerCNPJ,
                                hint: 'Digite seu CNPJ aqui',
                                label: 'CNPJ',
                              validator: (value){
                                if(UtilBrasilFields.isCNPJValido(controllerCNPJ.text)){
                                  return null;
                                } else {
                                  if(!focus){
                                    focusCNPJ.requestFocus();
                                    setState(() => focus = true);
                                    print('focusCNPJ');
                                  }
                                  return 'CNPJ inválido';
                                }
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CnpjInputFormatter(),
                              ],
                              focusNode: focusCNPJ,
                              onFieldSubmitted: (value){
                                focusPassword.requestFocus();
                                return null;
                              },
                            ),
                            ValueListenableBuilder(
                                valueListenable: passwordObscureController.obscure,
                                builder: (BuildContext context, bool obscure, Widget? child) {
                                  return InputCustom(
                                    focusNode: focusPassword,
                                    controller: controllerPassword,
                                    hint: 'Digite sua senha aqui',
                                    label: 'Senha',
                                    obscure: obscure,
                                    onPressedObscure: passwordObscureController.changeObscure,
                                    suffixObscure: true,
                                    validator: (value){
                                      if (value.toString().length >= 6) {
                                        return null;
                                      } else {
                                        if(!focus){
                                          focusPassword.requestFocus();
                                          setState(() => focus = true);
                                          print('focusPassword');
                                        }
                                        return "Insira uma senha com mais de 6 dígitos";
                                      }
                                    },
                                    onFieldSubmitted: (value){
                                      signIn();
                                      return null;
                                    },
                                  );
                                }
                            ),
                            const SizedBox(height: 24),
                            ElevatedCustom(
                                text: 'Entrar',
                                onPressed: (){
                                  signIn();
                                }
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
