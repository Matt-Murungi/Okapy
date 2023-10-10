class VehiclesModel {
  dynamic id;
  String? regNumber;
  String? vehicleType;
  String? model;
  String? color;
  String? insuranceExpiry;
  Owner? owner;

  VehiclesModel(
      {this.id,
      this.regNumber,
      this.vehicleType,
      this.model,
      this.color,
      this.insuranceExpiry,
      this.owner});

  VehiclesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    regNumber = json['reg_number'];
    vehicleType = json['vehicle_type'];
    model = json['model'];
    color = json['color'];
    insuranceExpiry = json['insurance_expiry'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reg_number'] = this.regNumber;
    data['vehicle_type'] = this.vehicleType;
    data['model'] = this.model;
    data['color'] = this.color;
    data['insurance_expiry'] = this.insuranceExpiry;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    return data;
  }
}

class Owner {
  dynamic? id;
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
