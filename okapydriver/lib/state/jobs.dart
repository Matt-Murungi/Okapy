import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:geolocator/geolocator.dart';
import 'package:okapydriver/core/api.dart';
import 'package:okapydriver/core/helpers/shared_preference.dart';
import 'package:okapydriver/core/locator.dart';
import 'package:okapydriver/core/utils/logger.dart';
import 'package:okapydriver/models/BookingDetailsModel.dart';
import 'package:okapydriver/models/BookingsModel.dart';
import 'package:okapydriver/models/Jobtaken.dart';
import 'package:okapydriver/models/availableJobs.dart';
import 'package:okapydriver/models/completed.dart';
import 'package:okapydriver/state/auth.dart';
import 'package:okapydriver/state/vehicles.dart';
import 'package:okapydriver/utils/app_constants.dart';
import 'package:okapydriver/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../landing/landing.dart';
import '../models/NotificationModel.dart';

class AvailableJobsController extends ChangeNotifier {
  final List<AvailableJobs> _availableJobs = [];
  List<AvailableJobs> get availableJobs => _availableJobs;

  final Api _api = locator<Api>();
  int _bookingActive = 0;
  int get bookingActive => _bookingActive;
  BookingsModel? _bookingsModel;
  BookingsModel? get bookingsModel => _bookingsModel;
  int? _bookingPrev;
  int? get bookingPrev => _bookingPrev;

  bool _activeBookingBusy = false;
  bool get activeBookingBusy => _activeBookingBusy;

  Position? _driverPosition;
  Position? get driverPosition => _driverPosition;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  BookingDetailsModel? _bookingsDetailsModelActive;
  BookingDetailsModel? get bookingsDetailsModelActive =>
      _bookingsDetailsModelActive;
  String _distance = '';
  String get distance => _distance;
  JobTaken? _jobTaken;
  JobTaken? get jobTaken => _jobTaken;
  bool _activeJob = false;
  bool get activeJob => _activeJob;
  Timer? _timer;
  set activeJob(bool value) {
    _activeJob = value;
  }

  String get productImage =>
      "$serverUrlAssets${bookingsDetailsModelActive?.product?.image}";

  String? get productAmount => bookingsDetailsModelActive?.amount;

  String? get productType => bookingsDetailsModelActive?.product?.productType;

  String? get productInstructions =>
      bookingsDetailsModelActive?.product?.instructions;

  String? get productPickupAddress =>
      bookingsDetailsModelActive?.booking?.formatedAddress;

  String? get productDestinationAddress =>
      bookingsDetailsModelActive?.receiver?.formatedAddress;

  String? get receiverName => bookingsDetailsModelActive?.receiver?.name;

  int? _activeJobState;
  int? get activeJobState => _activeJobState;
  final List<CompletedJobs> _completedJobs = [];
  List<CompletedJobs> get completedJobs => _completedJobs;

  bool _isDriverOnline = false;
  bool get isDriverOnline => _isDriverOnline;

  bool _completedbusy = false;
  bool get completedbusy => _completedbusy;
  bool isActiveOrder = false;
  AvailableJobsController() {
    getJobs();
    setUpActiveJob();
  }

