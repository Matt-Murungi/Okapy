import 'dart:io';

import 'package:dio/dio.dart';
import 'package:okapy_dashboard/core/data/local_data_source/local_storage.dart';
import 'package:okapy_dashboard/core/data/remote_data_source/constants.dart';
import 'package:okapy_dashboard/core/data/models/response_model.dart';

class ApiRequests {
  final _dio = Dio();
  ResponseModel? _responseModel;

  Future<ResponseModel?> postRequestWithNoHeaders(
      {required url, required Map<String, dynamic> data}) async {
    try {
      String finalUrl = "${NetworkConstant.serverUrl}$url";
      Response response = await _dio.post(finalUrl,
          data: data,
          options: Options(
              responseType: ResponseType.json,
              validateStatus: (status) {
                return status! <= HttpStatus.internalServerError;
              }));
      _responseModel = ResponseModel.fromJson({
        "statusCode": response.statusCode,
        "data": response.data,
      });
      return _responseModel;
    } catch (error) {
      rethrow;
    }
  }

  Future<ResponseModel?> getAddress(
      { required latitude, required longitude}) async {
    try {
      String apiKey = "AIzaSyALabqkm7xMLci3TqKQTebkBPgh3FJ1i-s";
      String finalUrl =
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';
      Response response = await _dio.get(finalUrl,
          options: Options(
              responseType: ResponseType.json,
              validateStatus: (status) {
                return status! <= HttpStatus.internalServerError;
              }));
      _responseModel = ResponseModel.fromJson({
        "statusCode": response.statusCode,
        "data": response.data,
      });
      return _responseModel;
    } catch (error) {
      rethrow;
    }
  }

  Future<ResponseModel?> getRequest({required url}) async {
    try {
      String finalUrl = "${NetworkConstant.serverUrl}$url";
      print("final url $finalUrl");
      final token = await LocalStorage.getUserToken();
      Response response = await _dio.get(finalUrl,
          options: Options(
            headers: <String, String>{
              'authorization': 'Token $token',
              'accept': 'application/json',
            },
          ));
      _responseModel = ResponseModel.fromJson({
        "statusCode": response.statusCode,
        "data": response.data,
      });
      return _responseModel;
    } catch (error) {
      rethrow;
    }
  }

  Future<ResponseModel?> postRequest(
      {required url, required Map<String, dynamic> data}) async {
    try {
      String finalUrl = "${NetworkConstant.serverUrl}$url";
      print("url is $finalUrl");

      final token = await LocalStorage.getUserToken();

      Response response = await _dio.post(finalUrl,
          data: data,
          options: Options(
              headers: <String, String>{
                'authorization': 'Token $token',
                'accept': 'application/json',
              },
              responseType: ResponseType.json,
              validateStatus: (status) {
                print(status);
                return status! <= HttpStatus.notImplemented;
              }));
      _responseModel = ResponseModel.fromJson({
        "statusCode": response.statusCode,
        "data": response.data,
      });
      print("Response model is ${_responseModel!.data}");
      return _responseModel;
    } catch (error) {
      print("Response model error is $error");
      rethrow;
    }
  }

  Future<ResponseModel?> patchRequest(
      {required url, required Map<String, dynamic> data}) async {
    try {
      String finalUrl = "${NetworkConstant.serverUrl}$url";
      final token = await LocalStorage.getUserToken();

      Response response = await _dio.patch(finalUrl,
          data: data,
          options: Options(
              headers: <String, String>{
                'authorization': 'Token $token',
                'accept': 'application/json',
              },
              responseType: ResponseType.json,
              validateStatus: (status) {
                print(status);
                return status! <= HttpStatus.notImplemented;
              }));
      _responseModel = ResponseModel.fromJson({
        "statusCode": response.statusCode,
        "data": response.data,
      });
      print("Response model is ${_responseModel!.data}");
      return _responseModel;
    } catch (error) {
      print("Response model error is $error");
      rethrow;
    }
  }
}
