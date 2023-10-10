import 'package:flutter/material.dart';
import 'package:okapydriver/core/components/custom_text.dart';
import 'package:okapydriver/core/utils/utils.dart';
import 'package:okapydriver/landing/utils/constants.dart';
import 'package:okapydriver/order/order.dart';
import 'package:okapydriver/state/jobs.dart';
import 'package:okapydriver/utils/color.dart';

class OngoingProductListTile extends StatelessWidget {
  final AvailableJobsController availableJobsController;
  const OngoingProductListTile({
    required this.availableJobsController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double height = AppUtils.getHeight(context);
    double width = AppUtils.getWidth(context);
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          // leading widget
          SizedBox(
            width: 46,
            height: 29,
            child: !availableJobsController.productImage.contains("null")
                ? Image.network(
                    availableJobsController.productImage,
                    fit: BoxFit.cover,
                  )
                : CircleAvatar(
                    child: Icon(Icons.card_giftcard_outlined),
                  ),
          ),
          SizedBox(width: width / 20),
          // title and subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (() {
                  final productType = availableJobsController.productType;
                  switch (productType) {
                    case ProductType.electronics:
                      return const Text('Electronics');
                    case ProductType.gift:
                      return const Text('Gift');
                    case ProductType.document:
                      return const Text('Document');
                    case ProductType.package:
                      return const Text('Package');
                    default:
                      return const Text('Product');
                  }
                })(),
                SizedBox(height: height / 600),
                LightTextSmall(
                  text: '${availableJobsController.productInstructions}',
                ),
              ],
            ),
          ),
          // trailing widget
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ksh. ${availableJobsController.productAmount}',
                style: TextStyle(
                  color: themeColorGreen,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              LightTextSmall(
                text: ' ${availableJobsController.distance} ',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
