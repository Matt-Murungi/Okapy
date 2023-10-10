import 'package:flutter/material.dart';
import 'package:okapy_dashboard/core/ui/component/information_card.dart';
import 'package:okapy_dashboard/core/ui/constants.dart';
import 'package:okapy_dashboard/order/controller/order_controller.dart';

class OrderInformationSummaryCard extends StatelessWidget {
  final OrderController orderController;
  const OrderInformationSummaryCard({super.key, required this.orderController});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: SizedBox(
      child: Row(
        children: [
          InformationCard(
            iconColor: AppColors.primaryColor,
            title: "Orders",
            information: "${orderController.orders.length}",
          ),
          InformationCard(
            iconColor: AppColors.themeColorGreen,
            title: "Completed Orders",
            information: "${orderController.getAllCompletedOrders()}",
          ),
          InformationCard(
            iconColor: AppColors.themeColorRed,
            title: "Incompleted Orders",
            information: "${orderController.getAllIncompletedOrders()}",
          ),
        ],
      ),
    ));
  }
}
