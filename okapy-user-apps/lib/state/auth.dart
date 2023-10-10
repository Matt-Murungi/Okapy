import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:okapy/core/api.dart';
import 'package:okapy/core/locator.dart';
import 'package:okapy/core/utils/logger.dart';
import 'package:okapy/models/auth.dart';
import 'package:okapy/models/user.dart';
import 'package:okapy/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  AuthModel? _authModel;
  AuthModel? get authModel => _authModel;
  Api _api = locator<Api>();
  String? fname;
  String? lname;
  String? phoneNumber;
  String? uemail;
  UserModel? _userModel;
  UserModel? get userModel => _userModel;
  bool _busy = false;
  bool get busy => _busy;
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Auth() {
    setUpAuth();
  }

  sendOTP() async {
    logger.d('The logins are ${{
      'phonenumber': phoneNumber,
    }}');
    return await _api.postNoHeaders(
      url: 'custom/auth/request/otp/',
      data: {
        'phonenumber': phoneNumber,
      },
    ).then((value) {
      logger.d("the response is ${value.data}");
      if (value.statusCode == 200) {
        return true;
      } else {
        return throw value.data;
      }
    }).catchError((onError) {
      return throw onError;
    });
  }

  Future<bool> sendOTPConfirmation(
      {required String otp, required String phone}) async {
    final prefs = await SharedPreferences.getInstance();
    logger.d("sendOTPConfirmation started with $otp and $phone");

    return await _api.postNoHeaders(
        url: 'custom/auth/confirm/otp/',
        data: {'otp': otp, 'phonenumber': phone}).then((value) {
      logger.d("sendOTPConfirmation ${value.data}  code ${value.statusCode}");
      if (value.statusCode == 200) {
        _authModel = AuthModel.fromJson(value.data);
        // _rooms = Room.fromJson(value.data);
        prefs.setString(
            'creds',
            jsonEncode({
              'userName': phone,
            }));

        prefs.setString('token', jsonEncode({'key': _authModel!.key}));
        notifyListeners();
        return true;
      } else {
        return false;
      }
    }).catchError((onError) {
      logger.d("sendOTPConfirmation ${onError}");
      logger.d(onError);
      return false;
    });
  }

  setUpAuth() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('creds') == null) {
      _isLoggedIn = false;
      notifyListeners();
      logger.d("setUpAuth false");
    } else {
      User user = User.fromJson(jsonDecode(prefs.getString('creds')!));
      _isLoggedIn = true;
      logger.d("setUpAuth true");
      getUser();
      notifyListeners();
    }
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      logger.d("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  setnames({required String name1, required String name2}) {
    fname = name1;
    lname = name2;
    notifyListeners();
  }

  setPhone({
    required String pNumber,
  }) {
    logger.d(phoneNumber);
    phoneNumber = pNumber;
    notifyListeners();
  }

  Future<bool> login({required String phone}) async {
    try {
      logger.d('The logins are ${{
        'phonenumber': phone,
      }}');
      var response =
          await _api.postNoHeaders(url: 'custom/auth/request/otp/', data: {
        'phonenumber': phone,
      });

      logger.d("the response is ${response.data} ${response.statusCode}");
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      logger.d(error);
      return false;
    }
  }

  Future<bool> saveFCMToken({required String token}) async {
    logger.d("The fcm token is $token");
    return await _api.postHeaders(
      url: 'users/api/devices/',
      data: {'registration_id': token, 'type': Platform.operatingSystem},
    ).then((value) {
      logger.d("the fcm response is ${value.data} ${value.statusCode}");
      if (value.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }).catchError((onError) {
      return false;
    });
  }

  Future registration({required String email}) async {
    final prefs = await SharedPreferences.getInstance();
    uemail = email;
    logger.d({
      "email": email,
      "first_name": fname,
      "last_name": lname,
      "phonenumber": phoneNumber
    });
    notifyListeners();
    return await _api.postNoHeadersAuth(
      url: 'custom/auth/user/registration/',
      data: {
        "email": email,
        "first_name": fname,
        "last_name": lname,
        "phonenumber": phoneNumber
      },
    ).then((value) {
      _authModel = AuthModel.fromJson(value!.data);
      prefs.setString(
          'creds',
          jsonEncode({
            'userName': email,
          }));

      prefs.setString('token', jsonEncode({'key': _authModel!.key}));
      sendOTP();
      return true;
      // }
    }).catchError((onError) {
      if (onError is Map && onError.containsKey('non_field_errors')) {
        return throw onError['non_field_errors'][0];
      } else if (onError is Map && onError.containsKey('email')) {
        return throw onError['email'][0];
      } else {
        logger.d("OnError $onError");
        return throw onError;
      }
    });
  }

  Future<void> getUser() async {
    _busy = true;
    notifyListeners();
    await _api.getData(endpoint: 'auth/user/').then((value) {
      logger.d(value.data);
      _userModel = UserModel.fromJson(value.data);
      logger.d("_userModel is ${_userModel.toString()}");
      phoneNumber = _userModel?.phonenumber;
      _busy = false;
      notifyListeners();
    });
  }

  getUserP() async {
    _busy = true;
    notifyListeners();
    return await _api.getData(endpoint: 'auth/user/').then((value) {
      logger.d("The user is ${value.data}");
      _userModel = UserModel.fromJson(value.data);
      phoneNumber = _userModel?.phonenumber!;
      _busy = false;
      notifyListeners();
    });
  }

  Future updateUser(
      {required String fname,
      required String lname,
      required String pNumber,
      required String email}) async {
    // logger.d();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', jsonEncode({'key': _authModel!.key}));
    uemail = email;
    notifyListeners();
    return await _api.patchToken(
      url: 'auth/user/',
      data: {
        "email": email,
        "first_name": fname,
        "last_name": lname,
        "phonenumber": phoneNumber
      },
    ).then((value) {
      logger.d(value.statusCode);

      logger.d(phoneNumber);
      if (value.statusCode != 200) {
        return false;
      } else {
        _userModel = UserModel.fromJson(value.data);
        // _rooms = Room.fromJson(value.data);
        notifyListeners();
        return true;
      }
    }).catchError((onError) {
      logger.d(onError);
      return throw false;
    });
  }

  Future changePassword({
    required String old_password,
    required String new_password1,
    required String new_password2,
  }) async {
    return await _api.postHeaders(url: 'auth/password/change/', data: {
      "old_password": old_password,
      "new_password1": new_password1,
      "new_password2": new_password2,
    }).then((value) {
      logger.d(value.statusCode);
      if (value.statusCode! > 200) {
        if (value.data['old_password'] != null) {
          return throw value.data['old_password'][0];
        }
        if (value.data['new_password2'] != null) {
          return throw value.data['new_password2'][0];
        }
      }
      return value;
    }).catchError((onError) {
      logger.d(onError);
      return throw onError;
    });
  }

  logout() async {
    _isLoggedIn = false;
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('creds') == null) {
      _isLoggedIn = false;
      notifyListeners();
    } else {
      prefs.remove('creds');
      prefs.remove('token');
      _isLoggedIn = false;
      getUser();
      notifyListeners();
    }
  }
}
