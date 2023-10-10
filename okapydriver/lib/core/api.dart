import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:okapydriver/models/authmodel.dart';
import 'package:okapydriver/models/user.dart';
import 'package:okapydriver/utils/constants.dart';
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

  Future<Response> postHeaders({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      AuthModel user =
          AuthModel.fromJson(jsonDecode(prefs.getString('token')!));

      return _dio.post(serverUrl + url,
          data: data,
          options: Options(
              responseType: ResponseType.json,
              headers: <String, String>{
                'authorization': 'Token ${user.key}',
                'accept': 'application/json'
              },
              validateStatus: (status) {
                print("Status is $status");
                if (status == 500) {
                  print("Server error");
                }
                return status! < 513;
              }));
    } catch (error, stacktrace) {
      print("Error is $error, $stacktrace");
      rethrow;
    }
  }

  Future<Response> patch({
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
              'authorization': 'Token ${user.key}',
              'accept': 'application/json'
            },
            validateStatus: (status) {
              return status! < 500;
            }));
  }

  Future<Response> patchFormData({
    required String url,
    required data,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    AuthModel user = AuthModel.fromJson(jsonDecode(prefs.getString('token')!));
    print("The token is ${user.key}");
    return _dio.patch(serverUrl + url,
        data: data,
        options: Options(
            responseType: ResponseType.json,
            contentType: 'multipart/form-data',
            headers: <String, String>{
              'authorization': 'Token ${user.key}',
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
    print(user.key);
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
    AuthModel user = AuthModel.fromJson(jsonDecode(prefs.getString('token')!));

    return _dio.post(serverUrl + url,
        data: data,
        options: Options(
            responseType: ResponseType.json,
            contentType: 'multipart/form-data',
            headers: <String, String>{
              'authorization': "Token ${user.key}",
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

    try {
      final prefs = await SharedPreferences.getInstance();
      AuthModel authModel =
          AuthModel.fromJson(jsonDecode(prefs.getString('token')!));

      return _dio.get('$serverUrl$endpoint',
          // queryParameters: param,
          options: Options(headers: <String, String>{
            'authorization': 'Token ${authModel.key}',
            'accept': 'application/json'
          }));
    } catch (error, stacktrace) {
      print("Error is $error, $stacktrace");
      rethrow;
    }
  }

  Future getDataToken({
    required String endpoint,
    Map<String, dynamic>? param,
  }) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    AuthModel user = AuthModel.fromJson(jsonDecode(prefs.getString('token')!));
    print(user.key);

    return _dio.get('$serverUrl$endpoint',
        options: Options(headers: <String, String>{
          'Authorization': "Token ${user.key}",
          'accept': 'application/json'
        }));
  }

  Future putData({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    // User user = User.fromJson(jsonDecode(prefs.getString('creds')!));
    AuthModel user = AuthModel.fromJson(jsonDecode(prefs.getString('token')!));

    return _dio.put('$serverUrl$url',
        data: data,
        options: Options(headers: <String, String>{
          'authorization': "Token ${user.key}",
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
