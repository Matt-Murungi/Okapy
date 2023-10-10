class CompletedJobs {
  int? id;
  String? amount;
  int? status;
  String? createdAt;
  Owner? owner;
  Booking? booking;
  Owner? driver;

  CompletedJobs(
      {this.id,
      this.amount,
      this.status,
      this.createdAt,
      this.owner,
      this.booking,
      this.driver});

  CompletedJobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    status = json['status'];
    createdAt = json['created_at'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    booking =
        json['booking'] != null ? new Booking.fromJson(json['booking']) : null;
    driver = json['driver'] != null ? new Owner.fromJson(json['driver']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    if (this.booking != null) {
      data['booking'] = this.booking!.toJson();
    }
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
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
  bool? isConfirmed;

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
      this.dateJoined,
      this.isConfirmed});

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
    isConfirmed = json['is_confirmed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['image'] = this.image;
    data['phonenumber'] = this.phonenumber;
    data['is_admin'] = this.isAdmin;
    data['is_driver'] = this.isDriver;
    data['is_superuser'] = this.isSuperuser;
    data['is_active'] = this.isActive;
    data['date_joined'] = this.dateJoined;
    data['is_confirmed'] = this.isConfirmed;
    return data;
  }
}

class Booking {
  int? id;
  String? bookingId;
  double? latitude;
  double? longitude;
  String? formatedAddress;
  bool? isActive;
  int? vehicleType;
  int? paymentType;
  String? scheduledDate;
  String? dateCreated;
  Owner? owner;

  Booking(
      {this.id,
      this.bookingId,
      this.latitude,
      this.longitude,
      this.formatedAddress,
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
    formatedAddress = json['formated_address'];
    isActive = json['is_active'];
    vehicleType = json['vehicle_type'];
    paymentType = json['payment_type'];
    scheduledDate = json['scheduled_date'];
    dateCreated = json['date_created'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['formated_address'] = this.formatedAddress;
    data['is_active'] = this.isActive;
    data['vehicle_type'] = this.vehicleType;
    data['payment_type'] = this.paymentType;
    data['scheduled_date'] = this.scheduledDate;
    data['date_created'] = this.dateCreated;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    return data;
  }
}
