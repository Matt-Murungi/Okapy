class UserModel {
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

  UserModel(
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

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, firstName: $firstName, lastName: $lastName, '
        'image: $image, phonenumber: $phonenumber, isAdmin: $isAdmin, isDriver: $isDriver, '
        'isSuperuser: $isSuperuser, isActive: $isActive, dateJoined: $dateJoined)';
  }

  UserModel.fromJson(Map<String, dynamic> json) {
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
