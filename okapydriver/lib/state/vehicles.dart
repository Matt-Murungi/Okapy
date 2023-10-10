import 'package:flutter/cupertino.dart';
import 'package:okapydriver/core/api.dart';
import 'package:okapydriver/core/locator.dart';
import 'package:okapydriver/models/vehicles.dart';

class VehiclesController extends ChangeNotifier {
  final Api _api = locator<Api>();
  final List<VehiclesModel> _vehicleList = [];

  List<VehiclesModel> get vehicleList => _vehicleList;
  bool _busy = false;

  bool get busy => _busy;

  VehiclesController(){
    getVehicles();
  }

  getVehicles() async {
    _busy = true;
    _vehicleList.clear();
    notifyListeners();
    await _api.getData(endpoint: 'vehicles/api/owner/').then((value) {
      print("The result is $value");
      for (var i = 0; i < value.data.length; i++) {
        _vehicleList.add(VehiclesModel.fromJson(value.data[i]));
      }
      notifyListeners();
    }).catchError((onError) {
      print("The result onError $onError");
    });
    _busy = false;
    notifyListeners();
  }

  Future addVehicle({
    required String rNumb,
    required String vType,
    required String model,
    required String color,
    required String date,
    required int owner,
  }) async {
    // await _api.post
    int id = 1;
    switch (vType.toLowerCase()) {
      case 'motorbike':
        id = 1;
        break;
      case 'car':
        id = 2;
        break;
      case 'van':
        id = 3;
        break;
      case 'truck':
        id = 4;
        break;
      default:
    }
    print("The input is ${{
      "reg_number": rNumb,
      'vehicle_type': id,
      'model': model,
      'color': color,
      'owner': owner
    }}");
    return await _api.postHeaders(url: 'vehicles/api/owner/', data: {
      "reg_number": rNumb,
      'vehicle_type': id,
      'model': model,
      'color': color,
      'owner': owner
    }).then((value) {
      print('The value is $value');
      return true;
    }).catchError((onError) {
      print('The error is ${onError}');
      return throw false;
    });
  }
}
