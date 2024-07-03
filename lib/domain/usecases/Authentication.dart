import 'dart:async';

import 'package:cupom_dashboard/domain/usecases/company_process.dart';
import 'package:cupom_dashboard/domain/usecases/userSubscription.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../app/utils/route_generator.dart';
import '../../data/models/response_api.dart';
import '../../data/models/screen_arguments.dart';
import '../../data/models/user_client.dart';


class Authentication {

  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future checkUser(BuildContext context, bool startScreen) async {
    User? usuarioLogado = auth.currentUser;
    try {
      if (usuarioLogado != null) {
        if (kDebugMode) {
          print("usuario logado");
          print(usuarioLogado.emailVerified);
        }
        ResponseAPI? responseAPI = await CompanyProcess.get();
        ScreenArguments screenArgumentsNavigator = ScreenArguments();
        screenArgumentsNavigator.company = responseAPI?.company;
        if (screenArgumentsNavigator.company?.address?.city != null) {
          Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.rAuthHome, (route) => false, arguments: screenArgumentsNavigator);
        }else{
          Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.rCompanyEdit, (route) => false, arguments: screenArgumentsNavigator);
        }
      } else {
        if (startScreen) {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteGenerator.rAuth, (_) => false);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      await signOut(context);
    }
  }

  /*
  static Future<String?> signInWithGoogle({required BuildContext context}) async {
    await Firebase.initializeApp();

    late String user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn().catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      return null;
    });

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);

        user = userCredential.user!.uid;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          if (context.mounted) {
            showSnackBar(context, 'Conta já existe com conta do Facebook, necessário vincular ela após logar com Facebook');
          }
        } else if (e.code == 'invalid-credential') {
          if (context.mounted) {
            showSnackBar(context, 'Ocorreu um erro ao tentar logar com as credenciais. Tente novamente.');
          }
        }
      } catch (e) {
        if (context.mounted) {
          showSnackBar(context, 'Ocorreu um erro ao logar na conta Google. Tente novamente.'
              '\nErro: $e');
        }
      }
    }
    if (auth.currentUser != null) {
      if (context.mounted) {
        checkUser(context, false);
        return user;
      }
    }
    return null;
  }

  static Future<User?> signInWithApple(BuildContext context) async {
    User? user;


    /// Generates a cryptographically secure random nonce, to be included in a
    /// credential request.
    String generateNonce([int length = 32]) {
      const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
      final random = Random.secure();
      return List.generate(
          length, (_) => charset[random.nextInt(charset.length)]).join();
    }

    /// Returns the sha256 hash of [input] in hex notation.
    String sha256ofString(String input) {
      final bytes = utf8.encode(input);
      final digest = sha256.convert(bytes);
      return digest.toString();
    }

    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    final isAvailable = await SignInWithApple.isAvailable();
    if (isAvailable) {
      try {
        // Request credential for the currently signed in Apple account.
        final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          nonce: nonce,
        );
        if (kDebugMode) {
          print("${appleCredential.givenName} ${appleCredential.familyName}");
          print(appleCredential.email);
        }

        // Create an `OAuthCredential` from the credential returned by Apple.
        final oauthCredential = OAuthProvider("apple.com").credential(
          idToken: appleCredential.identityToken,
          rawNonce: rawNonce,
          accessToken: appleCredential.authorizationCode,
        );

        try {
          // Sign in the user with Firebase. If the nonce we generated earlier does
          // not match the nonce in `appleCredential.identityToken`, sign in will fail.
          final UserCredential userCredential =
          await auth.signInWithCredential(oauthCredential);
          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            if (kDebugMode) {
              print(
                e.toString(),
              );
            }
            final signInMethods = await auth.fetchSignInMethodsForEmail(
                "${e.email}");
            for (var element in signInMethods) {
              if (kDebugMode) {
                print(element);
              }
            }
            showToast(context,
                'The account already exists with a different credential.');
          } else if (e.code == 'invalid-credential') {
            if (kDebugMode) {
              print(e.toString());
            }
            showToast(context,
                'Error occurred while accessing credentials. Try again.');
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
          showToast(context,
              'Error occurred using Apple Sign-In. Try again. Erro: ${e
                  .toString()}');
        }

        if (auth.currentUser != null) {
          showToast(context, 'Conexão bem sucedida');
          checkUser(context, false);
        }
      } catch (e) {
        if (kDebugMode) {
          print('Cancelado a tentativa de login Apple');
          print(e.toString());
        }
      }
    } else {
      if (kDebugMode) {
        print('Login com a Apple não disponível');
      }
    }

    return user;
  }
   */

  static Future<String?> createUserWithEmail({
    required BuildContext context,
    UserClient? usuario,
    required String password
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: "${usuario!.email}",
          password: password
      );
      if (auth.currentUser != null) {
        await auth.currentUser?.updateDisplayName(usuario.displayName);
      }
      return "OK";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
        EasyLoading.showToast('A senha fornecida é muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
        EasyLoading.showToast('A conta já existe para esse e-mail.');
      } else if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email.');
        }
        EasyLoading.showToast('Nenhum usuário encontrado para esse e-mail.');
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
        EasyLoading.showToast('Senha errada. Tente novamente.');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  static Future<String> signInWithEmail({
    required BuildContext context,
    required String email,
    required String password
  }) async {
    String message = "OK";
    try {
      await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      Authentication.checkUser(context, false);
      EasyLoading.showToast(message);
      return message;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email.');
        }
        message = "Nenhum usuário encontrado para esse e-mail.";
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
        message = "Senha errada. Tente novamente";
      }else{
        message = e.toString();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      message = e.toString();
    }
    EasyLoading.showToast(message);
    return message;
  }

  static Future<UserCredential?> updatePassword(BuildContext context, String password) async {

    UserCredential? user;
    try {
      if (auth.currentUser?.uid != null) {

        ResponseAPI? responseApi;// = await  DashboardProcess.postUserPassword(password);

        if (responseApi != null) {
          ScreenArguments screenArguments = ScreenArguments();
          screenArguments.userClient = responseApi?.user;
          EasyLoading.showToast("Atualizado a senha com sucesso!!!");
        }else{
          EasyLoading.showToast("Erro ao trocar senha. Tente novamente mais tarde");
          auth.signOut();
        }
        Authentication.checkUser(context, false);
        return user;
      }
    } catch (e) {
      EasyLoading.showToast(e.toString());
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;

  }

  static Future<void> signOut(BuildContext context) async {
    EasyLoading.show(status: "Saindo...");
    /*
    final GoogleSignIn googleSignOut = GoogleSignIn();
    try {
      await googleSignOut.disconnect();
    } catch (error) {
      if (kDebugMode) {
        print("Sem conta do Google");
      }
    }
     */
    await auth.signOut();
    EasyLoading.dismiss();
    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.rSplash, (route) => false);
  }

  static Future<String?> resetPassword({
    required String email
  }) async {
    try {
      await auth.sendPasswordResetEmail(
          email: email
      );
      return "Você receberá um link de redefinição de senha se o e-mail fornecido estiver associado a uma conta válida.";
    } on FirebaseAuthException catch (e){
      if (kDebugMode) {
        print('Error Reset Password: $e');
      }
      return 'Error Reset Password: $e';
    }catch (error) {
      if (kDebugMode) {
        print("Reset Password Error: $error");
      }
      return 'Error Reset Password: $error';
    }
  }


}