  void getBookingDetail({required int id, required String amount}) async {
    _activeBookingBusy = true;
    print(id);
    notifyListeners();
    await _api.getData(endpoint: 'bookings/api/confirm/$id').then((value) {
      print(value.data);
      print('details is ${value.data}');
      _bookingsDetailsModelActive = BookingDetailsModel.fromJson(value.data);
      _bookingsDetailsModelActive!.amount = amount;
      if (_activeJobState! > 4) {
        clearActive();
      }
    });

    _activeBookingBusy = false;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setIsDriverOnline(bool value) {
    _isDriverOnline = value;
    notifyListeners();
  }

  void getJobs() async {
    _availableJobs.clear();
    notifyListeners();
    await _api.getData(endpoint: 'payments/api/driver/orders/').then((value) {
      logger.d(value.data);
      if (value.data != null) {
        for (var job in value.data) {
          _availableJobs.add(AvailableJobs.fromJson(job));
        }
        logger.d("the data is $_activeJob");
        if (value.data.length > 0) {
          this.isActiveOrder = true;
          _activeJobState = 1;

          notifyListeners();
        } else {
          // Handle the case when value.data is an empty array
        }

        getBookingDetail(
            id: _availableJobs[_bookingActive].booking!.id!,
            amount: _availableJobs[_bookingActive].amount!);
        notifyListeners();
      } else {
        // Handle the case when value.data is null
      }
    }).catchError((onError) {
      logger.e(onError);
    });
  }

  void getJobsSilent() async {
    await _api.getData(endpoint: 'payments/api/driver/orders/').then((value) {
      print("the data to collect is ${value.data}");

      if (value.data.length > 0) {
        for (var i = 0; i < value.data.length; i++) {
          _availableJobs.add(AvailableJobs.fromJson(value.data[i]));
        }
        print("the data is $_activeJob");
        if (value.data.length > 0) {
          this.isActiveOrder = true;
          _activeJobState = 1;
          if (Landing.isPlaying == false) {
            FlutterRingtonePlayer.play(
              fromAsset: "assets/retrowave.mp3", // will be the sound on Android
              ios: IosSounds.glass,
              looping: false,
            );
            Landing.isPlaying = true;
          }
        }

        getBookingDetail(
            id: _availableJobs[_bookingActive].booking!.id!,
            amount: _availableJobs[_bookingActive].amount!);

        notifyListeners();
        _timer?.cancel();
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  void clearActive() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(SharedPreferenceConstants.activeJobDetails);
    prefs.remove(SharedPreferenceConstants.activeJob);
    _activeJobState = JobState.none;
    _activeJob = false;
    clearJobData();
    getJobs();
    notifyListeners();
  }

  bookingNext() {
    print(_bookingActive);
    print(_availableJobs.length);
    if (_bookingActive >= (_availableJobs.length - 1)) {
      clearActive();
      print("No new order");
    } else {
      _bookingPrev = _bookingActive;
      _bookingActive = _bookingActive + 1;

      if (_bookingActive < _availableJobs.length) {
        getBookingDetail(
            id: _availableJobs[_bookingActive].booking!.id!,
            amount: _availableJobs[_bookingActive].amount!);
      } else {
        _bookingActive = _availableJobs.length - 1;
        getBookingDetail(
            id: _availableJobs[_bookingActive].booking!.id!,
            amount: _availableJobs[_bookingActive].amount!);
      }

      notifyListeners();
    }
  }

  Future getDriverAvailability() async {
    setLoading(true);
    try {
      var response =
          await _api.getData(endpoint: "notifications/api/driver/availability");
      logger.d("getDriverAvailability ${response.statusCode} ${response.data}");
      if (response.statusCode == HttpStatus.ok) {
        _isDriverOnline = response.data["is_active"] as bool;
        SharedPrefHelpers.setIsDriverAvailable(response.data["is_active"]);
        notifyListeners();
        logger.d("driver online $isDriverOnline");
        setLoading(false);
      } else {
        logger
            .e("getDriverAvailability ${response.statusCode} ${response.data}");

        setLoading(false);
      }
    } catch (error) {
      setLoading(false);
      logger.e("getDriverAcailability  Error $error");
    }
  }

  setDriverAvailability(bool isAvailable) async {
    setLoading(true);
    try {
      Position position = await Geolocator.getCurrentPosition();
      _driverPosition = position;
      Map<String, dynamic> data = {
        "latitude": "${position.latitude}",
        "longitude": "${position.longitude}",
        "is_active": isAvailable
      };
      logger.d("Driver availability is $data");

      var response = await _api.postHeaders(
          url: "notifications/api/driver/availability", data: data);

      logger.d("response availability ", response);
      if (response.statusCode == HttpStatus.ok) {
        setLoading(false);
        return true;
      } else {
        setLoading(false);

        return false;
      }
    } catch (error) {
      setLoading(false);

      logger.e("setDriverAvailability error, $error");
    }
  }

  void setUpActiveJob() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('activeJobDetails') == null) {
      _activeJob = false;
      getJobs();
      notifyListeners();
    } else {
      print('user');
      _jobTaken =
          JobTaken.fromJson(jsonDecode(prefs.getString('activeJobDetails')!));
      getOrder(id: _jobTaken!.id!);
      _activeJob = true;
      notifyListeners();
    }
  }

  void getOrder({required int id}) async {
    _availableJobs.clear();
    await _api.getData(endpoint: "payments/api/get/order/$id/").then((value) {
      print("the status ${value}");
      _availableJobs.add(AvailableJobs.fromJson(value.data));
      AvailableJobs _jb = AvailableJobs.fromJson(value.data);
      _activeJobState = int.parse(_jb.status!);
      getBookingDetail(id: _jb.booking!.id!, amount: _jb.amount!);
    });
  }

  bool isAvailableJobListEmpty() {
    return availableJobs.isEmpty;
  }

  void startTimer() {
    // _timer = Timer.periodic(
    //     const Duration(seconds: 5), (Timer t) => getJobsSilent());
  }

  void setDistance({required String distance}) {
    _distance = distance;
    notifyListeners();
  }

  Future acceptJob({required VehiclesController vehicle}) async {
    _isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    print("acceptJob input  ${{
      "order_id": availableJobs[bookingActive].id,
      "vehicle_id": vehicle.vehicleList.last.id!,
    }}");
    return await _api.postHeaders(url: 'payments/api/driver/accept/', data: {
      "order_id": availableJobs[bookingActive].id,
      "vehicle_id": vehicle.vehicleList.last.id!,
    }).then((value) {
      print("acceptJob ${value.data}");
      print(value.statusCode);
      if (value.statusCode == 200) {
        SharedPrefHelpers.setIsDriverActive(true);
        SharedPrefHelpers.setActiveJobState(JobState.confirmed);
        _activeJob = true;
        _activeJobState = JobState.confirmed;
        JobTaken _jb = JobTaken.fromJson(value.data);
        _jobTaken = _jb;
        SharedPrefHelpers.setactiveJobDetails(_jb);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        print("value is $value");
        print(value.statusCode);
        return throw value.data;
      }
    }).catchError((onError, stacktrace) {
      print('Error is $onError $stacktrace');
      return throw onError;
    });
  }

  Future cancelJob() async {
    final prefs = await SharedPreferences.getInstance();
    print("The cancelJob order id  ${availableJobs[bookingActive].id}");
    return await _api.patchToken(url: 'payments/api/driver/cancel/', data: {
      "order_id": availableJobs[bookingActive].id,
    }).then((value) {
      print("The cancelJob is $value");
      print(value.statusCode);
      print(value.statusCode);
      if (value.statusCode == 200) {
        clearActive();
        bookingNext();
        notifyListeners();
        return true;
      } else {
        print(value);
        print(value.statusCode);
        return throw value.data;
      }
    }).catchError((onError) {
      print('$onError');
      return throw onError;
    });
  }

  Future confirmUpdate({required Auth driver}) async {
    _isLoading = true;
    int? driverId = driver.userModel!.id;
    print("Booking ID ${availableJobs[bookingActive].id}");
    int nextState = await getNextJobState();
    print("State is $nextState");

    if (nextState > _activeJobState! || _activeJobState != JobState.arrived) {
      return await _api.patch(url: 'payments/api/order/', data: {
        "status": nextState,
        "id": availableJobs[bookingActive].id,
        "driver": driverId
      }).then((value) {
        print("Value is $value");
        if (value.statusCode == 200) {
          SharedPrefHelpers.setIsDriverActive(true);
          _activeJob = true;
          _activeJobState = nextState;
          SharedPrefHelpers.setActiveJobState(_activeJobState!);

          notifyListeners();
          JobTaken _jb = JobTaken.fromJson(value.data);
          _jobTaken = _jb;
          SharedPrefHelpers.setactiveJobDetails(_jb);
          notifyListeners();
          _isLoading = false;
          return true;
        } else {
          return false;
        }
      }).catchError((onError) {
        print('$onError');
        return throw onError;
      });
    }
  }

  Future getNextJobState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      int? state = prefs.getInt(SharedPreferenceConstants.activeJobState);

      if (state == JobState.confirmed) {
        return JobState.picked;
      }
      if (state == JobState.picked) {
        return JobState.transit;
      }
      if (state == JobState.transit) {
        return JobState.arrived;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> clearJobData() async {
    final prefs = await SharedPreferences.getInstance();
    SharedPrefHelpers.setIsDriverActive(false);
    _activeJobState = 1;
    prefs.remove(SharedPreferenceConstants.activeJobDetails);
    prefs.remove(SharedPreferenceConstants.activeJobState);
    _availableJobs.clear();
    getJobs();
  }

  Future<bool> confirmBooking({required int otp}) async {
    final prefs = await SharedPreferences.getInstance();
    _completedbusy = true;
    notifyListeners();
    return await _api.postHeaders(url: 'bookings/api/booking/confirm/', data: {
      "booking_id": availableJobs[bookingActive].booking!.id,
      "otp": "$otp"
    }).then((value) {
      print("The status code is ${value.statusCode}");
      print("The status code is ${value}");
      _completedbusy = false;
      notifyListeners();
      if (value.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }).catchError((onError) {
      print('$onError');
      return throw onError;
    });
  }

  void bookingprevF() {
    if (_bookingActive == 0) {
    } else {
      _bookingPrev = _bookingActive - 2;
      _bookingActive = _bookingActive - 1;

      getBookingDetail(
          id: _availableJobs[_bookingActive].booking!.id!,
          amount: _availableJobs[_bookingActive].amount!);

      notifyListeners();
    }
  }

  void getBookingProducts({required int id}) async {
    _activeBookingBusy = true;
    print(id);
    notifyListeners();
    await _api.getData(endpoint: 'bookings/api/products/$id').then((value) {
      print(value.data);
      print('details is ${value.data}');
      _bookingsDetailsModelActive = BookingDetailsModel.fromJson(value.data);
    });

    _activeBookingBusy = false;
    notifyListeners();
  }

  Future getBookingDetailID({required int id}) async {
    return await _api.getData(endpoint: 'bookings/api/confirm/$id');
  }

  int id = 0;
  Future<void> _showNotification(NotificationModel notificationModel) async {}

  getCompletedJobs({required int id}) async {
    _completedbusy = true;
    notifyListeners();
    await _api
        .getData(endpoint: 'admins/api/orders/?driver_id=$id')
        .then((value) {
      // print(value.data);
      for (var i = 0; i < value.data.length; i++) {
        _completedJobs.add(CompletedJobs.fromJson(value.data[i]));
      }
      _completedbusy = false;
      notifyListeners();
    }).catchError((onError) {
      // print(onError);
      return throw onError;
    });
  }

  Future requestPayment({required String amount, required int owner}) async {
    print({"amount": amount, "owner": owner});
    await _api.postHeaders(
        url: 'payments/api/driver/request/earning/',
        data: {"amount": amount, "owner": owner}).then((value) {
      print("Request payment ${value.data}");
      return true;
    }).catchError((onError) {
      // print(onError);

      return throw onError;
    });
  }
}
