
class ProductModel {
  int? id;
  bool? isActive;
  bool? isDeleted;
  String? dateCreated;
  dynamic dateDeleted;
  String? name;
  String? description;
  String? image;
  int? price;
  int? partner;
  Category? category;

  ProductModel({this.id, this.isActive, this.isDeleted, this.dateCreated, this.dateDeleted, this.name, this.description, this.image, this.price, this.partner, this.category});

  ProductModel.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["is_active"] is bool) {
      isActive = json["is_active"];
    }
    if(json["is_deleted"] is bool) {
      isDeleted = json["is_deleted"];
    }
    if(json["date_created"] is String) {
      dateCreated = json["date_created"];
    }
    dateDeleted = json["date_deleted"];
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["description"] is String) {
      description = json["description"];
    }
    if(json["image"] is String) {
      image = json["image"];
    }
    if(json["price"] is int) {
      price = json["price"];
    }
    if(json["partner"] is int) {
      partner = json["partner"];
    }
    if(json["category"] is Map) {
      category = json["category"] == null ? null : Category.fromJson(json["category"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["is_active"] = isActive;
    _data["is_deleted"] = isDeleted;
    _data["date_created"] = dateCreated;
    _data["date_deleted"] = dateDeleted;
    _data["name"] = name;
    _data["description"] = description;
    _data["image"] = image;
    _data["price"] = price;
    _data["partner"] = partner;
    if(category != null) {
      _data["category"] = category?.toJson();
    }
    return _data;
  }
}

class Category {
  int? id;
  bool? isActive;
  bool? isDeleted;
  String? dateCreated;
  dynamic dateDeleted;
  String? name;
  int? partner;

  Category({this.id, this.isActive, this.isDeleted, this.dateCreated, this.dateDeleted, this.name, this.partner});

  Category.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["is_active"] is bool) {
      isActive = json["is_active"];
    }
    if(json["is_deleted"] is bool) {
      isDeleted = json["is_deleted"];
    }
    if(json["date_created"] is String) {
      dateCreated = json["date_created"];
    }
    dateDeleted = json["date_deleted"];
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["partner"] is int) {
      partner = json["partner"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["is_active"] = isActive;
    _data["is_deleted"] = isDeleted;
    _data["date_created"] = dateCreated;
    _data["date_deleted"] = dateDeleted;
    _data["name"] = name;
    _data["partner"] = partner;
    return _data;
  }
}