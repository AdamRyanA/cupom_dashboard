import 'package:cupom_dashboard/app/pages/Auth/auth_page.dart';
import 'package:cupom_dashboard/app/pages/Auth_Home/auth_home_page.dart';
import 'package:cupom_dashboard/app/pages/Auth_Password/auth_password.dart';
import 'package:cupom_dashboard/app/pages/Company_Address/company_address_page.dart';
import 'package:cupom_dashboard/app/pages/Company_Edit/company_edit.dart';
import 'package:cupom_dashboard/app/pages/Company_Review/company_review_page.dart';
import 'package:cupom_dashboard/app/pages/Home/home_page.dart';
import 'package:cupom_dashboard/data/models/models.dart';
import 'package:flutter/material.dart';
import '../pages/Splash/splash_page.dart';

class RouteGenerator {
  static const String rSplash = '/';
  static const String rHome= '/home';
  static const String rAuth= '/auth';
  static const String rAuthRegister= '/auth';
  static const String rAuthPassword= '/auth_password';
  static const String rAuthHome= '/auth_home';
  static const String rCompanyEdit= '/company_edit';
  static const String rCompanyAddress= '/company_address';
  static const String rCompanyReview= '/company_review';

  static Route<dynamic>? generateRoute(RouteSettings settings){
    ScreenArguments? args = settings.arguments as ScreenArguments?;
    switch (settings.name) {
      case rSplash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case rHome:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case rAuth:
        return MaterialPageRoute(builder: (_) => const AuthPage());
      case rAuthPassword:
        return MaterialPageRoute(builder: (_) => AuthPassword(args));
      case rAuthHome:
        return MaterialPageRoute(builder: (_) => AuthHomePage(args));
      case rCompanyEdit:
        return MaterialPageRoute(builder: (_) => CompanyEdit(args));
      case rCompanyAddress:
        return MaterialPageRoute(builder: (_) => CompanyAddressPage(args));
      case rCompanyReview:
        return MaterialPageRoute(builder: (_) => CompanyReviewPage(args));
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