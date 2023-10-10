import 'package:flutter/material.dart';
import 'package:okapy/models/BookingsDetailsModel.dart';

import '../home/components/outgoing.dart';


class ScheduledBooking extends StatefulWidget{
  const ScheduledBooking({Key? key}) : super(key: key);

  @override
  State<ScheduledBooking> createState() => _ScheduledBooking();
}
class _ScheduledBooking extends State<ScheduledBooking> {
  BookingDetailsModel? _bookingDetailsModel;
  @override
  void initState() {
    // TODO: implement initState
    getStuff();
    super.initState();
  }

  getStuff() {
    // Future l =
    // widget.bookingsController.getBookingDetailID(id: widget.booking.id!);
    // l.then((value) {
    //   print(value.data);
    //   _bookingDetailsModel = BookingDetailsModel.fromJson(value.data);
    //   setState(() {
    //     _bookingDetailsModel = BookingDetailsModel.fromJson(value.data);
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        scheduled(context),

      ],
    );
  }
}