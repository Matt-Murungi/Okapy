import 'package:flutter/material.dart';
import 'package:okapy_dashboard/core/ui/component/buttons.dart';
import 'package:okapy_dashboard/core/ui/component/loader.dart';
import 'package:okapy_dashboard/core/ui/component/no_data_widget.dart';
import 'package:okapy_dashboard/core/ui/component/snack_bar.dart';
import 'package:okapy_dashboard/core/ui/component/text_input.dart';
import 'package:okapy_dashboard/core/ui/table.dart';
import 'package:okapy_dashboard/history/ui/components/history_view.dart';
import 'package:okapy_dashboard/order/controller/order_controller.dart';
import 'package:okapy_dashboard/order/ui/bookings/booking_view.dart';
import 'package:okapy_dashboard/order/utils/constants.dart';
import 'package:provider/provider.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  bool isLoading = false;
  setIsLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<OrderController>(context, listen: false).getAllOrders();
    Provider.of<OrderController>(context, listen: false).setSearchInputEmpty();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderController>(builder: (context, controller, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomTextInputField(
                title: "Search Customer Phone Number",
                textEditingController: controller.searchController,
                onChanged: (value) =>
                    controller.searchOrder(controller.searchController.text),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          controller.filteredPartnerSearch.isEmpty
              ? const NoDataWidget()
              : SizedBox(
                  child: isLoading
                      ? const LoadingWidget()
                      : SingleChildScrollView(
                          child: Card(
                            child: DataTable(
                                columnSpacing: 20.0,
                                horizontalMargin: 10.0,
                                columns: [
                                  buildTableHeader(""),
                                  buildTableHeader("Customer Name"),
                                  buildTableHeader("Customer Phone"),
                                  buildTableHeader("Amount"),
                                  buildTableHeader("Status"),
                                  buildTableHeader("Date Created"),
                                  buildTableHeader("Action"),
                                ],
                                rows: controller.filteredPartnerSearch
                                    .map((booking) => DataRow(
                                          cells: [
                                            DataCell(IconButton(
                                              tooltip: booking.isPaid!
                                                  ? "Order Paid"
                                                  : "Order Not Paid",
                                              icon: Icon(
                                                Icons.circle,
                                                size: 10,
                                                color: booking.isPaid!
                                                    ? Colors.green
                                                    : Colors.red,
                                              ),
                                              onPressed: () {},
                                            )),
                                            buildTableCell(
                                                "${booking.owner!.firstName} ${booking.owner!.lastName}"),
                                            buildTableCell(
                                                "${booking.owner!.phonenumber}"),
                                            buildTableCell("${booking.amount}"),
                                            buildTableCell(
                                                "${OrderStatus.translateStatus(booking.status!)}"),
                                            buildTableCell(
                                                "${booking.createdAt}"),
                                            DataCell(
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  ButtonWithIcon(
                                                      icon: Icons
                                                          .remove_red_eye_outlined,
                                                      tooltip: "View",
                                                      onPressed: () {
                                                        setIsLoading(true);
                                                        controller
                                                            .setSelectedOrder(
                                                                booking);
                                                        controller
                                                            .getOrderDetails(
                                                                booking)
                                                            .then((value) {
                                                          if (value != null) {
                                                            controller.getAddress(
                                                                controller
                                                                    .orderDetails!
                                                                    .receiver!
                                                                    .latitude!,
                                                                controller
                                                                    .orderDetails!
                                                                    .receiver!
                                                                    .longitude!);
                                                            setIsLoading(false);

                                                            displayHistoryView(
                                                                context);
                                                          } else {
                                                            setIsLoading(false);

                                                            buildSnackbar(
                                                                context,
                                                                "Error occured");
                                                          }
                                                        }).onError((error,
                                                                stackTrace) {
                                                          setIsLoading(false);

                                                          buildSnackbar(
                                                              context,
                                                              controller
                                                                  .errorMessage);
                                                        });
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
      );
    });
  }
}
