import 'package:flutter/cupertino.dart';
import 'package:okapy_dashboard/core/data/local_data_source/local_storage.dart';

class CoreController extends ChangeNotifier {
  Future<String> getPartnerDetails() async {
    final userName = await LocalStorage.getUserName();
    return userName;
  }
}
