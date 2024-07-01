import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/response_api.dart';

class DioHelper {

  static Future<ResponseAPI?> get({
    required String url
  }) async {
    try {
      var response = await Dio().get(
          url
      );
      if (response.statusCode == 200 || response.statusCode == 201){
        var jsonData = response.data;
        ResponseAPI responseResult = ResponseAPI.fromJson(jsonData);
        return responseResult;
      }else{
        if (kDebugMode) {
          print("Erro ao tentar executar $url");
        }
        return null;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  static Future<ResponseAPI?> post({
    required String url,
    Map<String, dynamic>? data
  }) async {
    try {
      var response = await Dio().post(
          url,
          data: data
      );
      //print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201){
        var jsonData = response.data;
        ResponseAPI responseResult = ResponseAPI.fromJson(jsonData);
        return responseResult;
      }else{
        if (kDebugMode) {
          print("Erro ao tentar executar $url");
        }
        return null;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  static Future<ResponseAPI?> put({
    required String url,
    Map<String, dynamic>? data
  }) async {
    try {
      var response = await Dio().put(
          url,
          data: data
      );
      if (response.statusCode == 200 || response.statusCode == 201){
        var jsonData = response.data;
        ResponseAPI responseResult = ResponseAPI.fromJson(jsonData);
        return responseResult;
      }else{
        if (kDebugMode) {
          print("Erro ao tentar executar $url");
        }
        return null;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  static Future<ResponseAPI?> delete({
    required String url,
    Map<String, dynamic>? data
  }) async {
    try {
      var response = await Dio().delete(
          url,
          data: data
      );
      if (response.statusCode == 200 || response.statusCode == 201){
        var jsonData = response.data;
        ResponseAPI responseResult = ResponseAPI.fromJson(jsonData);
        return responseResult;
      }else{
        if (kDebugMode) {
          print("Erro ao tentar executar $url");
        }
        return null;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

}