import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../domain/usecases/Authentication.dart';
import '../../utils/colors.dart';
import '../../utils/paths.dart';
import '../../widgets/AuthRecover.dart';
import '../../widgets/AuthRegister.dart';
import '../../widgets/ResponsiveView.dart';
import 'auth_controller.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with SingleTickerProviderStateMixin{

  //Animation Controller
  late AnimationController _animationController;
  late Animation<double> _animationFade;
  late Animation<double> _animationSize;

  bool cadastro = true;
  bool loading = false;

  bool internet = true;

  late BuildContext contextNew;
  late BuildContext contextDialog;
  late BuildContext contextDialogError;


  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final authController = AuthController();

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

  signInUser() async{
    if (!loading) {
      if (_formKey.currentState!.validate()) {
        if (kDebugMode) {
          print("Validado");
        }
        setState(() {
          loading = true;
        });
        await Authentication.signInWithEmail(
            context: context,
            email: _controllerEmail.text,
            password: _controllerPassword.text
        );
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

  resetPasswordUser() async {
    if (_formKey.currentState!.validate()) {
      if (loading == false) {
        loading = true;
        showDialog(
          context: contextDialog,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Center(
                child: CircularProgressIndicator(
                  backgroundColor: primaryColor,
                ),
              ),
            );
          },
        );
        String? message = await Authentication.resetPassword(email: _controllerEmail.text);
        if (message == "Você receberá um link de redefinição de senha se o e-mail fornecido estiver associado a uma conta válida.") {

          if (kDebugMode) {
            print(message);
          }
          if (contextDialog.mounted) Navigator.pop(contextDialog);
          loading = false;
          cadastro = true;
          EasyLoading.showToast("$message");
        }else{
          loading = false;
          EasyLoading.showToast("$message");
          if (contextDialog.mounted) Navigator.pop(contextDialog);
        }
      }else{
        if (kDebugMode) {
          print("Process already running");
        }
      }
    }else{
      if (kDebugMode) {
        print("Not validate");
      }
    }
    setState(() {

    });
  }

  changeOption() {
    setState(() {
      cadastro = !cadastro;
      _controllerEmail.clear();
      _controllerPassword.clear();
      authController.valid.value = false;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    contextNew = context;
    contextDialog = context;
    contextDialogError = context;
    Orientation deviceOrientation = MediaQuery.of(context).orientation;
    return ResponsiveViewMaxWidthBox(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var altura = constraints.maxHeight;
          var largura = constraints.maxWidth;
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          return Scaffold(
              backgroundColor: primaryColor,
              body: SizedBox(
                  width: largura,
                  height: altura,
                  child: Center(
                    child: largura < 760
                        ? WidgetDecision(
                        cadastro,
                        loading,
                        authController,
                        signInUser,
                        resetPasswordUser,
                        changeOption,
                        _formKey,
                        _controllerEmail,
                        _controllerPassword,
                        altura,
                        largura,
                        _animationFade
                    )
                        : Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: primaryColor,
                            child: FadeTransition(
                              opacity: _animationFade,
                              child: Image.asset(ImagesPath.logo,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                              color: whiteColor,
                              padding: const EdgeInsets.all(20),
                              child: WidgetDecision(
                                  cadastro,
                                  loading,
                                  authController,
                                  signInUser,
                                  resetPasswordUser,
                                  changeOption,
                                  _formKey,
                                  _controllerEmail,
                                  _controllerPassword,
                                  altura,
                                  largura,
                                  _animationFade
                              )
                          ),
                        ),
                      ],
                    ),
                  )
              ),
          );
        },
      ),
    );
  }
}


class WidgetDecision extends StatelessWidget {
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
  const WidgetDecision(
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
    return decision
        ? AuthRegister(decision, loading, authController, onPressed, onPressedChange, formKey, emailController, passwordController, altura, largura, animationFade)
        : AuthRecover(decision, loading, authController, onPressedRecover, onPressedChange, formKey, emailController, passwordController, altura, largura, animationFade);
  }
}
