
class PaymentModel {
  int? id;
  int? amount;
  String? status;
  dynamic transactionId;
  String? orderId;
  dynamic cardCode;
  String? expirationDate;
  String? createdAt;
  Owner? owner;

  PaymentModel({this.id, this.amount, this.status, this.transactionId, this.orderId, this.cardCode, this.expirationDate, this.createdAt, this.owner});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["amount"] is int) {
      amount = json["amount"];
    }
    if(json["status"] is String) {
      status = json["status"];
    }
    transactionId = json["transaction_id"];
    if(json["order_id"] is String) {
      orderId = json["order_id"];
    }
    cardCode = json["card_code"];
    if(json["expiration_date"] is String) {
      expirationDate = json["expiration_date"];
    }
    if(json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if(json["owner"] is Map) {
      owner = json["owner"] == null ? null : Owner.fromJson(json["owner"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["amount"] = amount;
    data["status"] = status;
    data["transaction_id"] = transactionId;
    data["order_id"] = orderId;
    data["card_code"] = cardCode;
    data["expiration_date"] = expirationDate;
    data["created_at"] = createdAt;
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