import 'dart:io';

import 'package:flutter/material.dart';
import 'package:okapy_dashboard/core/data/remote_data_source/api_requests.dart';
import 'package:okapy_dashboard/core/data/remote_data_source/network_urls.dart';
import 'package:okapy_dashboard/core/utils/logger.dart';
import 'package:okapy_dashboard/payments/data/models/payment_model.dart';

class PaymentController extends ChangeNotifier {
  final _apiRequests = ApiRequests();
  List<PaymentModel> _payments = [];
  List<PaymentModel> get payments => _payments;

  PaymentModel? _selectedPayment;
  get selectedPayment => _selectedPayment;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  PaymentModel? _paymentModel;
  PaymentModel? get payment => _paymentModel;

  TextEditingController searchController = TextEditingController();

  List<PaymentModel> _paymentFilterPartnerSearch = [];
  List<PaymentModel> get filteredPartnerSearch => _paymentFilterPartnerSearch;

  getAllPayments() async {
    try {
      final response =
          await _apiRequests.getRequest(url: NetworkUrl.methodAllPayments);
      if (response!.statusCode == HttpStatus.ok) {
        List responsePaymentList = response.data;

        _payments = responsePaymentList
            .map((payment) => PaymentModel.fromJson(payment))
            .toList();
        _paymentFilterPartnerSearch = _payments;
        notifyListeners();
      } else {
        _errorMessage = response.data;
      }
    } catch (error) {
      _errorMessage = error.toString();
    }
  }

  searchPayment(String input) {
    if (_payments.isNotEmpty) {
      if (input.isNotEmpty) {
        _paymentFilterPartnerSearch = _payments
            .where((payment) => payment.owner!.phonenumber!
                .toLowerCase()
                .contains(input.toLowerCase()))
            .toList();
      } else {
        _paymentFilterPartnerSearch = _payments;
      }
    } else {
      _paymentFilterPartnerSearch = _payments;
    }
    notifyListeners();
  }

  getTotalPayment() {
    final total = _payments.fold(0.0, (total, payment) {
      return total + payment.amount!.toDouble();
    });
    return total;
  }

  getOkapyCommission() {
    final totalPayment = getTotalPayment();
    return totalPayment * 0.3;
  }

  getPaymentDetails(PaymentModel payment) async {
    final url = "${NetworkUrl.methodPaymentDetails}${payment.orderId}/";
    try {
      final response = await _apiRequests.getRequest(url: url);
      logger.d(response!.statusCode);
      if (response.statusCode == HttpStatus.ok) {
        _paymentModel = PaymentModel.fromJson(response.data);
        _selectedPayment = payment;
      } else {
        _errorMessage = response.data;
        print("$_errorMessage");
      }
    } catch (error) {
      _errorMessage = error.toString();
      print("$_errorMessage");
    }
  }
}
