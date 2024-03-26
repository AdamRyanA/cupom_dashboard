import 'package:cupom_dashboard/app/pages/pages.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const String rSplash = '/';
  static const String rHome = '/home';
  static const String rSignIn = '/signIn';
  static const String rSignUp = '/signUp';

  static Route<dynamic>? generateRoute(RouteSettings settings){
    //ScreenArguments? args = settings.arguments as ScreenArguments?;
    switch (settings.name) {
      case rSplash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case rHome:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case rSignIn:
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case rSignUp:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      default:
        return _erroRoute();
    }
  }

  static Route<dynamic> _erroRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Tela não encontrada!"),
        ),
        body: const Center(
          child: Text("Tela não encontrada"),
        ),
      );
    });
  }

}