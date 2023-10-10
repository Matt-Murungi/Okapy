class OrderStatus {
  static const String created = "1";
  static const String confirmed = "2";
  static const String picked = "3";
  static const String transit = "4";
  static const String arrived = "5";
  static const String partnerCreated = "6";
  static const String partnerConfirmed = "7";
  static const String rejected = "8";

  static translateStatus(String status) {
    switch (status) {
      case OrderStatus.created:
        return "Created";
      case OrderStatus.confirmed:
        return "Confirmed";
      case OrderStatus.picked:
        return "Picked";
      case OrderStatus.transit:
        return "Transit";
      case OrderStatus.arrived:
        return "Arrived";
      case OrderStatus.partnerCreated:
        return "Needs Confirming";
      case OrderStatus.partnerConfirmed:
        return "Confirmed";
      case OrderStatus.rejected:
        return "Rejected";
    }
  }
}
