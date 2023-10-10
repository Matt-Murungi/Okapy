import 'package:flutter/cupertino.dart';
import 'package:okapydriver/core/api.dart';
import 'package:okapydriver/core/locator.dart';

class EarningsController extends ChangeNotifier {
  final Api _api = locator<Api>();
  List history = [];
  double totals = 0;
  EarningsController() {
    getTotals();
  }

  getTotals() async {
    await _api.getData(endpoint: "payments/api/earnings/").then((value) {
      print(value);
    });
  }
}
