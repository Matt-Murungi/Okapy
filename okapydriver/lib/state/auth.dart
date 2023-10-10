import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:okapydriver/core/api.dart';
import 'package:okapydriver/core/locator.dart';
import 'package:okapydriver/core/utils/logger.dart';
import 'package:okapydriver/models/authmodel.dart';
import 'package:okapydriver/models/availableJobs.dart';
import 'package:okapydriver/models/driverProfile.dart' as driverProfile;
import 'package:okapydriver/models/profile.dart';
import 'package:okapydriver/models/user.dart';
import 'package:okapydriver/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  AuthModel? _authModel;

  AuthModel? get authModel => _authModel;
  final Api _api = locator<Api>();
  String? fname;
  String? lname;
  String? phoneNumber;
  String? uemail;
  bool _busy = false;

  bool get busy => _busy;
  bool _isLoggedIn = false;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool get isLoggedIn => _isLoggedIn;
  UserModel? _userModel;

  UserModel? get userModel => _userModel;
  List<AvailableJobs> _availableJobs = [];

  List<AvailableJobs> get availableJobs => _availableJobs;
  driverProfile.ProfileDriver? _profile;

  driverProfile.ProfileDriver? get profile => _profile;

  Auth() {
    setUpAuth();
  }

  Future sendOTPNumber({required String emailReset}) async {
    print(emailReset);
    await _api.postNoHeaders(
        url: 'auth/pasword/reset/', data: {"email": emailReset}).then((value) {
      return true;
    }).catchError((onError) {
      print(onError);
      return throw onError;
    });
  }

  setUpAuth() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getString('creds');
    if (prefs.getString('creds') == null) {
      _isLoggedIn = false;
      notifyListeners();
    } else {
      getUser();
      _isLoggedIn = true;
      notifyListeners();
    }
  }

  setnames({required String name1, required String name2}) {
    fname = name1;
    lname = name2;
    notifyListeners();
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
      print(value.statusCode);
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
      print(onError);
      return throw onError;
    });
  }

  setPhone({
    required String pNumber,
  }) {
    phoneNumber = pNumber;
    notifyListeners();
  }

  Future register({
    required String email,
    required String first_name,
    required String last_name,
    required String pn,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    print("The data input is ${{
      "email": email,
      "first_name": first_name,
      "last_name": last_name,
      "phonenumber": pn
    }}");
    return await _api
        .postNoHeaders(url: 'custom/auth/driver/registration/', data: {
      "email": email,
      "first_name": first_name,
      "last_name": last_name,
      "phonenumber": pn
    }).then((value) {
      print('The repsonce is ${value.data}');
      try {
        if (value.statusCode! > 250) {
          // prefs.setString(
          //     'creds', jsonEncode({'userName': email, 'password': password1}));

          if (value.data['non_field_errors'] != null) {
            return throw value.data['non_field_errors'][0];
          } else if (value.data['email'] != null) {
            return throw value.data['email'][0];
          } else if (value.data['password1'] != null) {
            return throw value.data['password1'][0];
          } else {
            return throw value.data;
          }
        } else {
          print(value.data);
          _authModel = AuthModel.fromJson(value.data);
          // _rooms = Room.fromJson(value.data);
          prefs.setString(
              'creds',
              jsonEncode({
                'userName': email,
              }));

          prefs.setString('token', jsonEncode({'key': _authModel!.key}));
          return sendOTPNumber1(pn).then(
            (value) {
              getUser();
              return value;
            },
          ).catchError((error) {
            return throw error;
          });
        }
      } catch (e) {
        print("The error is $e");
        return throw "Make sure you use unique phone and email";
      }
    }).catchError((onError) {
      print('THe error is ${onError}');
      if (onError['non_field_errors'] != null) {
        return throw onError['non_field_errors'][0];
      } else if (onError['email'] != null) {
        return throw onError['email'][0];
      } else if (onError['password1'] != null) {
        return throw onError['password1'][0];
      } else {
        return throw onError;
      }
    });
  }

  Future sendOTPNumber1(String phone) async {
    print('The logins are ${{
      'phonenumber': phoneNumber,
    }}');
    return await _api.postNoHeaders(
      url: 'custom/auth/request/otp/',
      data: {
        'phonenumber': phone,
      },
    ).then((value) {
      print("the response is ${value.data}");
      if (value.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }).catchError((onError) {
      return false;
    });
  }

  Future login({password, email}) async {
    final prefs = await SharedPreferences.getInstance();

    // print(prefs.get('creds'));
    return await _api.postNoHeaders(
      url: 'auth/login/',
      data: {'email_or_phonenumber': email, 'password': password},
    ).then((value) {
      if (value.statusCode == 200) {
        _authModel = AuthModel.fromJson(value.data);
        print('data is ${value.data}');
        prefs.setString('token', jsonEncode({'key': _authModel!.key}));

        // _rooms = Room.fromJson(value.data);
        prefs.setString(
            'creds', jsonEncode({'userName': email, 'password': password}));
        return true;
      } else {
        print('data is gg ${value.data}');
        return throw value.data;
      }
    }).catchError((onError) {
      return throw onError;
    });
  }

  getUser() async {
    _busy = true;
    notifyListeners();
    return await _api.getData(endpoint: 'auth/user/').then((value) {
      // print(value.data);
      _userModel = UserModel.fromJson(value.data);
      _busy = false;

      notifyListeners();
    }).catchError((onError) {
      print("The auth error is ${onError}");

      _busy = false;
      notifyListeners();
    });
  }

  Future updateUser(
      {required String fname,
      required String lname,
      required String pNumber,
      required String email}) async {
    print({
      "email": email,
      "first_name": fname,
      "last_name": lname,
      "phonenumber": pNumber
    });
    uemail = email;
    notifyListeners();
    return await _api.patchToken(
      url: 'auth/user/',
      data: {
        "email": email,
        "first_name": fname,
        "last_name": lname,
        "phonenumber": pNumber
      },
    ).then((value) {
      print(value.statusCode);

      print(pNumber);
      if (value.statusCode != 200) {
        return false;
      } else {
        _userModel = UserModel.fromJson(value.data);
        // _rooms = Room.fromJson(value.data);
        notifyListeners();
        return true;
      }
    }).catchError((onError) {
      print(onError);
      return throw false;
    });
  }

  sendOTP() async {
    await _api.getDataToken(endpoint: 'users/api/user/confirm/').then((value) {
      print(value.data);
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<bool> sendOTPConfirmation(
      {required String otp, required String phone}) async {
    final prefs = await SharedPreferences.getInstance();

    logger.d("sendOTPConfirmation started with $otp and $phone");

    return await _api.postNoHeaders(
        url: 'custom/auth/confirm/otp/',
        data: {'otp': otp, 'phonenumber': phone}).then((value) {
      if (value.statusCode == HttpStatus.ok) {
        logger.d("sendOTPConfirmation ${value.data}");
        _authModel = AuthModel.fromJson(value.data);
        prefs.setString(
            'creds',
            jsonEncode({
              'userName': phone,
            }));

        prefs.setString('token', jsonEncode({'key': _authModel!.key}));
        return true;
      } else {
        logger.d("sendOTPConfirmation ${value.statusCode} ${value.data}");

        _errorMessage = value.data;
        return false;
      }
    }).catchError((onError) {
      logger.e("sendOTPConfirmation error ${onError}");
      logger.e(onError);
      return false;
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
      _isLoggedIn = false;
      getUser();
      notifyListeners();
    }
  }

  getProfile() async {
    await _api.getData(endpoint: 'users/api/user/profile/').then((value) {
      _profile = driverProfile.ProfileDriver.fromJson(value.data);
      print(value.data);
      _profile = driverProfile.ProfileDriver.fromJson(value.data);
      notifyListeners();
    });
  }

  Future getProfileFuture() async {
    return await _api
        .getData(endpoint: 'users/api/user/profile/')
        .then((value) {
      _profile = driverProfile.ProfileDriver.fromJson(value.data);
      print("The profile value is ${value.data}");

      notifyListeners();
      return _profile;
    });
  }

  Future uploadDocs({
    required File lincese,
    required File insurance,
  }) async {
    return await _api
        .getData(endpoint: 'users/api/user/profile/')
        .then((value) async {
      driverProfile.ProfileDriver _driver =
          driverProfile.ProfileDriver.fromJson(value.data);
      return await _api
          .patchFormData(
              url: 'users/api/user/profile/',
              data: FormData.fromMap({
                "driving_license": await MultipartFile.fromFile(lincese.path,
                    filename: lincese.path.split('/').last),
                "insurance": await MultipartFile.fromFile(insurance.path,
                    filename: insurance.path.split('/').last),
                "id": _driver.id
              }))
          .then((value) {
        print("The error is ${value}");
        return true;
      }).catchError((onError) {
        return false;
      });
    });
  }
}
