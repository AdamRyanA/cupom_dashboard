import 'package:cupom_dashboard/app/pages/Splash/splash_page.dart';
import 'package:cupom_dashboard/app/utils/utils.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reduu',
      //home: SplashPage(),
      home: SplashPage(),
      //initialRoute: '/',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
