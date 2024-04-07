import 'package:brasil_fields/brasil_fields.dart';
import 'package:cupom_dashboard/app/utils/utils.dart';
import 'package:cupom_dashboard/app/widgets/widgets.dart';
import 'package:cupom_dashboard/data/models/models.dart';
import 'package:cupom_dashboard/domain/usecases/controllers.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  bool focus = false;
  FocusNode focusName = FocusNode();
  FocusNode focusCNPJ = FocusNode();
  FocusNode focusEmail = FocusNode();
  FocusNode focusPhone = FocusNode();
  FocusNode focusPassword = FocusNode();
  FocusNode focusConfirmPassword = FocusNode();

  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerCNPJ = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerConfirmPassword = TextEditingController();
  var maskTelefone = MaskTextInputFormatter(mask: '## #####-####');
  PasswordObscureController passwordObscureController = PasswordObscureController();

  signUp(){
    setState(() => focus = false);
    if (_formKey.currentState!.validate()) {
      Company company = Company.toNull();
      company.name = controllerName.text;
      company.cnpj = controllerCNPJ.text;
      company.email = controllerEmail.text;
      company.phone = controllerPhone.text;
      
      String? result = 'Teste'; //TODO
      if(result != null){
        Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.rCompanyPanel, (route) => false);
      }else{
        showSnackBar(context, 'Erro ao criar usuario');
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
                      'Olá, faça seu cadastro.',
                      style: heading4.copyWith(color: blackColor),
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                          text: 'Já possui uma conta? ',
                          style: body2,
                          children: [
                            TextSpan(
                              text: 'Faça seu login',
                              style: body2.copyWith(
                                  color: blueLightColor,
                                  decoration: TextDecoration.underline
                              ),
                              recognizer: TapGestureRecognizer()..onTap = (){
                                Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.rSignIn, (route) => false);
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
                                autofocus: true,
                                controller: controllerName,
                                hint: 'Digite o nome completo da empresa',
                                label: 'Nome da empresa',
                              validator: (value) {
                                if (value.toString().length >= 6) {
                                  return null;
                                } else {
                                  if(!focus){
                                    focusName.requestFocus();
                                    setState(() => focus = true);
                                  }
                                  return "Insira o nome";
                                }
                              },
                              focusNode: focusName,
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
                                focusEmail.requestFocus();
                                return null;
                              },
                            ),
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
                                  }
                                  return "Insira um e-mail válido";
                                }
                              },
                              focusNode: focusEmail,
                              onFieldSubmitted: (value){
                                focusPhone.requestFocus();
                                return null;
                              },
                            ),
                            InputCustom(
                                controller: controllerPhone,
                                hint: null,
                                label: 'Telefone',
                              prefixBool: true,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                maskTelefone
                              ],
                              validator: (value){
                                String tell = value!.replaceAll(' ', '').replaceAll('-', '');
                                if(tell.length == 11){
                                  return null;
                                } else {
                                  if(!focus){
                                    focusPhone.requestFocus();
                                    setState(() => focus = true);
                                  }
                                  return 'Telefone Inválido';
                                }
                              },
                              focusNode: focusPhone,
                              onFieldSubmitted: (value){
                                focusPassword.requestFocus();
                                return null;
                              },
                            ),
                            ValueListenableBuilder(
                                valueListenable: passwordObscureController.obscure,
                                builder: (BuildContext context, bool obscure, Widget? child) {
                                  return Column(
                                    children: [
                                      InputCustom(
                                        controller: controllerPassword,
                                        hint: 'Digite sua senha',
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
                                            }
                                            return "Insira uma senha com mais de 6 dígitos";
                                          }
                                        },
                                        focusNode: focusPassword,
                                        onFieldSubmitted: (value){
                                          focusConfirmPassword.requestFocus();
                                          return null;
                                        },
                                      ),
                                      InputCustom(
                                        controller: controllerConfirmPassword,
                                        hint: 'Digite sua senha',
                                        label: 'Confirme a senha',
                                        obscure: obscure,
                                        onPressedObscure: passwordObscureController.changeObscure,
                                        suffixObscure: true,
                                        validator: (value) {
                                          if (controllerPassword.text ==
                                              controllerConfirmPassword.text) {
                                            return null;
                                          } else {
                                            if(!focus){
                                              focusConfirmPassword.requestFocus();
                                              setState(() => focus = true);
                                            }
                                            return "As senhas não são iguais";
                                          }
                                        },
                                        focusNode: focusConfirmPassword,
                                        onFieldSubmitted: (value){
                                          signUp();

                                          return null;
                                        },
                                      ),
                                    ],
                                  );
                                }
                            ),
                            const SizedBox(height: 24),
                            ElevatedCustom(
                                text: 'Cadastrar',
                                onPressed: (){
                                  signUp();
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
