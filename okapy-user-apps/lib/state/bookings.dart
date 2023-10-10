import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:okapy/core/api.dart';
import 'package:okapy/core/data/url_constants.dart';
import 'package:okapy/core/locator.dart';
import 'package:okapy/core/utils/logger.dart';
import 'package:okapy/models/active_model.dart';
import 'package:okapy/models/BookingsDetailsModel.dart';
import 'package:okapy/models/VehicleModel.dart';
import 'package:okapy/models/auth.dart';
import 'package:okapy/models/bookingModel.dart';
import 'package:okapy/models/partner_product.dart';
import 'package:okapy/models/partners.dart';
import 'package:okapy/models/product.dart';
import 'package:okapy/models/user.dart';
import 'package:okapy/models/userModel.dart';
import 'package:okapy/screens/home/app_constants.dart';
import 'package:okapy/utils/SharedPrefConstants.dart';
import 'package:okapy/utils/SharedPreferenceHelpers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Bookings extends ChangeNotifier {
  bool _busy = true;
  bool get busy => _busy;
  bool _busyF = false;
  bool get busyF => _busy;
  bool adding_product = false;
  double _amount = 0;
  double get amount => _amount;
  bool _errorInitializingBooking = false;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Api _api = locator<Api>();
  final List<PartnerModel> _partners = [];
  List<PartnerModel> get partners => _partners;
  List<PartnerProductModel> _partnerProducts = [];
  List<PartnerProductModel> get partnerProducts => _partnerProducts;
  List<PartnerModel> _filteredPartnerSearch = [];
  List<PartnerModel> get filteredPartnerSearch => _filteredPartnerSearch;

  List<PartnerProductModel> _partnerCartItems = [];
  List<PartnerProductModel> get partnerCartItems => _partnerCartItems;

  String _partnerItemTotalPrice = "";
  String get partnerItemTotalPrice => _partnerItemTotalPrice;

  double _vehiclePrice = 0;
  double get vehiclePrice => _vehiclePrice;

  Map<PartnerProductModel?, int> _checkoutItems = {};
  Map<PartnerProductModel?, int> get checkoutItems => _checkoutItems;

  PartnerModel? _selectedPartner;
  PartnerModel? get selectedPartner => _selectedPartner;
  int _unreadCount = 0;
  int get unreadCount => _unreadCount;
  // List<Placemark> SendersLocation
  List<Placemark> _sendersLocation = [];
  List<Placemark> get sendersLocation => _sendersLocation;
  UserModel? _userModel;
  UserModel? get userModel => _userModel;
  LatLng? _sendersLatlang;
  LatLng? get sendersLatlang => _sendersLatlang;

  final distance = Distance();
  Position? _currentLatLng;
  Position? get currentLatLng => _currentLatLng;
  List<BookingsModel> _bookingsList = [];
  List<BookingsModel> get bookingsList => _bookingsList;
  BookingDetailsModel? _bookingActiveModel;

  ActiveModel? _activeModel;
  ActiveModel? get activeModel => _activeModel;

  BookingDetailsModel? get bookingActiveModel => _bookingActiveModel;
  BookingsModel? _bookingsModel;
  BookingsModel? get bookingsModel => _bookingsModel;
  BookingDetailsModel? _bookingsDetailsModel;
  BookingDetailsModel? get bookingsDetailsModel =>
      _bookingActiveModel; //_bookingsDetailsModel;
  ProctuctsModel? _proctuctsModel;
  ProctuctsModel? get proctuctsModel => _proctuctsModel;
  Prediction? _senderLocation;
  Prediction? get senderLocation => _senderLocation;
  Prediction? _receiverLocation;
  Prediction? get reverLocation => _receiverLocation;
  int _bookingActive = 0;
  int get bookingActive => _bookingActive;
  int? _bookingPrev;
  int? get bookingPrev => _bookingPrev;
  BuildContext? context;

  bool _activeBookingBusy = false;
  bool get activeBookingBusy => _activeBookingBusy;

  String _formatedDate = '';
  String get formatedDate => _formatedDate;
  BookingDetailsModel? get bookingsDetailsModelActive =>
      _bookingActiveModel; //_bookingsDetailsModel;

  Bookings() {
    initBookings();
  }

  setIsLoading(value) {
    notifyListeners();

    _isLoading = value;
    notifyListeners();
  }

  void _clearStoredData() {
    _partners.clear();
    _partnerProducts.clear();
    _filteredPartnerSearch.clear();
    notifyListeners();
  }

  initBookings() async {
    final prefs = await SharedPreferences.getInstance();
    logger.d("User Token is ${prefs.containsKey("token")}");
    if (prefs.containsKey("token")) {
      getLatestOngoingOrder().then((value) {
        logger.d("Get Latest Ongoing Order $value");
        getBookingDetail(id: activeModel!.id!);
      }).catchError((onError) {
        logger.e("$onError");
      });

      getpartners();
      getallBookings();
      getUser();
      // websocketSreamerInit();
      ("initBookings true");
    } else {
      debugPrint("initBookings false");
    }
  }

  void setSelectedPartner(PartnerModel partner) => _selectedPartner = partner;

  void setVehiclePrice(double price) {
    _vehiclePrice = price;
  }

  void addToCart(PartnerProductModel partner) {
    _partnerCartItems.add(partner);
    logger.d(
        "_partnerCartItem length ${_partnerCartItems.length}, new addition ${partner.toString()}");

    notifyListeners();
  }

  void clearCheckout() {
    _checkoutItems.clear();
    _partnerCartItems.clear();
  }

  void convertToCheckout() {
    _checkoutItems.clear();
    _partnerCartItems.forEach((item) {
      if (_checkoutItems.containsKey(item)) {
        _checkoutItems[item] = _checkoutItems[item]! + 1;
      } else {
        _checkoutItems[item] = 1;
      }
    });
    logger.v("Checkout items $_checkoutItems");
  }

  void addToCheckout(PartnerProductModel product) {
    if (_checkoutItems.containsKey(product)) {
      _checkoutItems[product] = _checkoutItems[product]! + 1;
      notifyListeners();
    }
  }

  void removeFromCheckout(PartnerProductModel product) {
    if (_checkoutItems.containsKey(product)) {
      _checkoutItems[product] = _checkoutItems[product]! - 1;
      if (_checkoutItems[product] == 0) {
        _checkoutItems.remove(product);
        _partnerCartItems.remove(product);
      }
      notifyListeners();
    }
  }

  calculateTotalPrice() {
    double total = 0;
    _checkoutItems.entries.forEach((item) {
      total = total + (item.key!.price! * item.value);
      _partnerItemTotalPrice = total.toString();
    });

    notifyListeners();
    return total;
  }

  convertToJson() {
    Map json = {};
    _checkoutItems.entries.forEach((item) {
      json[item.key!.name] = item.value;
    });
    return json;
  }

  void setLoadingState(bool loadingState) {
    _isLoading = loadingState;
    notifyListeners();
  }

  void setCurrentLatLng(Position value) {
    _currentLatLng = value;
  }

  int calculateDistance(double? latitude, double? longitude) {
    final km = distance.as(
      LengthUnit.Kilometer,
      LatLng(currentLatLng!.latitude, currentLatLng!.longitude),
      LatLng(latitude!.toDouble(), longitude!.toDouble()),
    );
    return km.toInt();
  }

  bookingNext() {
    if (_bookingActive == (_bookingsList.length - 1)) {
    } else {
      _bookingPrev = _bookingActive;
      _bookingActive = _bookingActive + 1;

      getBookingDetail(id: _bookingsList[_bookingActive].id!);
      notifyListeners();
    }
  }

  bookingprevF() {
    if (_bookingActive == 0) {
    } else {
      _bookingPrev = _bookingActive - 2;
      _bookingActive = _bookingActive - 1;

      getBookingDetail(id: _bookingsList[_bookingActive].id!);
      notifyListeners();
    }
  }

  setSenderLocation(Prediction? location) {
    _senderLocation = location;
    notifyListeners();
  }

  setReceiversLocation(Prediction? location) {
    _receiverLocation = location;
    notifyListeners();
  }

  getallBookings() async {
    _busy = true;
    _bookingsList.clear();
    notifyListeners();
    await _api.getData(endpoint: 'bookings/api/bookings/').then((value) {
      for (var i = 0; i < value.data.length; i++) {
        _bookingsList.add(BookingsModel.fromJson(value.data[i]));
      }
      notifyListeners();
      logger.v("The size is ${_bookingsList.length}");
    });
    _busy = false;
    notifyListeners();
  }

  Future<List<VehicleModel>> getBookingPrices(Bookings booking) async {
    List<VehicleModel> returnData = [];
    int? id = bookingsModel!.id;
    logger.v("getBookingPrices called started... $id");

    Response value =
        await _api.getData(endpoint: 'bookings/api/booking/amount/range/$id');

    logger.v("The return data is ${value.data}");
    Map<String, dynamic> data = value.data;
    returnData =
        data.keys.map((e) => VehicleModel(name: e, value: data[e])).toList();

    logger.v("getBookingPrices called $returnData");
    return returnData;
  }

  getpartners() async {
    _clearStoredData();

    setLoadingState(true);
    notifyListeners();
    return await _api.getData(endpoint: 'partners/api/').then((value) {
      logger.d("The categories ${value.data}");
      for (var i = 0; i < value.data.length; i++) {
        _partners.add(PartnerModel.fromJson(value.data[i]));
      }
      _filteredPartnerSearch = _partners;
      setLoadingState(false);
      notifyListeners();
    });
  }

  websocketSreamerInit() async {
    logger.v('init sockets');
    final prefs = await SharedPreferences.getInstance();
    AuthModel userToken =
        AuthModel.fromJson(jsonDecode(prefs.getString('token')!));
    dynamic channel = WebSocketChannel.connect(
      Uri.parse(
          // 'ws://apidev.okapy.world:8000/chats/${widget.availableJobs.bookingsDetailsModelActive?.booking?.owner?.id}__${widget.authController.userModel?.id}/?token=${userToken.key}'),
          'ws://apidev.okapy.world/notifications/?token=${userToken.key}'),
    );

    channel.stream.listen((message) {
      logger.v("The notifications are " + message);
      Map<String, dynamic> dataMessages = jsonDecode(message);
      if (dataMessages['type'] == 'unread_count') {
        _unreadCount = dataMessages['msg_count'];
      }
    });
  }

  Future<bool> initializeBooking({required Map<String, dynamic> data}) async {
    logger.d("initializeBooking booking data $data");
    _isLoading = true;
    _errorInitializingBooking = false;
    try {
      var response =
          await _api.postHeaders(url: "bookings/api/bookings/", data: data);
      // .then((value) {
      logger.d("initializeBooking response ${response.toString()}");
      if (response.statusCode == HttpStatus.created) {
        _bookingsModel = BookingsModel.fromJson(response.data);
        logger
            .d("initializeBooking booking Model ${_bookingsModel.toString()}");
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorInitializingBooking = true;

        _errorMessage = response.data;
        _isLoading = false;
        notifyListeners();
        _isLoading = true;
        return false;
      }
    } catch (error) {
      logger.d("initializeBooking Error $error");
      _errorInitializingBooking = true;
      _errorMessage = error.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  attachPartnerProductToBooking() async {
    _isLoading = true;
    _errorInitializingBooking = false;
    notifyListeners();
    try {
      var response = await _api.postHeaders(
          url: "partners/api/product/customer",
          data: {
            "booking": _bookingsModel!.bookingId,
            "products": convertToJson()
          });
      logger.d(response.data);
      if (response.statusCode == HttpStatus.created) {
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorInitializingBooking = true;

        _isLoading = false;
        _errorMessage = response.data;
        notifyListeners();
        return false;
      }
    } catch (error) {
      logger.v(error);
      _errorInitializingBooking = true;
      _errorMessage = error.toString();
      _isLoading = false;
      return false;
    }
  }

  setSendersLocation({required double lat, required double lang}) {
    _sendersLatlang = LatLng(lat, lang);
    notifyListeners();
  }

  bool errorInitializingBooking() {
    return _errorInitializingBooking;
  }

  checkBookings() {}
  Future bookingsProduct(
      {File? doc, String? productID, String? instructions}) async {
    adding_product = true;
    notifyListeners();

    return await _api
        .postHeadersFormData(
            url: 'bookings/api/products/',
            data: FormData.fromMap({
              "product_type": productID,
              "instructions": instructions,
              "booking": bookingsModel!.id,
              "image": await MultipartFile.fromFile(doc!.path,
                  filename: doc.path.split('/').last),
            }))
        .then((value) {
      logger.v("The added product is $value");
      _proctuctsModel = ProctuctsModel.fromJson(value.data);
      adding_product = false;
      notifyListeners();
      return true;
    }).catchError((onError) {
      logger.v("The added product is $onError");
      adding_product = false;
      return false;
    });
  }

  Future setReceiverDetails(
      {String? receiverLoc,
      String? senderLocation,
      required String name,
      required String phone}) async {
    _formatedDate = senderLocation!;
    logger.v({
      "name": name,
      "phonenumber": phone,
      "formated_address": receiverLoc,
      "latitude": reverLocation!.lat,
      "longitude": reverLocation!.lng,
      "booking": bookingsModel?.id,
    });
    notifyListeners();
    try {
      var response =
          await _api.postHeaders(url: 'bookings/api/receiver/', data: {
        "name": name,
        "phonenumber": phone,
        "formated_address": receiverLoc,
        "latitude": reverLocation!.lat,
        "longitude": reverLocation!.lng,
        "booking": bookingsModel?.id
      });

      logger.v("The reciver details are ${response.statusCode}");
      if (response.statusCode == HttpStatus.ok) {
        notifyListeners();
        return true;
      } else {
        _errorMessage = response.data;
        notifyListeners();
        return false;
      }
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
      return false;
    }
  }

  Future patchVehicle({required int vehivleId, required int authId}) async {
    logger.v(formatedDate);
    if (_formatedDate == '') {
      _formatedDate = "Partner location";
    }
    logger.v("patchVehicle ${{
      "vehicle_type": vehivleId,
      "formated_address":
          formatedDate.isEmpty ? "Formatted Location" : formatedDate,
      "latitude": senderLocation?.lat,
      "longitude": senderLocation?.lng,
      "owner": authId,
      'id': bookingsModel?.id
    }}");
    return await _api
        .patch(
            url: 'bookings/api/bookings/',
            data: _selectedPartner == null
                ? {
                    "vehicle_type": vehivleId,
                    "formated_address": formatedDate,
                    "latitude": senderLocation?.lat,
                    "longitude": senderLocation?.lng,
                    "owner": authId,
                    'id': bookingsModel?.id
                  }
                : {
                    "vehicle_type": vehivleId,
                    'id': bookingsModel?.id,
                  })
        .then((value) {
      logger.v("value is $value");
      _bookingsModel = BookingsModel.fromJson(value.data);

      notifyListeners();
      return true;
    }).catchError((onError) {
      return throw false;
    });
  }

  Future patchSender({required int authId}) async {
    logger.v(formatedDate);
    logger.v({
      "formated_address": formatedDate,
      "latitude": senderLocation?.lat,
      "longitude": senderLocation?.lng,
      "owner": authId,
      'id': bookingsModel?.id
    });
    return await _api.patch(url: 'bookings/api/bookings/', data: {
      "formated_address": formatedDate,
      "latitude": senderLocation?.lat,
      "longitude": senderLocation?.lng,
      "owner": authId,
      'id': bookingsModel?.id
    }).then((value) {
      logger.v("The return data is ${value.data}");
      _bookingsModel = BookingsModel.fromJson(value.data);

      notifyListeners();
      return true;
    }).catchError((onError) {
      return throw false;
    });
  }

  Future<bool> getBookingDetails() async {
    _busy = true;
    notifyListeners();
    try {
      logger.v("getBookingDetails id is ${bookingsModel!.id}");
      var value = await _api.getData(
          endpoint: 'bookings/api/confirm/${bookingsModel!.id}');
      logger.v("getBookingDetails is ${value}");
      _bookingActiveModel = BookingDetailsModel.fromJson(value.data);
      _busy = false;
      notifyListeners();
      return true;
    } catch (error, stacktrace) {
      logger.v("result error is $error, $stacktrace");
      _busy = false;
      notifyListeners();

      return false;
    }
  }

  getBookingDetail({required int id}) async {
    notifyListeners();
    logger.v("calledddd $id");
    try {
      bool hasOngoingOrder =
          await SharedPrefHelpers.getBool(SharedPrefConstants.hasOngoingOrder);
      if (hasOngoingOrder) {
        var response = await _api.getData(endpoint: 'bookings/api/confirm/$id');
        if (response.statusCode == 200) {
          logger.v(response.data);

          _bookingsDetailsModel = BookingDetailsModel.fromJson(response.data);
          _bookingActiveModel = BookingDetailsModel.fromJson(response.data);
          logger.v('booking details is ${response!.data}');
        } else {
          _errorMessage = response!.data;
          logger.v('booking details error is ${response!.data}');
        }
      } else {}
    } catch (error) {
      _errorMessage = "Error accessing booking";
    }

    notifyListeners();
    notifyListeners();
  }

  getBookingDetailSilent({required int id}) async {
    //  id = 16;

    notifyListeners();
    logger.v("calledddd $id");
    await _api.getData(endpoint: 'bookings/api/confirm/$id').then((value) {
      logger.v("The bookings value is ${value.data}");
      logger.v('details');
      // _bookingsDetailsModel = BookingDetailsModel.fromJson(value.data);
      _bookingActiveModel = BookingDetailsModel.fromJson(value.data);
      logger.v('details of product is ${_bookingsDetailsModel}');
      notifyListeners();
    });

    notifyListeners();
  }

  getBookingDetailID({required int id}) async {
    return await _api.getData(endpoint: 'bookings/api/confirm/$id');
  }

  getBookingDetailsId({required int id}) async {
    _busy = true;
    notifyListeners();
    await _api.getData(endpoint: 'bookings/api/confirm/$id').then((value) {
      _bookingActiveModel = BookingDetailsModel.fromJson(value.data);
    });
    _busy = false;
    notifyListeners();
  }

  getUser() async {
    _busy = true;
    notifyListeners();
    return await _api.getData(endpoint: 'auth/user/').then((value) {
      // logger.v(value.data);
      _userModel = UserModel.fromJson(value.data);
      _busy = false;
      notifyListeners();
    });
  }

  getVehicleType(String vehicleType) {
    switch (vehicleType) {
      case "1":
        return {"image": "assets/motorcycle.png", "vehicleType": "Motorcycle"};
      case "2":
        return {"image": "assets/vehicle.png", "vehicleType": "Vehicle"};
      case "3":
        return {"image": "assets/van.png", "vehicleType": "Van"};
      case "4":
        return {"image": "assets/truck.png", "vehicleType": "Truck"};
      default:
        return {"image": "null", "vehicleType": "invalid vehicle"};
    }
  }

  getProductType(String productType) {
    logger.v("Product type $productType");
    switch (productType) {
      case "1":
        return {"image": "assets/package.png", "productType": "Electronic"};
      case "2":
        return {"image": "assets/giftBox.png", "productType": "Gift"};
      case "3":
        return {"image": "assets/doc.png", "productType": "Document"};
      case "4":
        return {"image": "assets/package.png", "productType": "Package"};
      default:
        return {"image": "assets/addal.png", "productType": "Other"};
    }
  }

  getPartnerSector(String partnerSector) {
    logger.v("Product type $partnerSector");
    switch (partnerSector) {
      case "1":
        return "Fashion";
      case "2":
        return "Bakery";
      case "3":
        return "Pharmacy";
      case "4":
        return "Supermarket";
      case "5":
        return "Manufacturing";
      default:
        return "Restaurants";
    }
  }

  Future<bool> getPartnerProduct(PartnerModel partner) async {
    setLoadingState(true);
    _partnerProducts.clear();

    try {
      String endpoint = "${ApiUrl.partnerProducts}${partner.id}/";
      logger.v(endpoint);
      Response response = await _api.getData(endpoint: endpoint);
      if (response.statusCode == HttpStatus.ok) {
        setLoadingState(false);
        response.data
            .map((product) =>
                _partnerProducts.add(PartnerProductModel.fromJson(product)))
            .toList();

        notifyListeners();
        return true;
      } else {
        setLoadingState(false);
        _errorMessage = "Error fetching details";
        notifyListeners();
        return false;
      }
    } catch (error) {
      setLoadingState(false);
      _errorMessage = "Error fetching details";
      logger.v("response is $error");
      notifyListeners();
      return false;
    }
  }

  searchPartner(String input) {
    if (_partners.isNotEmpty) {
      if (input.isNotEmpty) {
        _filteredPartnerSearch = _partners
            .where((partner) =>
                partner.name!.toLowerCase().contains(input.toLowerCase()))
            .toList();
      } else {
        _filteredPartnerSearch = _partners;
      }
    } else {
      _filteredPartnerSearch = _partners;
    }
    notifyListeners();
  }

  Future postPaymentType(
      {required int order_id, required String paymentType}) async {
    setIsLoading(true);
    if (paymentType == "Cash") {
      return await _api
          .postHeaders(url: "payments/api/payments/cash/make/", data: {
        "order_id": order_id,
      }).then((value) {
        logger.v("completeCashPayments ${value.data}");
        logger.v(value.statusCode);
        if (value.statusCode == 200) {
          setIsLoading(false);
          return true;
        } else {
          setIsLoading(false);

          return false;
        }
      }).catchError((error, stackTrace) {
        logger.v(error);
        setIsLoading(false);

        return false;
      });
    } else {}
  }

  Future<bool> hasOngoingOrder() async {
    bool isOngoing =
        await SharedPrefHelpers.getBool(SharedPrefConstants.hasOngoingOrder);
    return isOngoing;
  }

  Future<bool> convertToOrder({required Map<String, dynamic> data}) async {
    return await _api
        .postHeaders(url: "payments/api/order/", data: data)
        .then((value) async {
      logger.v("convertToOrder ${value.data}");
      logger.v(value.statusCode);
      if (value.statusCode == HttpStatus.created) {
        _activeModel = ActiveModel.fromJson(value.data);
        logger.v("_activemoded value data ${value.data}");

        return true;
      } else {
        notifyListeners();
        _errorMessage = value.data;
        return false;
      }
    }).catchError((error, stackTrace) {
      logger.v(error);
      _errorMessage = error;
      return false;
    });
  }

  scheduleBooking(Map<String, String> data, {required AuthModel auth}) async {
    setIsLoading(true);
    final prefs = await SharedPreferences.getInstance();
    User user = User.fromJson(jsonDecode(prefs.getString('creds')!));
    AuthModel authModel =
        AuthModel.fromJson(jsonDecode(prefs.getString('token')!));

    var headers = {'Authorization': "Token ${authModel.key}"};
    var request = http.MultipartRequest('PATCH',
        Uri.parse('https://apidev.okapy.world/bookings/api/bookings/'));
    request.fields.addAll(data);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      logger.v("THe schedule set is $data");
      setIsLoading(false);
      notifyListeners();
      return true;
    } else {
      logger.v("The error is ${response.reasonPhrase}");
      setIsLoading(false);
      notifyListeners();
      return false;
    }
  }

  Future getLatestOngoingOrder() async {
    setIsLoading(true);
    try {
      var response =
          await _api.getData(endpoint: 'payments/api/order/ongoing/');

      if (response!.statusCode == 200) {
        if (response!.statusCode == 200) {
          if (response.data != null || response.data != {}) {
            _activeModel = ActiveModel.fromJson(response.data);
            notifyListeners();
            logger.v("Latest order ${response.data}");
            logger.v(
                "Latest order details ${_activeModel!.amount} ${_activeModel!.driver!.firstName!}");
            setIsLoading(false);
          } else {
            logger.v("Latest order else ${response.data}");
            notifyListeners();
          }
        } else {
          setIsLoading(false);

          logger.v("Latest order ${response.data}");
          notifyListeners();

          _errorMessage = response.data;
        }
      }
    } catch (error) {
      setIsLoading(false);

      _errorMessage = "An error occured, please try again later";
      return null;
    }
    return null;
  }

  Future getOrder({required int id}) async {
    setIsLoading(true);
    try {
      var response =
          await _api.getData(endpoint: 'payments/api/order/get/amount/$id');

      if (response!.statusCode == 200) {
        if (response!.statusCode == 200) {
          _activeModel = ActiveModel.fromJson(response.data);
          setIsLoading(false);
          return _activeModel!;
        } else {
          setIsLoading(false);
          _errorMessage = response.data;
          return null!;
        }
      }
    } catch (error) {
      setIsLoading(false);

      _errorMessage = "An error occured, please try again later";
      return null;
    }
  }

  String translateOrderStatus(String status) {
    switch (status) {
      case "2":
        return "Confirmed";
      case "3":
        return "Picked";
      case "4":
        return "Transit";
      case "5":
        return "Arrived";
      case "6":
        return "Received";
      case "7":
        return "Confirmed";
      case "8":
        return "Rejected";
      default:
        return "Created";
    }
  }

  String updateStatusInfo(String status) {
    switch (status) {
      case OrderStatus.created:
        return "Great ! Now let us get you a driver";
      case OrderStatus.partnerCreated:
        return "Great ! Now confirming your order";
      case OrderStatus.partnerConfirmed:
        return "Great ! Now confirming your order";
      default:
        return "Your order is confirmed";
    }
  }

  void handleRejectedOrder() async {
    _activeModel = ActiveModel();
    notifyListeners();
  }
}
