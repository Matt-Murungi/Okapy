import 'package:flutter/material.dart';
import 'package:okapy/screens/home/app_constants.dart';
import 'package:okapy/screens/home/components/driver_finding.dart';
import 'package:okapy/screens/home/components/outgoing.dart';
import 'package:okapy/state/bookings.dart';
import 'package:okapy/state/order.dart';
import 'package:provider/provider.dart';

class DeliveryStatus extends StatelessWidget {
  const DeliveryStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final preDriverAcceptedStatuses = [
      OrderStatus.created,
      OrderStatus.rejected,
      OrderStatus.partnerCreated,
      OrderStatus.partnerConfirmed,
    ];
    return Consumer<Bookings>(builder: (context, controller, child) {
      return preDriverAcceptedStatuses.contains(controller.activeModel!.status!)
          ? const DriverFinding()
          : const DriverFound();
    });
  }
}

class DriverFound extends StatelessWidget {
  const DriverFound({super.key});

  @override
  Widget build(BuildContext context) {
    return ongoing(context);
  }
}
