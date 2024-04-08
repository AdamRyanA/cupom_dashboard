import 'dart:async';
import 'package:cupom_dashboard/app/utils/utils.dart';
import 'package:cupom_dashboard/domain/usecases/authentication.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  initialLoading() {
    Timer(const Duration(seconds: 1), () {
      Authentication.checkUser(context);
      //Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.rHome, (route) => false);
    });
  }

  @override
  void initState() {
    super.initState();
    initialLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 200,
            height: 200,
            child: Image.asset(
              ImagesPath.logo,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
