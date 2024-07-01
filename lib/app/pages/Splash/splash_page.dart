import 'dart:async';
import 'package:cupom_dashboard/app/utils/utils.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  initialLoading() {
    Timer(const Duration(seconds: 1), () {
      Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.rHome, (route) => false);
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
      backgroundColor: primaryColor,
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
