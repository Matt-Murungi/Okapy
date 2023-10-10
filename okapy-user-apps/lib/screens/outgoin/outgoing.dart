import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:okapy/screens/outgoin/components/information.dart';
import 'package:okapy/screens/outgoin/components/outgoing.dart';
import 'package:okapy/state/bookings.dart';
import 'package:okapy/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../core/api.dart';
import '../../core/locator.dart';
import '../../models/active_model.dart';
import '../../models/BookingsDetailsModel.dart';

class Outgoing extends StatefulWidget {
  const Outgoing({Key? key, required this.bookingDetailsModel, required this.driver})
      : super(key: key);
  final BookingDetailsModel bookingDetailsModel;
  final BookingDetailsModel driver;

  @override
  State<Outgoing> createState() => _OutgoingState();
}
Api _api = locator<Api>();
class _OutgoingState extends State<Outgoing> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("The image is $serverUrl${widget.bookingDetailsModel.product?.image}");
  }
  Future<ActiveModel> getAmount({required int id}) async {
    Response<dynamic> returnData =
    await _api.getData(endpoint: 'payments/api/order/get/amount/$id');
    print("The data is ${returnData.data}");
    return ActiveModel.fromJson(returnData.data);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Order Tracking',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Consumer<Bookings>(
        builder: (context, bookingController, child) => DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 25),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          "$serverUrl${widget.bookingDetailsModel.product?.image?.substring(1)}",
                        ),
                      )),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    bookingController
                                .bookingActiveModel?.product?.productType ==
                            1
                        ? Text(
                            'Electronics',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff1A411D)),
                          )
                        : bookingController
                                    .bookingActiveModel?.product?.productType ==
                                2
                            ? Text(
                                'Gift',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff1A411D)),
                              )
                            : bookingController.bookingActiveModel?.product
                                        ?.productType ==
                                    3
                                ? Text(
                                    'Document',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff1A411D)),
                                  )
                                : bookingController.bookingActiveModel?.product
                                            ?.productType ==
                                        4
                                    ? Text(
                                        'Package',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff1A411D)),
                                      )
                                    : Text(""),
                    FutureBuilder<ActiveModel>(
                      future: getAmount(id: bookingController.activeModel!.id!),
                      builder: (cont, snap) {
                        if (snap.hasData) {
                         return Text(
                            'Ksh.${snap.data!.amount}',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff1A411D)),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    )

                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 15),
                child: TabBar(
                  labelColor: Color(0xff1A411D),
                  indicatorColor: Color(0xff1A411D),
                  unselectedLabelColor: Color(0xffBDBDBD),
                  // us: Color(0xffBDBDBD),

                  unselectedLabelStyle: TextStyle(color: Color(0xffBDBDBD)),
                  indicatorSize: TabBarIndicatorSize.label,
                  automaticIndicatorColorAdjustment: true,
                  tabs: [
                    Tab(
                      child: Text(
                        'Information',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Timeline',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 2,
              ),
              Expanded(
                  child: TabBarView(children: [
                    InformationTab(
                        bookingActiveModel: widget.bookingDetailsModel,driver:widget.driver),
                const SizedBox(),

              ]))
            ],
          ),
        ),
      ),
    );
  }
}
