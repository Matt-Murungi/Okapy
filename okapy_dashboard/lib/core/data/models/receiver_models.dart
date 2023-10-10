
class ReceiverModel {
  int? id;
  String? name;
  String? phonenumber;
  double? latitude;
  double? longitude;
  String? formatedAddress;
  Booking? booking;

  ReceiverModel({this.id, this.name, this.phonenumber, this.latitude, this.longitude, this.formatedAddress, this.booking});

  ReceiverModel.fromJson(Map<String, dynamic> json) {
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
    if(json["booking"] is Map) {
      booking = json["booking"] == null ? null : Booking.fromJson(json["booking"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["phonenumber"] = phonenumber;
    data["latitude"] = latitude;
    data["longitude"] = longitude;
    data["formated_address"] = formatedAddress;
    if(booking != null) {
      data["booking"] = booking?.toJson();
    }
    return data;
  }
}

class Booking {
  int? id;
  String? bookingId;
  double? latitude;
  double? longitude;
  String? formatedAddress;
  String? otp;
  bool? isConfirmed;
  bool? isActive;
  String? vehicleType;
  String? paymentType;
  String? scheduledDate;
  String? dateCreated;
  Owner? owner;

  Booking({this.id, this.bookingId, this.latitude, this.longitude, this.formatedAddress, this.otp, this.isConfirmed, this.isActive, this.vehicleType, this.paymentType, this.scheduledDate, this.dateCreated, this.owner});

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
    if(json["otp"] is String) {
      otp = json["otp"];
    }
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["booking_id"] = bookingId;
    data["latitude"] = latitude;
    data["longitude"] = longitude;
    data["formated_address"] = formatedAddress;
    data["otp"] = otp;
    data["is_confirmed"] = isConfirmed;
    data["is_active"] = isActive;
    data["vehicle_type"] = vehicleType;
    data["payment_type"] = paymentType;
    data["scheduled_date"] = scheduledDate;
    data["date_created"] = dateCreated;
    if(owner != null) {
      data["owner"] = owner?.toJson();
    }
    return data;
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
  int? partner;
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
    if(json["partner"] is int) {
      partner = json["partner"];
    }
    if(json["date_joined"] is String) {
      dateJoined = json["date_joined"];
    }
    if(json["is_confirmed"] is bool) {
      isConfirmed = json["is_confirmed"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["email"] = email;
    data["first_name"] = firstName;
    data["last_name"] = lastName;
    data["image"] = image;
    data["phonenumber"] = phonenumber;
    data["is_admin"] = isAdmin;
    data["is_driver"] = isDriver;
    data["is_superuser"] = isSuperuser;
    data["is_active"] = isActive;
    data["partner"] = partner;
    data["date_joined"] = dateJoined;
    data["is_confirmed"] = isConfirmed;
    return data;
  }
}