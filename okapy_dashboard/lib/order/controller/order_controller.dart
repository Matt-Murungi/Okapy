import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:okapy_dashboard/core/data/remote_data_source/api_requests.dart';
import 'package:okapy_dashboard/order/data/booking_collection_model.dart';
import 'package:okapy_dashboard/order/data/order_model.dart';
import 'package:okapy_dashboard/order/utils/constants.dart';
import '../../core/data/remote_data_source/network_urls.dart';

class OrderController extends ChangeNotifier {
  final _apiRequests = ApiRequests();

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  bool _isNewBookingAvailable = false;
  bool get isNewBookingAvailable => _isNewBookingAvailable;

  List<OrderModel> _orders = [];
  List<OrderModel> get orders => _orders;

  BookingCollectionModel? _orderDetails;
  BookingCollectionModel? get orderDetails => _orderDetails;

  String _formattedReceiverAddress = "";
  String get formattedReceiverAddress => _formattedReceiverAddress;

  OrderModel? _selectedOrder;
  OrderModel? get selectedOrder => _selectedOrder;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<OrderModel> _filteredPartnerSearch = [];
  List<OrderModel> get filteredPartnerSearch => _filteredPartnerSearch;

  TextEditingController searchController = TextEditingController();

  void setSelectedOrder(OrderModel booking) {
    _selectedOrder = booking;
    notifyListeners();
  }

  void setIsNewBookingAvailable(bool value) {
    _isNewBookingAvailable = value;
    notifyListeners();
  }

  setSearchInputEmpty() {
    searchController.text = "";
    notifyListeners();
  }

  Future getAllOrders() async {
    try {
      _orders = [];
      const url = NetworkUrl.methodOrderStatus;

      final response = await _apiRequests.getRequest(url: url);
      List responseList = response!.data;
      if (response.statusCode == HttpStatus.ok) {
        _orders = responseList
            .map((product) => OrderModel.fromJson(product))
            .toList();
        print("Order is $_orders");
        _filteredPartnerSearch = _orders;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response.data;
        notifyListeners();
        print("$_errorMessage");
        return false;
      }
    } catch (error, stack) {
      _errorMessage = error.toString();
      print("Get order by status$_errorMessage, $stack");
      return false;
    }
  }

  searchOrder(String input) {
    if (_orders.isNotEmpty) {
      if (input.isNotEmpty) {
        _filteredPartnerSearch = _orders
            .where((order) => order.booking!.owner!.phonenumber!
                .toLowerCase()
                .contains(input.toLowerCase()))
            .toList();
      } else {
        _filteredPartnerSearch = _orders;
      }
    } else {
      _filteredPartnerSearch = _orders;
    }
    notifyListeners();
  }

  Future getOrderByStatus(String statusId) async {
    try {
      _orders = [];
      final url = "${NetworkUrl.methodOrderStatus}/$statusId/";

      final response = await _apiRequests.getRequest(url: url);
      List responseList = response!.data;
      if (response.statusCode == HttpStatus.ok) {
        _orders = responseList
            .map((product) => OrderModel.fromJson(product))
            .toList();
        print("Order is $_orders");

        notifyListeners();
        return true;
      } else {
        _errorMessage = response.data;
        notifyListeners();
        print("$_errorMessage");
        return false;
      }
    } catch (error, stack) {
      _errorMessage = error.toString();
      print("Get order by status$_errorMessage, $stack");
      return false;
    }
  }

  getAllCompletedOrders() {
    return orders.where((order) => order.status == "5").length;
  }

  getAllIncompletedOrders() {
    return orders.where((order) => order.status != "5").length;
  }

  Future getOrderDetails(OrderModel booking) async {
    final url = "${NetworkUrl.methodOrder}/${booking.booking!.id}/";
    print("url $url");
    try {
      final response = await _apiRequests.getRequest(url: url);

      if (response!.statusCode == HttpStatus.ok) {
        _orderDetails = BookingCollectionModel.fromJson(response.data);
        print("response is ${response.data}");
        return _orderDetails;
      } else {
        _errorMessage = response.data;

        return null;
      }
    } catch (error) {
      _errorMessage = error.toString();
      _isLoading = false;

      return null;
    }
  }

  Future updateOrderStatus(Map<String, String> data) async {
    const url = NetworkUrl.methodOrderStatus;
    try {
      final response = await _apiRequests.postRequest(url: url, data: data);

      if (response!.statusCode == HttpStatus.ok) {
        print("response is ${response.data}");
        notifyListeners();
        return true;
      } else {
        notifyListeners();
        _errorMessage = response.data;
        return false;
      }
    } catch (error, stack) {
      print("$error, $stack");
      _errorMessage = error.toString();
      return false;
    }
  }

  Future acceptOrder() async {
    final data = {
      "id": "${selectedOrder!.id}",
      "status": OrderStatus.partnerConfirmed
    };

    return await updateOrderStatus(data);
  }

  Future getAddress(double latitude, double longitude) async {
    try {
      final response = await _apiRequests.getAddress(
          latitude: latitude, longitude: longitude);
      _formattedReceiverAddress =
          response!.data["results"][2]["formatted_address"];
    } catch (error) {
      _formattedReceiverAddress = "";
    }
  }

  int calculateDistance(double? latitude, double? longitude) {
    final km = Geolocator.distanceBetween(_orders.first.booking!.latitude!,
            _orders.first.booking!.longitude!, latitude!, longitude!) /
        1000;

    return km.toInt();
  }

  getOrderStatusName(orderStatus) {
    switch (orderStatus) {
      case "1":
        return "Created";
      case "2":
        return "Confirmed";
      case "3":
        return "Picked";
      case "4":
        return "Transit";
      case "5":
        return "arrived";
      default:
        return "status error";
    }
  }

  getUnPaidOrders() {
    notifyListeners();
    return _orders.where((order) => order.isPaid == false).length;
  }

  filterAllOrderByStatus(String status) {
    notifyListeners();
    return _orders.where((order) => order.status == status).length;
  }
}
