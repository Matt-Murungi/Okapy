import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:okapy_dashboard/auth/domain/auth_controller.dart';
import 'package:okapy_dashboard/core/ui/component/information_card.dart';
import 'package:okapy_dashboard/core/ui/constants.dart';
import 'package:okapy_dashboard/home/ui/components/greeting.dart';
import 'package:okapy_dashboard/order/controller/order_controller.dart';
import 'package:okapy_dashboard/order/ui/bookings/components/bookings_table.dart';
import 'package:okapy_dashboard/order/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../../core/ui/component/loader.dart';

class Bookings extends StatefulWidget {
  const Bookings({super.key});

  @override
  State<Bookings> createState() => _BookingsState();
}


class _BookingsState extends State<Bookings> {
  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<OrderController>(context, listen: false)
            .getOrderByStatus(OrderStatus.partnerCreated),
        builder: (context, snapshot) {
          return Consumer<AuthController>(
              builder: (context, authController, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<OrderController>(
                  builder: (context, orderController, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Greetings(),
                    Text(
                      "Bookings",
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors.themeColorGreen,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    orderController.orders.isEmpty
                        ? const SizedBox.shrink()
                        : Row(
                            children: [
                              InformationCard(
                                  title: "Bookings",
                                  information:
                                      "${orderController.filterAllOrderByStatus(OrderStatus.partnerCreated)}",
                                  iconColor: AppColors.primaryColor),
                              InformationCard(
                                  title: "UnPaid",
                                  information:
                                      "${orderController.getUnPaidOrders()}",
                                  iconColor: AppColors.themeColorGreen),
                            ],
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    snapshot.hasData
                        ? const BookingsTable()
                        : const LoadingWidget()
                  ],
                );
              }),
            );
          });
        });
  }
}
