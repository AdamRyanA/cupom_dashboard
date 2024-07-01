import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../data/helpers/dio_helper.dart';
import '../../data/models/response_api.dart';
import '../../data/utils/base_url.dart';
import 'Authentication.dart';

class CompanyProcess {

  static Future<ResponseAPI?> get() async {
    FirebaseAuth user = Authentication.auth;
    String? uid = user.currentUser?.uid;

    if (uid != null) {
      String url = "${ApiCupomRatata.company}$uid";
      if (kDebugMode) {
        print(url);
      }
      ResponseAPI? responseResult = await DioHelper.get(url: url);
      return responseResult;
    }else{
      if (kDebugMode) {
        print("No user uid");
      }
      return null;
    }

  }

  static Future<ResponseAPI?> post({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String docNumber,
  }) async {
    FirebaseAuth user = Authentication.auth;
    String? uid = user.currentUser?.uid;

    if (uid == null) {
      String url = "${ApiCupomRatata.company}new";
      if (kDebugMode) {
        print(url);
      }
      Map<String, dynamic> data = {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "docNumber": docNumber,
      };
      ResponseAPI? responseResult = await DioHelper.post(url: url, data: data);
      return responseResult;
    }else{
      if (kDebugMode) {
        print("No user uid");
      }
      return null;
    }

  }

}