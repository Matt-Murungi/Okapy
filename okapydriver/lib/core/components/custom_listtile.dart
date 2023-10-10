import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:okapydriver/core/components/custom_text.dart';
import 'package:okapydriver/core/constants/colors.dart';
import 'package:okapydriver/order/order.dart';

class ModalListTile extends StatelessWidget {
  final String leadingImage;
  final String title;
  final String? trailing;
  ModalListTile(
      {super.key,
      required this.leadingImage,
      required this.title,
      this.trailing});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      minLeadingWidth: 4.0,
      
      leading: Image.asset(
        leadingImage,
      ),
      title: LightTextSmall(
        text: title,
      ),
      trailing:
          TextBoldedSmallEclipsed(text: trailing != null ? "$trailing" : " "),
    );
  }
}

class ModalListTileWithRating extends StatelessWidget {
  final String image;
  final String title;
  const ModalListTileWithRating(
      {super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      leading: CircleAvatar(
        radius: 18,
        child: Image.network(
          image,
          height: 40.0,
          width: 40.0,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      subtitle: RatingBarIndicator(
        rating: 2.75,
        itemBuilder: (context, index) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        itemCount: 5,
        itemSize: 10.0,
        direction: Axis.horizontal,
      ),
      trailing: InkWell(
        onTap: () => Navigator.pushNamed(context, Order.routerName),
        child: Text(
          "View Order Details",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontWeight: FontWeight.w700, color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
