import 'package:cupom_dashboard/app/utils/utils.dart';
import 'package:cupom_dashboard/data/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Authentication {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future checkUser(BuildContext context) async {
    User? usuarioLogado = auth.currentUser;
    try {
      if (usuarioLogado != null) {
        if (kDebugMode) {
          print("Usuario Logado!!!");
        }
        if (usuarioLogado.email == null) {
          await auth.signOut();
          if (!context.mounted) return;
          Navigator.pushNamedAndRemoveUntil(
              context, RouteGenerator.rHome, (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteGenerator.rCompanyPanel, (route) => false);
        }
      } else {
        if (kDebugMode) {
          print("Usuario Não Logado!!!");
        }
        Navigator.pushNamedAndRemoveUntil(
            context, RouteGenerator.rHome, (route) => false);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao Logar Usuario: ${e.toString()}");
      }
      await signOut(context);
    }
  }

  static Future<String?> signInWithEmail({required BuildContext context, required Company usuario, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: "${usuario.email}",
          password: password
      );
      return "OK";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email.');
        }
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  static Future<String?> createUserWithEmail({required BuildContext context, required Company usuario, required String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: "${usuario.email}",
          password: password
      );
      return "OK";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
      } else if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email.');
        }
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  static Future<void> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(
          email: email
      );
    } on FirebaseAuthException catch (e){
      if (kDebugMode) {
        print('Error Reset Password: $e');
      }
    }catch (error) {
      if (kDebugMode) {
        print("Reset Password Error: $error");
      }
    }
  }

  static Future<void> signOut(BuildContext context) async {
    await auth.signOut();
    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.rSplash, (route) => false);
  }
}