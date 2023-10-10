class ProfileDriver {
  int? id;
  bool? isApproved;
  Null? drivingLicense;
  Null? insurance;
  User? user;

  ProfileDriver(
      {this.id,
      this.isApproved,
      this.drivingLicense,
      this.insurance,
      this.user});

  ProfileDriver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isApproved = json['is_approved'];
    //drivingLicense = json.containsKey('driving_license')?json['driving_license']!=Null?json['driving_license']:'':'';
   // insurance = json.containsKey('insurance')?json['insurance']!=Null?json['insurance']:'':'';
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_approved'] = this.isApproved;
    data['driving_license'] = this.drivingLicense;
    data['insurance'] = this.insurance;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
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

  User(
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

  User.fromJson(Map<String, dynamic> json) {
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
