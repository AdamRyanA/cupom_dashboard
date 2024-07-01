
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../data/models/screen_arguments.dart';
import '../../../domain/usecases/Authentication.dart';
import '../../utils/colors.dart';
import '../../utils/paths.dart';
import '../../widgets/InputRegister.dart';
import 'auth_password_controller.dart';


class AuthPassword extends StatefulWidget {
  final ScreenArguments? screenArguments;
  const AuthPassword(this.screenArguments, {super.key});

  @override
  _AuthPasswordState createState() => _AuthPasswordState();
}

class _AuthPasswordState extends State<AuthPassword> with SingleTickerProviderStateMixin{

  //Animation Controller
  late AnimationController _animationController;
  late Animation<double> _animationFade;
  late Animation<double> _animationSize;


  bool internet = true;
  bool loading = false;

  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerPasswordConfirm = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final authController = AuthPasswordController();

  @override
  void initState() {
    super.initState();


    //Animation
    _animationController = AnimationController(
        duration: const Duration(seconds: 3),
        vsync: this
    );

    _animationFade = Tween<double>(
        begin: 0,
        end: 1
    ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.bounceOut,
        )
    );

    _animationSize = Tween<double>(
      begin: 1,
      end: 200,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceOut,
    ));

    _animationController.forward();
  }

  updatePassword() async{
    if (!loading) {
      if (_formKey.currentState!.validate()) {
        if (kDebugMode) {
          print("Validado");
        }
        setState(() {
          loading = true;
        });
        await Authentication.updatePassword(context, _controllerPassword.text);
        setState(() {
          loading = false;
        });
      }else{
        if (kDebugMode) {
          print("Não validado");
        }
      }
    }else{
      if (kDebugMode) {
        print("Aguarde o fim do processamento");
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Orientation deviceOrientation = MediaQuery.of(context).orientation;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var altura = constraints.maxHeight;
        var largura = constraints.maxWidth;
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        return Scaffold(
            backgroundColor: whiteColor,
            body: Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: const BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    color: primaryColor,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 200,
                                child: FadeTransition(
                                  opacity: _animationFade,
                                  child: Image.asset(ImagesPath.logo,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                              ValueListenableBuilder(
                                valueListenable: authController.password,
                                builder: (_, value, __) {
                                  return InputRegister(
                                    colorCard: primaryColor,
                                    texto: 'Nova Senha',
                                    controllerName: _controllerPassword,
                                    password: true,
                                    onChange: (value)  {
                                      authController.password.value = value;
                                      authController.checkValidate();
                                    },
                                    hintText: "Digite a sua senha",
                                    validator: (valor) {
                                      if (_controllerPassword.text.length >= 6) {
                                        if (_controllerPasswordConfirm.text == _controllerPassword.text){
                                          return null;
                                        }else{
                                          return "As senhas precisam ser iguais";
                                        }
                                      }else{
                                        return "Senha precisa ter 6 caracteres";
                                      }
                                    },
                                    onSubmitted: (valor) {
                                      updatePassword();
                                    },
                                  );
                                },
                              ),
                              ValueListenableBuilder(
                                valueListenable: authController.confirmPassword,
                                builder: (_, value, __) {
                                  return InputRegister(
                                    colorCard: primaryColor,
                                    texto: 'Confirmar senha',
                                    controllerName: _controllerPasswordConfirm,
                                    password: true,
                                    onChange: (value)  {
                                      authController.confirmPassword.value = value;
                                      authController.checkValidate();
                                    },
                                    hintText: "Confirme a sua senha",
                                    validator: (valor) {
                                      if (_controllerPasswordConfirm.text.length >= 6) {
                                        if (_controllerPasswordConfirm.text == _controllerPassword.text){
                                          return null;
                                        }else{
                                          return "As senhas precisam ser iguais";
                                        }
                                      }else{
                                        return "Senha precisa ter 6 caracteres";
                                      }
                                    },
                                    onSubmitted: (valor) {
                                      updatePassword();
                                    },
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
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
                                            updatePassword();
                                          }
                                        } : null,
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: !loading ? whiteColor : blackColor,
                                          backgroundColor: !loading ? primaryColor : Colors.grey,
                                          disabledBackgroundColor: Colors.grey,
                                          disabledForegroundColor: blackColor,
                                        ),
                                        child: const Text("Alterar senha")
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                  ),
                ),
              ),
            )
        );
      },
    );
  }
}
