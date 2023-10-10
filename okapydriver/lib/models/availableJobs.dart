class AvailableJobs {
  int? id;
  String? amount;
  String? status;
  String? createdAt;
  Owner? owner;
  Booking? booking;
  Owner? driver;

  AvailableJobs(
      {this.id,
      this.amount,
      this.status,
      this.createdAt,
      this.owner,
      this.booking,
      this.driver});

  AvailableJobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    status = json['status'];
    createdAt = json['created_at'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    booking =
        json['booking'] != null ? Booking.fromJson(json['booking']) : null;
    driver = json['driver'] != null ? Owner.fromJson(json['driver']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['status'] = status;
    data['created_at'] = createdAt;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    if (booking != null) {
      data['booking'] = booking!.toJson();
    }
    if (driver != null) {
      data['driver'] = driver!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'AvailableJobs{id: $id, amount: $amount, status: $status, createdAt: $createdAt, owner: $owner, booking: $booking, driver: $driver}';
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
    data['is_confirmed'] = isConfirmed;
    return data;
  }

  @override
  String toString() {
    return 'Owner{id: $id, email: $email, firstName: $firstName, lastName: $lastName, image: $image, phonenumber: $phonenumber, isAdmin: $isAdmin, isDriver: $isDriver, isSuperuser: $isSuperuser, isActive: $isActive, dateJoined: $dateJoined, isConfirmed: $isConfirmed}';
  }
}

class Booking {
  int? id;
  String? bookingId;
  double? latitude;
  double? longitude;
  String? formatedAddress;
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
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['booking_id'] = bookingId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['formated_address'] = formatedAddress;
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

  @override
  String toString() {
    return 'Booking{id: $id, bookingId: $bookingId, latitude: $latitude, longitude: $longitude, formatedAddress: $formatedAddress, isActive: $isActive, vehicleType: $vehicleType, paymentType: $paymentType, scheduledDate: $scheduledDate, dateCreated: $dateCreated, owner: $owner}';
  }
}
