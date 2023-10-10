
import 'booking_model.dart';

class BookingCollectionModel {
  Booking? booking;
  List<Product>? product;
  Receiver? receiver;

  BookingCollectionModel({this.booking, this.product, this.receiver});

  BookingCollectionModel.fromJson(Map<String, dynamic> json) {
    if(json["booking"] is Map) {
      booking = json["booking"] == null ? null : Booking.fromJson(json["booking"]);
    }
    if(json["product"] is List) {
      product = json["product"] == null ? null : (json["product"] as List).map((e) => Product.fromJson(e)).toList();
    }
    if(json["receiver"] is Map) {
      receiver = json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(booking != null) {
      _data["booking"] = booking?.toJson();
    }
    if(product != null) {
      _data["product"] = product?.map((e) => e.toJson()).toList();
    }
    if(receiver != null) {
      _data["receiver"] = receiver?.toJson();
    }
    return _data;
  }
}

