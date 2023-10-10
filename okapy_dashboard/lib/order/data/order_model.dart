import '../../auth/data/user_model.dart';
import 'booking_model.dart';

class OrderModel {
  int? id;
  String? amount;
  String? status;
  String? createdAt;
  bool? isPaid;
  UserModel? owner;
  Booking? booking;
  dynamic driver;
  dynamic vehicle;

  OrderModel(
      {this.id,
      this.amount,
      this.status,
      this.createdAt,
      this.isPaid,
      this.owner,
      this.booking,
      this.driver,
      this.vehicle});

  OrderModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["amount"] is String) {
      amount = json["amount"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["is_paid"] is bool) {
      isPaid = json["is_paid"];
    }
    if (json["owner"] is Map) {
      owner = json["owner"] == null ? null : UserModel.fromJson(json["owner"]);
    }
    if (json["booking"] is Map) {
      booking =
          json["booking"] == null ? null : Booking.fromJson(json["booking"]);
    }
    driver = json["driver"];
    vehicle = json["vehicle"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["amount"] = amount;
    _data["status"] = status;
    _data["created_at"] = createdAt;
    _data["is_paid"] = isPaid;
    if (owner != null) {
      _data["owner"] = owner?.toJson();
    }
    if (booking != null) {
      _data["booking"] = booking?.toJson();
    }
    _data["driver"] = driver;
    _data["vehicle"] = vehicle;
    return _data;
  }
}

