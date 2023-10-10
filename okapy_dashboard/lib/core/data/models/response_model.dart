class ResponseModel {
  int? statusCode;
  var data;

  ResponseModel({this.statusCode, this.data});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    if (json["statusCode"] is int) {
      statusCode = json["statusCode"];
      data = json["data"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["statusCode"] = statusCode;
    data["data"] = data;
    return data;
  }
}
