import 'package:flutter/material.dart';
import 'package:okapy/screens/home/app_constants.dart';
import 'package:okapy/state/bookings.dart';
import 'package:provider/provider.dart';

class DriverFinding extends StatelessWidget {
  const DriverFinding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Bookings>(builder: (context, bookingsController, child) {
      return Column(
        children: [
          const SizedBox(
            height: 18.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Center(
              child: Text(
              bookingsController.updateStatusInfo(
                        bookingsController.activeModel!.status!),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const LinearProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(71, 7, 36, 154),
                    borderRadius: BorderRadius.circular(5)),
                child: Image.asset(
                    "${bookingsController.getProductType("${bookingsController.bookingsDetailsModel?.product?.productType}")["image"]}"),
              ),
              title: Text(bookingsController?.selectedPartner == null
                  ? " "
                  : "${bookingsController.selectedPartner!.name}"),
              subtitle: Text(
                bookingsController?.selectedPartner == null
                    ? '${bookingsController.bookingActiveModel?.booking?.formatedAddress}'
                    : "",
                style: const TextStyle(fontSize: 13),
              ),
              trailing: Text(
                'Ksh.${bookingsController.activeModel?.amount}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      );
    });
  }
}
