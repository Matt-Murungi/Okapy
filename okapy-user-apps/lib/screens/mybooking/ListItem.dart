import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:okapy/screens/utils/colors.dart';

import '../../core/api.dart';
import '../../core/locator.dart';
import '../../models/BookingsDetailsModel.dart';

class ListItem extends StatefulWidget {
  const ListItem({Key? key, required this.bookingDetailsModel}) : super(key: key);
  final BookingDetailsModel bookingDetailsModel;
  @override
  State<ListItem> createState() => _ListItem();
}

class _ListItem extends State<ListItem> {
  Api _api = locator<Api>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String? bookingID=widget.bookingDetailsModel.booking?.bookingId;
    getBookingDetail(id:int.parse(bookingID!));
  }
  late BookingDetailsModel _bookingsDetailsModel;

  bool isLoading=true;
  getBookingDetail({required int id}) async {
    //  id = 16;
    print("calledddd $id");

    await _api.getData(endpoint: 'bookings/api/confirm/$id').then((value) {
      setState(() {
        _bookingsDetailsModel = BookingDetailsModel.fromJson(value.data);
        isLoading=false;
      });

    });
  }
  @override
  Widget build(BuildContext context) {
    String? date=widget.bookingDetailsModel.booking?.scheduledDate!;
    return ListTile(
      onTap: () {

      },
      leading:isLoading?CircularProgressIndicator(): _bookingsDetailsModel.product?.productType == 1
          ? Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            color: const Color.fromARGB(71, 7, 36, 154),
            borderRadius: BorderRadius.circular(5)),
        child: const Icon(
          Icons.headphones,
          size: 30,
          color: Color(0xff07259A),
        ),
      )
          : _bookingsDetailsModel.product?.productType == 2
          ? Container(
        // E1CAFF
        height: 47,
        width: 47,
        decoration: BoxDecoration(
            color: const Color(0xffE1CAFF),
            borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Image.asset(
            'assets/giftBox.png',
            height: 27,
          ),
        ),
      )
          : _bookingsDetailsModel.product?.productType == 3
          ? Container(
        // E1CAFF
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            color: const Color(0xffDDF4FF),
            borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Image.asset(
            'assets/doc.png',
            height: 27,
          ),
        ),
      )
          : _bookingsDetailsModel.product?.productType == 4
          ? Container(
        // E1CAFF
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            color: const Color(0xffE2FFE3),
            borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Image.asset(
            'assets/package.png',
            height: 27,
          ),
        ),
      )
          : Container(
        // E1CAFF
        height: 47,
        width: 47,
        decoration: BoxDecoration(
            color: const Color(0xffFFECB3),
            borderRadius: BorderRadius.circular(5)),
        child: const Center(
            child: Icon(
              Icons.add,
              size: 30,
            )),
      ),

      title:isLoading?const Text("Loading..."): _bookingsDetailsModel.product?.productType == 1
          ? const Text(
        'Electronics',
      )
          : _bookingsDetailsModel?.product?.productType == 2
          ? const Text('Gift')
          : _bookingsDetailsModel?.product?.productType == 3
          ? const Text('Document')
          : _bookingsDetailsModel?.product?.productType == 4
          ? const Text('Package')
          :  Text("${_bookingsDetailsModel.product?.productType}"),
      // subtitle: Text('2 Aug 2022'),
      subtitle: Text(
        date!,
        style: TextStyle(
            color: themeColorGreen, fontSize: 14, fontWeight: FontWeight.w600),
      ),trailing: Text("data"),
    );
  }
}