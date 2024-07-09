import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../data/helpers/dio_helper.dart';
import '../../data/models/response_api.dart';
import '../../data/utils/base_url.dart';
import 'Authentication.dart';

class OfferProcess {

  static Future<ResponseAPI?> get({
    required String? company,
  }) async {
    FirebaseAuth user = Authentication.auth;
    String? uid = user.currentUser?.uid;

    if (uid != null) {
      String url = "${ApiReduu.offer}$company";
      if (kDebugMode) {
        print(url);
      }

      ResponseAPI? responseResult = await DioHelper.get(
          url: url,
      );
      return responseResult;
    }else{
      if (kDebugMode) {
        print("No user uid");
      }
      return null;
    }

  }

  static Future<ResponseAPI?> post({
    required String? company,
    required String? name,
    required String? category,
    required String? categoryOffer,
    required String? descriptionOffer,
    required String? photo,
    required String? typeOffer,
    required String? mondayStart,
    required String? mondayEnd,
    required String? tuesdayStart,
    required String? tuesdayEnd,
    required String? wednesdayStart,
    required String? wednesdayEnd,
    required String? thursdayStart,
    required String? thursdayEnd,
    required String? fridayStart,
    required String? fridayEnd,
    required String? saturdayStart,
    required String? saturdayEnd,
    required String? sundayStart,
    required String? sundayEnd,
  }) async {
    FirebaseAuth user = Authentication.auth;
    String? uid = user.currentUser?.uid;

    if (uid != null) {
      String url = "${ApiReduu.offer}$company";
      if (kDebugMode) {
        print(url);
      }

      Map<String, dynamic> data = {
        "name": name,
        "category": category,
        "categoryOffer": categoryOffer,
        "descriptionOffer": descriptionOffer,
        "photo": photo,
        "typeOffer": typeOffer,
        "mondayStart": mondayStart,
        "mondayEnd": mondayEnd,
        "tuesdayStart": tuesdayStart,
        "tuesdayEnd": tuesdayEnd,
        "wednesdayStart": wednesdayStart,
        "wednesdayEnd": wednesdayEnd,
        "thursdayStart": thursdayStart,
        "thursdayEnd": thursdayEnd,
        "fridayStart": fridayStart,
        "fridayEnd": fridayEnd,
        "saturdayStart": saturdayStart,
        "saturdayEnd": saturdayEnd,
        "sundayStart": sundayStart,
        "sundayEnd": sundayEnd,
      };

      if (kDebugMode) {
        print(data);
      }

      ResponseAPI? responseResult = await DioHelper.post(
          url: url,
          data: data
      );
      return responseResult;
    }else{
      if (kDebugMode) {
        print("No user uid");
      }
      return null;
    }

  }

  static Future<ResponseAPI?> put({
    required String? id,
    required String? company,
    required String? name,
    required String? category,
    required String? categoryOffer,
    required String? descriptionOffer,
    required String? photo,
    required String? typeOffer,
    required String? mondayStart,
    required String? mondayEnd,
    required String? tuesdayStart,
    required String? tuesdayEnd,
    required String? wednesdayStart,
    required String? wednesdayEnd,
    required String? thursdayStart,
    required String? thursdayEnd,
    required String? fridayStart,
    required String? fridayEnd,
    required String? saturdayStart,
    required String? saturdayEnd,
    required String? sundayStart,
    required String? sundayEnd,
  }) async {
    FirebaseAuth user = Authentication.auth;
    String? uid = user.currentUser?.uid;

    if (uid != null) {
      String url = "${ApiReduu.offer}$company";
      if (kDebugMode) {
        print(url);
      }

      Map<String, dynamic> data = {
        "id": id,
        "name": name,
        "category": category,
        "categoryOffer": categoryOffer,
        "descriptionOffer": descriptionOffer,
        "photo": photo,
        "typeOffer": typeOffer,
        "mondayStart": mondayStart,
        "mondayEnd": mondayEnd,
        "tuesdayStart": tuesdayStart,
        "tuesdayEnd": tuesdayEnd,
        "wednesdayStart": wednesdayStart,
        "wednesdayEnd": wednesdayEnd,
        "thursdayStart": thursdayStart,
        "thursdayEnd": thursdayEnd,
        "fridayStart": fridayStart,
        "fridayEnd": fridayEnd,
        "saturdayStart": saturdayStart,
        "saturdayEnd": saturdayEnd,
        "sundayStart": sundayStart,
        "sundayEnd": sundayEnd,
      };

      if (kDebugMode) {
        print(data);
      }

      ResponseAPI? responseResult = await DioHelper.put(
          url: url,
          data: data
      );
      return responseResult;
    }else{
      if (kDebugMode) {
        print("No user uid");
      }
      return null;
    }

  }

  static Future<ResponseAPI?> delete({
    required String? id,
    required String? company,
  }) async {
    FirebaseAuth user = Authentication.auth;
    String? uid = user.currentUser?.uid;

    if (uid != null) {
      String url = "${ApiReduu.offer}$company";
      if (kDebugMode) {
        print(url);
      }

      Map<String, dynamic> data = {
        "id": id,
      };

      if (kDebugMode) {
        print(data);
      }

      ResponseAPI? responseResult = await DioHelper.delete(
          url: url,
          data: data
      );
      return responseResult;
    }else{
      if (kDebugMode) {
        print("No user uid");
      }
      return null;
    }

  }

}