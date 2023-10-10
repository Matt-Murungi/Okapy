import 'package:flutter/material.dart';
import 'package:okapy_dashboard/core/ui/component/heading_text.dart';
import 'package:okapy_dashboard/core/ui/component/list_tile.dart';
import 'package:okapy_dashboard/core/ui/component/modal_sheets.dart';

import 'package:okapy_dashboard/order/controller/order_controller.dart';
import 'package:provider/provider.dart';

displayHistoryView(BuildContext context) {
  return showSideSheet(context, BookingView());
}

class BookingView extends StatefulWidget {
  const BookingView({super.key});

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  bool isLoading = false;
  void setIsLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Consumer<OrderController>(builder: (context, controller, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              HeadingText(
                  text: "${controller.selectedOrder!.booking!.bookingId}"),
              const SizedBox(
                height: 30,
              ),
              const SubHeadingText(text: "Customer Details"),
              const Divider(),
              PaddedListTile(
                title: "Name",
                trailing:
                    "${controller.selectedOrder!.owner!.firstName!.toUpperCase()} ${controller.selectedOrder!.owner!.lastName!.toUpperCase()}",
              ),
              PaddedListTile(
                title: "Phone Number",
                trailing: "${controller.selectedOrder!.owner!.phonenumber}",
              ),
              const SizedBox(
                height: 30,
              ),
              const SubHeadingText(text: "Receiver Details"),
              const Divider(),
              PaddedListTile(
                title: "Name",
                trailing: "${controller.orderDetails!.receiver!.name}",
              ),
              PaddedListTile(
                title: "Phone Number",
                trailing: "${controller.orderDetails!.receiver!.phonenumber}",
              ),
              PaddedListTile(
                title: "Location",
                trailing: controller.formattedReceiverAddress,
              ),
              const SizedBox(
                height: 30,
              ),
              SubHeadingText(
                  text:
                      "Product Details - ${controller.orderDetails!.product!.length} products"),
              const Divider(),
              Column(
                children: controller.orderDetails!.product!
                    .map((order) => PaddedListTile(
                        title: "${order.name}", trailing: "${order.quantity}"))
                    .toList(),
              ),
              const Divider(),
              PaddedListTile(
                title: "Amount",
                trailing: "${controller.selectedOrder!.amount}",
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        }),
      ),
    );
  }
}
