import 'package:flutter/material.dart';
import 'package:okapy_dashboard/core/ui/utils/utils.dart';
import 'package:okapy_dashboard/order/ui/bookings/bookings.dart';

class DashboardDisplay extends StatelessWidget {
  const DashboardDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppUtils.getAppWidth(context),
      height: AppUtils.getAppHeight(context),
      child: const Bookings(),
    );
  }
}
