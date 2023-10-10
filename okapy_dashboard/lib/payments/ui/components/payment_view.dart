import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:okapy_dashboard/core/routes/route_strings.dart';
import 'package:okapy_dashboard/core/ui/component/list_tile.dart';
import 'package:okapy_dashboard/core/ui/component/modal_sheets.dart';
import 'package:okapy_dashboard/core/ui/constants.dart';
import 'package:okapy_dashboard/payments/controller/payment_controller.dart';
import 'package:okapy_dashboard/payments/data/models/payment_model.dart';
import 'package:okapy_dashboard/payments/ui/payment.dart';
import 'package:provider/provider.dart';

displayPaymentView(BuildContext context, PaymentModel payment) {
  return showSideSheet(
      context,
      PaymentDetails(
        payment: payment,
      ));
}

class PaymentDetails extends StatelessWidget {
  static const String route = paymentDetailsRoute;
  final PaymentModel payment;
  const PaymentDetails({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    const headingTextStyle =
        TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
    const fontNormalTextStyle = TextStyle(
      fontSize: 16,
    );
    return Scaffold(body: Consumer<PaymentController>(
        builder: (context, paymentController, child) {
      const cardPadding = EdgeInsets.all(10.0);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () => context.go(homeRoute),
            child: Text(
              "Back",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Payments",
                style: headingTextStyle,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            child: Padding(
              padding: cardPadding,
              child: Column(
                children: [
                  CardListTile(
                    title: "Transaction ID",
                    subtitle: '${payment.transactionId}',
                  ),
                  CardListTile(
                    title: "Customer Name",
                    subtitle:
                        '${payment.owner?.firstName} ${payment.owner?.lastName}',
                  ),
                  CardListTile(
                    title: "Customer Name",
                    subtitle: '${payment.owner?.phonenumber}',
                  ),
                  CardListTile(
                    title: "Amount",
                    subtitle: 'Ksh ${payment.amount}',
                  ),
                  CardListTile(
                    title: "Created At",
                    subtitle: '${payment.createdAt}',
                  ),
                  CardListTile(
                    title: "Expiration Date",
                    subtitle: '${payment.expirationDate}',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );
    }));
  }
}
