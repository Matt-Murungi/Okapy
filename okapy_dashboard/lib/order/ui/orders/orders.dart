import 'package:flutter/material.dart';
import 'package:okapy_dashboard/auth/domain/auth_controller.dart';
import 'package:okapy_dashboard/core/ui/component/information_card.dart';
import 'package:okapy_dashboard/core/ui/component/loader.dart';
import 'package:okapy_dashboard/core/ui/constants.dart';
import 'package:okapy_dashboard/order/controller/order_controller.dart';
import 'package:okapy_dashboard/order/ui/bookings/components/bookings_table.dart';
import 'package:okapy_dashboard/order/utils/constants.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  int selectedChipIndex = 0;
  bool isLoading = false;
  setIsLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  setSelectedChipIndex(int value) {
    setState(() {
      selectedChipIndex = value;
    });
  }

  viewUpdatedOrders(String status, int selectedChip) {
    setIsLoading(true);
    setSelectedChipIndex(selectedChip);

    Provider.of<OrderController>(context, listen: false)
        .getOrderByStatus(status)
        .then((value) {
      setIsLoading(false);
      if (value) {
        print("Value is $value");
      } else {
        print("Error is $value");
      }
    }).catchError((onError) => print("Error is $onError"));
  }

  @override
  void initState() {
    super.initState();
    Provider.of<OrderController>(context, listen: false)
        .getOrderByStatus(OrderStatus.partnerConfirmed);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(builder: (context, authController, child) {
      return isLoading
          ? const LoadingWidget()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<OrderController>(
                  builder: (context, orderController, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        InformationCard(
                            title: "Orders",
                            information: "${orderController.orders.length}",
                            iconColor: AppColors.primaryColor),
                        InformationCard(
                            title: "Paid",
                            information: "${orderController.getUnPaidOrders()}",
                            iconColor: AppColors.themeColorGreen),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      spacing: 10.0,
                      children: [
                        ChoiceChip(
                          selectedColor: AppColors.primaryColor,
                          label: const Text("Confirmed"),
                          selected: selectedChipIndex == 0,
                          onSelected: (isSelected) => viewUpdatedOrders(
                              OrderStatus.partnerConfirmed, 0),
                        ),
                        ChoiceChip(
                          selectedColor: AppColors.primaryColor,
                          label: const Text("Ready"),
                          selected: selectedChipIndex == 1,
                          onSelected: (isSelected) =>
                              viewUpdatedOrders(OrderStatus.created, 1),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    BookingsTable()
                  ],
                );
              }),
            );
    });
  }
}
