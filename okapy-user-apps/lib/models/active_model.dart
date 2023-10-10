
class ActiveModel {
  int? id;
  String? amount;
  String? status;
  String? createdAt;
  bool? isPaid;
  Owner? owner;
  Booking? booking;
  Driver? driver;
  Vehicle? vehicle;

  ActiveModel({this.id, this.amount, this.status, this.createdAt, this.isPaid, this.owner, this.booking, this.driver, this.vehicle});

  ActiveModel.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["amount"] is String) {
      amount = json["amount"];
    }
    if(json["status"] is String) {
      status = json["status"];
    }
    if(json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if(json["is_paid"] is bool) {
      isPaid = json["is_paid"];
    }
    if(json["owner"] is Map) {
      owner = json["owner"] == null ? null : Owner.fromJson(json["owner"]);
    }
    if(json["booking"] is Map) {
      booking = json["booking"] == null ? null : Booking.fromJson(json["booking"]);
    }
    if(json["driver"] is Map) {
      driver = json["driver"] == null ? null : Driver.fromJson(json["driver"]);
    }
    if(json["vehicle"] is Map) {
      vehicle = json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["amount"] = amount;
    _data["status"] = status;
    _data["created_at"] = createdAt;
    _data["is_paid"] = isPaid;
    if(owner != null) {
      _data["owner"] = owner?.toJson();
    }
    if(booking != null) {
      _data["booking"] = booking?.toJson();
    }
    if(driver != null) {
      _data["driver"] = driver?.toJson();
    }
    if(vehicle != null) {
      _data["vehicle"] = vehicle?.toJson();
    }
    return _data;
  }
}

class Vehicle {
  int? id;
  String? regNumber;
  String? vehicleType;
  String? model;
  String? color;
  String? insuranceExpiry;
  Owner2? owner;

  Vehicle({this.id, this.regNumber, this.vehicleType, this.model, this.color, this.insuranceExpiry, this.owner});

