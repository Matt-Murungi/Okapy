import 'package:flutter/material.dart';
import 'package:okapy_dashboard/core/ui/component/buttons.dart';
import 'package:okapy_dashboard/core/ui/component/snack_bar.dart';
import 'package:okapy_dashboard/core/ui/component/text_input.dart';
import 'package:okapy_dashboard/core/ui/table.dart';
import 'package:okapy_dashboard/payments/controller/payment_controller.dart';
import 'package:okapy_dashboard/payments/ui/components/payment_view.dart';
import 'package:provider/provider.dart';

class PaymentTableDetails extends StatefulWidget {
  final PaymentController paymentController;
  const PaymentTableDetails({super.key, required this.paymentController});

  @override
  State<PaymentTableDetails> createState() => _PaymentTableDetailsState();
}

class _PaymentTableDetailsState extends State<PaymentTableDetails> {
  bool isLoading = false;
  setIsLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var paymentController = context.read<PaymentController>();

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextInputField(
            title: "Search Customer Phone Number",
            textEditingController: paymentController.searchController,
            onChanged: (value) => paymentController
                .searchPayment(paymentController.searchController.text),
          ),
          Card(
            child: SingleChildScrollView(
              child: Card(
                child: DataTable(
                    columnSpacing: 20.0,
                    horizontalMargin: 10.0,
                    columns: [
                      buildTableHeader("Customer Name"),
                      buildTableHeader("Customer Phone"),
                      buildTableHeader("Amount"),
                      buildTableHeader("Date Created"),
                      buildTableHeader("Action"),
                    ],
                    rows: paymentController.filteredPartnerSearch
                        .map((payment) => DataRow(
                              cells: [
                                buildTableCell(
                                    "${payment.owner!.firstName} ${payment.owner!.lastName}"),
                                buildTableCell("${payment.owner!.phonenumber}"),
                                buildTableCell("${payment.amount}"),
                                buildTableCell("${payment.createdAt}"),
                                DataCell(
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ButtonWithIcon(
                                          icon: Icons.remove_red_eye_outlined,
                                          tooltip: "View",
                                          onPressed: () {
                                            setIsLoading(true);
                                            displayPaymentView(
                                                context, payment);
                                          }),
                                    ],
                                  ),
                                ),
                              ],
                            ))
                        .toList()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
