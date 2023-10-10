
class PartnerModel {
  int? id;
  bool? isPartnerAvailable;
  bool? isActive;
  bool? isDeleted;
  dynamic dateDeleted;
  String? name;
  String? description;
  double? latitude;
  double? longitude;
  String? sector;
  String? dateCreated;
  String? image;
  String? openAt;
  String? closeAt;

  PartnerModel({this.id, this.isPartnerAvailable, this.isActive, this.isDeleted, this.dateDeleted, this.name, this.description, this.latitude, this.longitude, this.sector, this.dateCreated, this.image, this.openAt, this.closeAt});

  PartnerModel.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["is_partner_available"] is bool) {
      isPartnerAvailable = json["is_partner_available"];
    }
    if(json["is_active"] is bool) {
      isActive = json["is_active"];
    }
    if(json["is_deleted"] is bool) {
      isDeleted = json["is_deleted"];
    }
    dateDeleted = json["date_deleted"];
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["description"] is String) {
      description = json["description"];
    }
    if(json["latitude"] is double) {
      latitude = json["latitude"];
    }
    if(json["longitude"] is double) {
      longitude = json["longitude"];
    }
    if(json["sector"] is String) {
      sector = json["sector"];
    }
    if(json["date_created"] is String) {
      dateCreated = json["date_created"];
    }
    if(json["image"] is String) {
      image = json["image"];
    }
    if(json["open_at"] is String) {
      openAt = json["open_at"];
    }
    if(json["close_at"] is String) {
      closeAt = json["close_at"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["is_partner_available"] = isPartnerAvailable;
    _data["is_active"] = isActive;
    _data["is_deleted"] = isDeleted;
    _data["date_deleted"] = dateDeleted;
    _data["name"] = name;
    _data["description"] = description;
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["sector"] = sector;
    _data["date_created"] = dateCreated;
    _data["image"] = image;
    _data["open_at"] = openAt;
    _data["close_at"] = closeAt;
    return _data;
  }
}