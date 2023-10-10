import 'package:flutter/material.dart';
import 'package:okapy_dashboard/core/ui/component/information_card.dart';
import 'package:okapy_dashboard/core/ui/constants.dart';
import 'package:okapy_dashboard/payments/controller/payment_controller.dart';

class PaymentInformationSummaryCard extends StatelessWidget {
  final PaymentController paymentController;
  const PaymentInformationSummaryCard(
      {super.key, required this.paymentController});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: SizedBox(
      child: Row(
        children: [
          InformationCard(
            iconColor: AppColors.themeColorGreen,
            title: "Total Amount",
            information: "Ksh ${paymentController.getTotalPayment()}",
          ),
          InformationCard(
            iconColor: AppColors.themeColorRed,
            title: "Okapy Commission",
            information: "${paymentController.getOkapyCommission()}",
          ),
        ],
      ),
    ));
  }
}
