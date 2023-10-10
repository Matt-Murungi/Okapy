class BookingDetailsModel {
  Booking? booking;
  Product? product;
  Receiver? receiver;
  String? amount = "0";
  int? id;

  BookingDetailsModel(
      {this.booking, this.product, this.receiver, required this.id});

  BookingDetailsModel.fromJson(Map<String, dynamic> json) {
    print("Booking details model is $json");

    booking =
        json['booking'] != null ? new Booking.fromJson(json['booking']) : null;
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    receiver = json['receiver'] != null
        ? new Receiver.fromJson(json['receiver'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.booking != null) {
      data['booking'] = this.booking!.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.receiver != null) {
      data['receiver'] = this.receiver!.toJson();
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

class Product {
  int? id;
  String? productType;
  String? image;
  String? instructions;
  Booking? booking;

  Product(
      {this.id, this.productType, this.image, this.instructions, this.booking});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productType = json['product_type'];
    image = json['image'];
    instructions = json['instructions'];
    booking =
        json['booking'] != null ? new Booking.fromJson(json['booking']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_type'] = this.productType;
    data['image'] = this.image;
    data['instructions'] = this.instructions;
    if (this.booking != null) {
      data['booking'] = this.booking!.toJson();
    }
    return data;
  }
}

class Receiver {
  int? id;
  String? name;
  String? phonenumber;
  double? latitude;
  double? longitude;
  String? formatedAddress;
  Booking? booking;
  String? image;

  Receiver(
      {this.id,
      this.name,
      this.phonenumber,
      this.latitude,
      this.longitude,
      this.formatedAddress,
      this.booking,
      this.image});

  Receiver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phonenumber = json['phonenumber'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    formatedAddress = json['formated_address'];
    image = '';
    booking =
        json['booking'] != null ? new Booking.fromJson(json['booking']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phonenumber'] = this.phonenumber;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['formated_address'] = this.formatedAddress;
    if (this.booking != null) {
      data['booking'] = this.booking!.toJson();
    }
    return data;
  }
}