  Vehicle.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["reg_number"] is String) {
      regNumber = json["reg_number"];
    }
    if(json["vehicle_type"] is String) {
      vehicleType = json["vehicle_type"];
    }
    if(json["model"] is String) {
      model = json["model"];
    }
    if(json["color"] is String) {
      color = json["color"];
    }
    if(json["insurance_expiry"] is String) {
      insuranceExpiry = json["insurance_expiry"];
    }
    if(json["owner"] is Map) {
      owner = json["owner"] == null ? null : Owner2.fromJson(json["owner"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["reg_number"] = regNumber;
    _data["vehicle_type"] = vehicleType;
    _data["model"] = model;
    _data["color"] = color;
    _data["insurance_expiry"] = insuranceExpiry;
    if(owner != null) {
      _data["owner"] = owner?.toJson();
    }
    return _data;
  }
}

class Owner2 {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? image;
  String? phonenumber;
  bool? isAdmin;
  bool? isDriver;
  bool? isSuperuser;
  bool? isActive;
  dynamic partner;
  String? dateJoined;
  bool? isConfirmed;

  Owner2({this.id, this.email, this.firstName, this.lastName, this.image, this.phonenumber, this.isAdmin, this.isDriver, this.isSuperuser, this.isActive, this.partner, this.dateJoined, this.isConfirmed});

  Owner2.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["email"] is String) {
      email = json["email"];
    }
    if(json["first_name"] is String) {
      firstName = json["first_name"];
    }
    if(json["last_name"] is String) {
      lastName = json["last_name"];
    }
    if(json["image"] is String) {
      image = json["image"];
    }
    if(json["phonenumber"] is String) {
      phonenumber = json["phonenumber"];
    }
    if(json["is_admin"] is bool) {
      isAdmin = json["is_admin"];
    }
    if(json["is_driver"] is bool) {
      isDriver = json["is_driver"];
    }
    if(json["is_superuser"] is bool) {
      isSuperuser = json["is_superuser"];
    }
    if(json["is_active"] is bool) {
      isActive = json["is_active"];
    }
    partner = json["partner"];
    if(json["date_joined"] is String) {
      dateJoined = json["date_joined"];
    }
    if(json["is_confirmed"] is bool) {
      isConfirmed = json["is_confirmed"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["email"] = email;
    _data["first_name"] = firstName;
    _data["last_name"] = lastName;
    _data["image"] = image;
    _data["phonenumber"] = phonenumber;
    _data["is_admin"] = isAdmin;
    _data["is_driver"] = isDriver;
    _data["is_superuser"] = isSuperuser;
    _data["is_active"] = isActive;
    _data["partner"] = partner;
    _data["date_joined"] = dateJoined;
    _data["is_confirmed"] = isConfirmed;
    return _data;
  }
}

class Driver {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? image;
  String? phonenumber;
  bool? isAdmin;
  bool? isDriver;
  bool? isSuperuser;
  bool? isActive;
  dynamic partner;
  String? dateJoined;
  bool? isConfirmed;

  Driver({this.id, this.email, this.firstName, this.lastName, this.image, this.phonenumber, this.isAdmin, this.isDriver, this.isSuperuser, this.isActive, this.partner, this.dateJoined, this.isConfirmed});

  Driver.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["email"] is String) {
      email = json["email"];
    }
    if(json["first_name"] is String) {
      firstName = json["first_name"];
    }
    if(json["last_name"] is String) {
      lastName = json["last_name"];
    }
    if(json["image"] is String) {
      image = json["image"];
    }
    if(json["phonenumber"] is String) {
      phonenumber = json["phonenumber"];
    }
    if(json["is_admin"] is bool) {
      isAdmin = json["is_admin"];
    }
    if(json["is_driver"] is bool) {
      isDriver = json["is_driver"];
    }
    if(json["is_superuser"] is bool) {
      isSuperuser = json["is_superuser"];
    }
    if(json["is_active"] is bool) {
      isActive = json["is_active"];
    }
    partner = json["partner"];
    if(json["date_joined"] is String) {
      dateJoined = json["date_joined"];
    }
    if(json["is_confirmed"] is bool) {
      isConfirmed = json["is_confirmed"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["email"] = email;
    _data["first_name"] = firstName;
    _data["last_name"] = lastName;
    _data["image"] = image;
    _data["phonenumber"] = phonenumber;
    _data["is_admin"] = isAdmin;
    _data["is_driver"] = isDriver;
    _data["is_superuser"] = isSuperuser;
    _data["is_active"] = isActive;
    _data["partner"] = partner;
    _data["date_joined"] = dateJoined;
    _data["is_confirmed"] = isConfirmed;
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
  Owner? owner;
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
      owner = json["owner"] == null ? null : Owner.fromJson(json["owner"]);
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



class Owner {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? image;
  String? phonenumber;
  bool? isAdmin;
  bool? isDriver;
  bool? isSuperuser;
  bool? isActive;
  dynamic partner;
  String? dateJoined;
  bool? isConfirmed;

  Owner({this.id, this.email, this.firstName, this.lastName, this.image, this.phonenumber, this.isAdmin, this.isDriver, this.isSuperuser, this.isActive, this.partner, this.dateJoined, this.isConfirmed});

  Owner.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["email"] is String) {
      email = json["email"];
    }
    if(json["first_name"] is String) {
      firstName = json["first_name"];
    }
    if(json["last_name"] is String) {
      lastName = json["last_name"];
    }
    if(json["image"] is String) {
      image = json["image"];
    }
    if(json["phonenumber"] is String) {
      phonenumber = json["phonenumber"];
    }
    if(json["is_admin"] is bool) {
      isAdmin = json["is_admin"];
    }
    if(json["is_driver"] is bool) {
      isDriver = json["is_driver"];
    }
    if(json["is_superuser"] is bool) {
      isSuperuser = json["is_superuser"];
    }
    if(json["is_active"] is bool) {
      isActive = json["is_active"];
    }
    partner = json["partner"];
    if(json["date_joined"] is String) {
      dateJoined = json["date_joined"];
    }
    if(json["is_confirmed"] is bool) {
      isConfirmed = json["is_confirmed"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["email"] = email;
    _data["first_name"] = firstName;
    _data["last_name"] = lastName;
    _data["image"] = image;
    _data["phonenumber"] = phonenumber;
    _data["is_admin"] = isAdmin;
    _data["is_driver"] = isDriver;
    _data["is_superuser"] = isSuperuser;
    _data["is_active"] = isActive;
    _data["partner"] = partner;
    _data["date_joined"] = dateJoined;
    _data["is_confirmed"] = isConfirmed;
    return _data;
  }
}