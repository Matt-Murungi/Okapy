import 'dart:io';

import 'package:flutter/material.dart';
import 'package:okapy_dashboard/auth/data/partner_model.dart';
import 'package:okapy_dashboard/auth/data/user_model.dart';
import 'package:okapy_dashboard/core/data/local_data_source/local_storage.dart';
import 'package:okapy_dashboard/core/data/remote_data_source/api_requests.dart';
import 'package:okapy_dashboard/core/data/remote_data_source/constants.dart';
import 'package:okapy_dashboard/core/data/remote_data_source/network_urls.dart';
import 'package:okapy_dashboard/core/utils/logger.dart';

import 'package:okapy_dashboard/core/utils/utils.dart';

class AuthController extends ChangeNotifier {
  final ApiRequests _request = ApiRequests();

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  UserModel? _user;
  UserModel? get user => _user;

  PartnerModel? _partner;
  PartnerModel? get partner => _partner;

  String get logo => NetworkConstant.logo;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  getLoginState() async {
    final loginState = await LocalStorage.getLoginState();
    print("getLoginState $loginState");
    if (loginState.toString().toLowerCase() == "true") {
      return true;
    } else {
      return false;
    }
  }

  Future loginUser() async {
    try {
      Map<String, String> loginDetails = {
        "email": emailController.text,
        "password": passwordController.text
      };
      _isLoading = true;
      final result = await _request.postRequestWithNoHeaders(
          url: NetworkUrl.methodLoginPartner, data: loginDetails);
      logger.d("LoginUser ${result!.statusCode} data ${result!.data}");
      if (result!.statusCode == HttpStatus.ok) {
        await LocalStorage.saveUserToken(result.data!["key"]);
        await LocalStorage.saveLoginState(true);

        return true;
      } else {
        if (result.data!.containsKey("non_field_errors")) {
          _errorMessage = replaceErrorStringBrackets(
              result.data!["non_field_errors"].toString());
        } else {
          _errorMessage = replaceErrorStringCurlyBrackets(
              replaceErrorStringBrackets(result.data.toString()));
        }
        // _isLoading = false;
        return false;
      }
    } catch (error) {
      _errorMessage = error.toString();
      logger.e("LoginUser $error");
      // _isLoading = false;
      rethrow;
    }
  }

  Future<UserModel?> fetchUserDetails() async {
    try {
      final result =
          await _request.getRequest(url: NetworkUrl.methodGetUserDetails);
      logger.d("fetchUserDetails ${result!.statusCode} data ${result.data}");
      if (result.statusCode == HttpStatus.ok) {
        _user = UserModel.fromJson(result.data);
        if (_user!.partner != null) {
          LocalStorage.saveIsPartner(true);
          LocalStorage.saveUserName(_user!.firstName.toString());
          LocalStorage.savePartnerId(_user!.partner.toString());
        } else {
          LocalStorage.saveIsPartner(false);
        }

        return user;
      } else {
        _errorMessage = replaceErrorStringCurlyBrackets(
            replaceErrorStringBrackets(result.data.toString()));
        return null;
      }
    } catch (error) {
      logger.e("fetchUserDetails Error $error");
      _errorMessage = replaceErrorStringCurlyBrackets(
          replaceErrorStringBrackets(error.toString()));
      rethrow;
    }
  }

  Future<PartnerModel?> fetchPartnerDetails() async {
    try {
      var partnerId = await LocalStorage.getPartnerId();
      final result = await _request.getRequest(
          url: "${NetworkUrl.methodPartnerDetails}/$partnerId/");
      logger.d("fetchPartnerDetails ${result!.statusCode} data ${result.data}");
      if (result.statusCode == HttpStatus.ok) {
        _partner = PartnerModel.fromJson(result.data);
        return _partner;
      } else {
        _errorMessage = result.data;
        return null;
      }
    } catch (error) {
      logger.e("fetchPartnerDetails Error $error");
      _errorMessage = error.toString();
      rethrow;
    }
  }

  Future<bool> saveFCMToken({required String token}) async {
    return await _request.postRequest(
      url: 'users/api/devices/',
      data: {'registration_id': token, 'type': "web"},
    ).then((value) {
      print("the fcm response is ${value?.data} ${value?.statusCode}");
      if (value?.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }).catchError((onError) {
      return false;
    });
  }

  Future logout() async {
    await LocalStorage.clearAllData();
    _user = UserModel();
    _partner = PartnerModel();
    return true;
  }
}
