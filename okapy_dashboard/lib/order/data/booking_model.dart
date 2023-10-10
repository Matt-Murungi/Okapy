
import 'package:okapy_dashboard/auth/data/user_model.dart';


class Receiver {
  int? id;
  String? name;
  String? phonenumber;
  double? latitude;
  double? longitude;
  String? formatedAddress;

  Receiver({this.id, this.name, this.phonenumber, this.latitude, this.longitude, this.formatedAddress});

  Receiver.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["phonenumber"] is String) {
      phonenumber = json["phonenumber"];
    }
    if(json["latitude"] is double) {
      latitude = json["latitude"];
    }
    if(json["longitude"] is double) {
      longitude = json["longitude"];
    }
    if(json["formated_address"] is String) {
      formatedAddress = json["formated_address"];
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["phonenumber"] = phonenumber;
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["formated_address"] = formatedAddress;

    return _data;
  }
}

class Product {
  int? id;
  String? productType;
  String? name;
  String? quantity;
  dynamic image;
  dynamic instructions;

  Product({this.id, this.productType, this.name, this.quantity, this.image, this.instructions});

  Product.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["product_type"] is String) {
      productType = json["product_type"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["quantity"] is String) {
      quantity = json["quantity"];
    }
    image = json["image"];
    instructions = json["instructions"];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["product_type"] = productType;
    _data["name"] = name;
    _data["quantity"] = quantity;
    _data["image"] = image;
    _data["instructions"] = instructions;

    return _data;
  }
}


class Booking {
  int? id;
  String? bookingId;
  double? latitude;
  double? longitude;
  String? formatedAddress;
  dynamic otp;
  bool? isConfirmed;
  bool? isActive;
  String? vehicleType;
  String? paymentType;
  String? scheduledDate;
  String? dateCreated;
  UserModel? owner;
  int? partner;

  Booking({this.id, this.bookingId, this.latitude, this.longitude, this.formatedAddress, this.otp, this.isConfirmed, this.isActive, this.vehicleType, this.paymentType, this.scheduledDate, this.dateCreated, this.owner, this.partner});

  Booking.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["booking_id"] is String) {
      bookingId = json["booking_id"];
    }
    if(json["latitude"] is double) {
      latitude = json["latitude"];
    }
    if(json["longitude"] is double) {
      longitude = json["longitude"];
    }
    if(json["formated_address"] is String) {
      formatedAddress = json["formated_address"];
    }
    otp = json["otp"];
    if(json["is_confirmed"] is bool) {
      isConfirmed = json["is_confirmed"];
    }
    if(json["is_active"] is bool) {
      isActive = json["is_active"];
    }
    if(json["vehicle_type"] is String) {
      vehicleType = json["vehicle_type"];
    }
    if(json["payment_type"] is String) {
      paymentType = json["payment_type"];
    }
    if(json["scheduled_date"] is String) {
      scheduledDate = json["scheduled_date"];
    }
    if(json["date_created"] is String) {
      dateCreated = json["date_created"];
    }
    if(json["owner"] is Map) {
      owner = json["owner"] == null ? null : UserModel.fromJson(json["owner"]);
    }
    if(json["partner"] is int) {
      partner = json["partner"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["booking_id"] = bookingId;
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["formated_address"] = formatedAddress;
    _data["otp"] = otp;
    _data["is_confirmed"] = isConfirmed;
    _data["is_active"] = isActive;
    _data["vehicle_type"] = vehicleType;
    _data["payment_type"] = paymentType;
    _data["scheduled_date"] = scheduledDate;
    _data["date_created"] = dateCreated;
    if(owner != null) {
      _data["owner"] = owner?.toJson();
    }
    _data["partner"] = partner;
    return _data;
  }
}

