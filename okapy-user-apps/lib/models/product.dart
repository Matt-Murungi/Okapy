class ProctuctsModel {
  int? id;
  String? productType;
  String? image;
  String? instructions;
  Booking? booking;

  ProctuctsModel(
      {this.id, this.productType, this.image, this.instructions, this.booking});

  ProctuctsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productType = json['product_type'];
    image = json['image'];
    instructions = json['instructions'];
    booking =
        json['booking'] != null ? Booking.fromJson(json['booking']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_type'] = productType;
    data['image'] = image;
    data['instructions'] = instructions;
    if (booking != null) {
      data['booking'] = booking!.toJson();
    }
    return data;
  }
}

class Booking {
  int? id;
  String? bookingId;
  Null? latitude;
  Null? longitude;
  bool? isActive;
  String? vehicleType;
  String? paymentType;
  String? scheduledDate;
  String? dateCreated;
  Owner? owner;

  Booking(
      {this.id,
      this.bookingId,
      this.latitude,
      this.longitude,
      this.isActive,
      this.vehicleType,
      this.paymentType,
      this.scheduledDate,
      this.dateCreated,
      this.owner});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isActive = json['is_active'];
    vehicleType = json['vehicle_type'];
    paymentType = json['payment_type'];
    scheduledDate = json['scheduled_date'];
    dateCreated = json['date_created'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['booking_id'] = bookingId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['is_active'] = isActive;
    data['vehicle_type'] = vehicleType;
    data['payment_type'] = paymentType;
    data['scheduled_date'] = scheduledDate;
    data['date_created'] = dateCreated;
    if (owner != null) {
      data['owner'] = owner!.toJson();
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
  String? dateJoined;

  Owner(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.image,
      this.phonenumber,
      this.isAdmin,
      this.isDriver,
      this.isSuperuser,
      this.isActive,
      this.dateJoined});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
    phonenumber = json['phonenumber'];
    isAdmin = json['is_admin'];
    isDriver = json['is_driver'];
    isSuperuser = json['is_superuser'];
    isActive = json['is_active'];
    dateJoined = json['date_joined'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['image'] = image;
    data['phonenumber'] = phonenumber;
    data['is_admin'] = isAdmin;
    data['is_driver'] = isDriver;
    data['is_superuser'] = isSuperuser;
    data['is_active'] = isActive;
    data['date_joined'] = dateJoined;
    return data;
  }
}
