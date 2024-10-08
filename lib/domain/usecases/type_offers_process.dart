import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../data/helpers/dio_helper.dart';
import '../../data/models/response_api.dart';
import '../../data/utils/base_url.dart';
import 'Authentication.dart';

class TypeOffersProcess {

  static Future<ResponseAPI?> get({
    required String categoryId
  }) async {
    FirebaseAuth user = Authentication.auth;
    String? uid = user.currentUser?.uid;

    if (uid != null) {
      String url = "${ApiReduu.typeoffers}$categoryId";
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

}