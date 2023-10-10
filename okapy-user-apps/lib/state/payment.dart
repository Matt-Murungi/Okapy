import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:okapy/core/api.dart';
import 'package:okapy/core/locator.dart';

class Payment extends ChangeNotifier {
  Api _api = locator<Api>();

  Future convertToOrder({
    required int bookingId,
    required int owner,
  }) async {
    return await _api.postHeaders(url: "payments/api/order/", data: {
      "owner": owner,
      "booking": bookingId,
    }).then((value) {
      print(value);
      print(value.statusCode);
      if (value.statusCode != 200) {
        return throw false;
      } else {
        return true;
      }
    }).catchError((error, stackTrace) {
      print(error);
      return throw false;
    });
  }

  Future initiatePayment({
    required String cardNo,
    required String user,
    required String expirationDate,
    required String amount,
    required String orderId,
    required String cardCode,
  }) async {
    print({
      "card_number": cardNo,
      "user": user,
      "expiration_date": expirationDate,
      "amount": amount,
      "order_id": orderId,
      "card_code": cardCode
    });
    print("ORDER IS ID ------------> "+orderId);
    return await _api
        .postHeadersFormDataToken(
            url: 'payments/api/payments/make/',
            data: FormData.fromMap({
              "card_number": cardNo,
              "user": user,
              "expiration_date": expirationDate,
              "amount": amount,
              "order_id": orderId,
              "card_code": cardCode
            }))
        .then((value) {
          print("The payment responce is ${value}");
      if (value.statusCode! > 250) {
        return throw false;
      } else {
        return true;
      }
    }).catchError((onError) {
      print(onError);
      return throw false;
    });
  }
}
