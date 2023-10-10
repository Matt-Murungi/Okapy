import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:okapy/models/auth.dart';
import 'package:okapy/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Dio _dio = Dio();

  Future<Response> postNoHeaders({
    required String url,
    required Map<String, dynamic> data,
  }) {
    return _dio.post(serverUrl + url,
        data: data,
        options: Options(
            responseType: ResponseType.json,
            validateStatus: (status) {
              return status! < 500;
            }));
  }

  Future<Response?> postNoHeadersAuth({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    try {
      String path = "$serverUrl$url";
      final response = await _dio.post(path,
          data: data,
          options: Options(
              responseType: ResponseType.json,
              validateStatus: (status) {
                return status! < 500;
              }));
      if (response.statusCode! == HttpStatus.created) {
        return response;
      } else {
        return throw response.data;
      }
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectTimeout ||
          exception.type == DioErrorType.sendTimeout ||
          exception.type == DioErrorType.receiveTimeout ||
          exception.type == DioErrorType.other ||
          exception.type == DioErrorType.cancel) {
        throw kNoInternetConnection;
      } else {
        throw kInternalServerError;
      }
    }
  }

  Future<Response> postHeaders({
    required String url,
    required Map<dynamic, dynamic> data,
  }) async {
    print('url -----------$url');
    final prefs = await SharedPreferences.getInstance();
    // User user = User.fromJson(jsonDecode(prefs.getString('creds')!));
    AuthModel authModel =
        AuthModel.fromJson(jsonDecode(prefs.getString('token')!));

    return _dio.post(serverUrl + url,
        data: data,
        options: Options(
            responseType: ResponseType.json,
            headers: <String, String>{
              'authorization': 'Token ${authModel.key}',
              'accept': 'application/json'
            },
            validateStatus: (status) {
              return status! < 500;
            }));
  }

  Future<Response> patch({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    // User user = User.fromJson(jsonDecode(prefs.getString('creds')!));
    AuthModel authModel =
        AuthModel.fromJson(jsonDecode(prefs.getString('token')!));

    return _dio.patch(serverUrl + url,
        data: data,
        options: Options(
            responseType: ResponseType.json,
            headers: <String, String>{
              'authorization': 'Token ${authModel.key}',
              'accept': 'application/json'
            },
            validateStatus: (status) {
              return status! < 500;
            }));
  }

  Future<Response> patchToken({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    AuthModel user = AuthModel.fromJson(jsonDecode(prefs.getString('token')!));

    return _dio.patch(serverUrl + url,
        data: data,
        options: Options(
            responseType: ResponseType.json,
            headers: <String, String>{
              'Authorization': "Token ${user.key}",
              'accept': 'application/json'
            },
            validateStatus: (status) {
              return status! < 500;
            }));
  }

  Future<Response> postHeadersFormData({
    required String url,
    required data,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    //   User user = User.fromJson(jsonDecode(prefs.getString('creds')!));
    AuthModel authModel =
        AuthModel.fromJson(jsonDecode(prefs.getString('token')!));

    return _dio.post(serverUrl + url,
        data: data,
        options: Options(
            responseType: ResponseType.json,
            contentType: 'multipart/form-data',
            headers: <String, String>{
              'authorization': 'Token ${authModel.key}',
              'accept': 'application/json'
            },
            validateStatus: (status) {
              return status! < 500;
            }));
  }

  Future<Response> postHeadersFormDataToken({
    required String url,
    required data,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    AuthModel userToken =
        AuthModel.fromJson(jsonDecode(prefs.getString('token')!));

    return _dio.post(serverUrl + url,
        data: data,
        options: Options(
            responseType: ResponseType.json,
            contentType: 'multipart/form-data',
            headers: <String, String>{
              'Authorization': "Token ${userToken.key}",
              'accept': 'application/json'
            },
            validateStatus: (status) {
              return status! < 500;
            }));
  }

  Future<Response> getData({
    required String endpoint,
    Map<String, dynamic>? param,
  }) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    AuthModel authModel =
        AuthModel.fromJson(jsonDecode(prefs.getString('token')!));

    print("The token is ${authModel.key}");
    return _dio.get('$serverUrl$endpoint',
        // queryParameters: param,
        options: Options(headers: <String, String>{
          'Authorization': 'Token ${authModel.key}',
          'accept': 'application/json'
        }));
  }

  Future putData({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    AuthModel authModel =
        AuthModel.fromJson(jsonDecode(prefs.getString('token')!));

    return _dio.put('$serverUrl$url',
        data: data,
        options: Options(headers: <String, String>{
          'authorization': "Token ${authModel.key}",
          'accept': 'application/json'
        }));
  }

  Future getRawUrl({required String url}) {
    return _dio.get(url);
  }
  // Future getRawUrl({required String url}) {
  //   return _dio.delete(url);
  // }
}
