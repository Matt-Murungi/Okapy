import 'package:flutter/material.dart';
import 'package:okapy_dashboard/core/ui/constants.dart';
import 'package:okapy_dashboard/payments/controller/payment_controller.dart';
import 'package:okapy_dashboard/payments/ui/components/payment_information_summary_card.dart';
import 'package:okapy_dashboard/payments/ui/components/payment_table_details.dart';
import 'package:provider/provider.dart';

class Payment extends StatefulWidget {
  static String route = "/booking-create";
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  void initState() {
    super.initState();
    Provider.of<PaymentController>(context, listen: false).getAllPayments();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentController>(
        builder: (context, paymentController, child) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Payments",
                    style: TextStyle(
                        fontSize: 20,
                        color: AppColors.themeColorGreen,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  PaymentInformationSummaryCard(
                      paymentController: paymentController),
                  const SizedBox(
                    height: 15,
                  ),
                  PaymentTableDetails(paymentController: paymentController)
                ],
              ),
            ));
  }
}
