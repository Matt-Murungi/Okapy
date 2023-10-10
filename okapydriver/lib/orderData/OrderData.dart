import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:okapydriver/models/BookingDetailsModel.dart';
import 'package:okapydriver/models/BookingsModel.dart';
import 'package:okapydriver/models/completed.dart';
import 'package:okapydriver/utils/color.dart';
import 'package:okapydriver/orderData/components/body.dart';

class OrderData extends StatelessWidget {
  static String routerName = 'orderData';
  const OrderData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    BookingDetailsModel _booking = arg['bookings'] as BookingDetailsModel;
    CompletedJobs _completed = arg['completed'] as CompletedJobs;
    return Body(
      bookingDetailsModel: _booking,
      e: _completed,
    );
  }
}
