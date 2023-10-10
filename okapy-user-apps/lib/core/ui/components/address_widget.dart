import 'package:flutter/material.dart';

class AddressDetail extends StatelessWidget {
  final String addressType;
  final String address;
  final String image;
  const AddressDetail(
      {Key? key,
      required this.addressType,
      required this.address,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 0,
      minVerticalPadding: 0,
      leading: Image.asset(image),
      title: Text(addressType),
      trailing: Text(address),
    );
  }
}
