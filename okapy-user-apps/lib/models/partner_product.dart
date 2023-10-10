class PartnerProductModel {
  int? id;
  bool? isActive;
  bool? isDeleted;
  String? dateCreated;
  dynamic dateDeleted;
  String? name;
  String? description;
  String? image;
  double? price;
  int? partner;

  PartnerProductModel(
      {this.id,
      this.isActive,
      this.isDeleted,
      this.dateCreated,
      this.dateDeleted,
      this.name,
      this.description,
      this.image,
      this.price,
      this.partner});

  @override
  String toString() {
    return 'PartnerProductModel(id: $id, isActive: $isActive, isDeleted: $isDeleted, '
        'dateCreated: $dateCreated, dateDeleted: $dateDeleted, name: $name, '
        'description: $description, image: $image, price: $price, partner: $partner)';
  }

  PartnerProductModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["is_active"] is bool) {
      isActive = json["is_active"];
    }
    if (json["is_deleted"] is bool) {
      isDeleted = json["is_deleted"];
    }
    if (json["date_created"] is String) {
      dateCreated = json["date_created"];
    }
    dateDeleted = json["date_deleted"];
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["image"] is String) {
      image = json["image"];
    }
    if (json["price"] is double) {
      price = json["price"];
    }
    if (json["partner"] is int) {
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
    _data["description"] = description;
    _data["image"] = image;
    _data["price"] = price;
    _data["partner"] = partner;
    return _data;
  }
}
