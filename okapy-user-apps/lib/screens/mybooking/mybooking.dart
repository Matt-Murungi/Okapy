import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:okapy/models/BookingsDetailsModel.dart';
import 'package:okapy/screens/outgoin/outgoing.dart';
import 'package:okapy/screens/utils/colors.dart';
import 'package:okapy/state/bookings.dart';
import 'package:provider/provider.dart';

import '../../core/api.dart';
import '../../core/locator.dart';
import '../home/components/outgoing.dart';

class Mybooking extends StatefulWidget {
  const Mybooking({Key? key}) : super(key: key);

  @override
  State<Mybooking> createState() => _MybookingState();
}

class _MybookingState extends State<Mybooking> {
  String? _others;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('My Bookings'),
          actions: const [Icon(Icons.search, size: 22)]),
      // body: Consumer<Bookings>(
      //   builder: (context, bookingsController, child) => bookingsController.busy
      //       ? const Center(
      //     child: CircularProgressIndicator(),
      //   )
      //       : SingleChildScrollView(
      //     child: Column(
      //       children: [
      //         ...bookingsController.bookingsList
      //             .map(
      //               (booking) => BookingMyBooking(
      //             bookingsController: bookingsController,
      //             booking: booking,
      //           ),
      //         )
      //             .toList(),
      //       ],
      //     ),
      //   ),
      // ),
      body: Consumer<Bookings>(
        builder: (context, bookingController, child) => DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width / 1.7,
                // alignment: Alignment.bottomCenter,
                // color: Colors.amber,
                child: const TabBar(
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
                        'ongoing',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Scheduled',
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
              SizedBox(
                height: ((MediaQuery.of(context).size.height / 1.2) - 50),
                child: TabBarView(
                  children: [ongoing(context), scheduled(context)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingMyBooking extends StatefulWidget {
  const BookingMyBooking({
    Key? key,
  }) : super(key: key);

  @override
  State<BookingMyBooking> createState() => _BookingMyBookingState();
}

class _BookingMyBookingState extends State<BookingMyBooking> {
  bool isLoading = true;
  List<String> months = [];
  List<BookingDetailsModel> bookings = [];
  Map<String, List<BookingDetailsModel>> data = {};
  Api _api = locator<Api>();

  @override
  void initState() {
    getAllOrders();
    super.initState();
  }

  getAllOrders() async {
    await _api.getData(endpoint: 'payments/api/owner/').then((value) {
      for (var i = 0; i < value.data.length; i++) {
        BookingDetailsModel bookingDetailsModel =
            BookingDetailsModel.fromJson(value.data[i]);
        String? date = bookingDetailsModel.booking?.scheduledDate;
        DateTime dt = DateFormat('MM/dd/yyyy HH:mm:ss').parse(date!);
        bookings.add(bookingDetailsModel);
        String monthString = getMonthInWords(dt.month);
        if (!months.contains(monthString)) {
          months.add(monthString);
        }
      }
      for (var value1 in months) {
        List<BookingDetailsModel> bookingToAdd = [];
        for (var value in bookings) {
          String? date = value.booking?.scheduledDate;
          DateTime dt = DateFormat('MM/dd/yyyy HH:mm:ss').parse(date!);
          if (value1 == getMonthInWords(dt.month)) {
            bookingToAdd.add(value);
          }
        }

        setState(() {
          data[value1] = bookingToAdd;
        });
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  String getMonthInWords(int month) {
    return [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ][month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('My Bookings'),
          actions: const [Icon(Icons.search, size: 22)]),
      body: isLoading
          ? Column(
              children: [LinearProgressIndicator()],
            )
          : CustomScrollView(
              slivers: data.entries
                  .map((e) => getListItemByMonth(e.key, e.value))
                  .toList(),
            ),
    );
  }

  Future<BookingDetailsModel> getBookingDetail({required int id}) async {
    //  id = 16;
    print("calledddd $id");
    late BookingDetailsModel _bookingsDetailsModel;
    await _api.getData(endpoint: 'bookings/api/confirm/$id').then((value) {
      _bookingsDetailsModel = BookingDetailsModel.fromJson(value.data);
      print("the details ${value.data['driver']}");
    });
    return _bookingsDetailsModel;
  }

  Widget listItem(BookingDetailsModel bookingDetailsModel) {
    String? date = bookingDetailsModel.booking?.scheduledDate!;
    int? id = bookingDetailsModel.booking?.id!;
    print("the id is ${id}");
    return FutureBuilder<BookingDetailsModel>(
      future: getBookingDetail(id: (id!)),
      builder:
          (BuildContext context, AsyncSnapshot<BookingDetailsModel> snapshot) {
        if (snapshot.hasData) {
          return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Outgoing(
                          bookingDetailsModel: snapshot.data!,
                          driver: bookingDetailsModel)),
                );
              },
              leading: snapshot.data?.product?.productType == "1"
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
                  : snapshot.data?.product?.productType == "2"
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
                      : snapshot.data?.product?.productType == "3"
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
                          : snapshot.data?.product?.productType == "4"
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
              title: snapshot.data?.product?.productType == "1"
                  ? const Text(
                      'Electronics',
                    )
                  : snapshot.data?.product?.productType == "2"
                      ? const Text('Gift')
                      : snapshot.data?.product?.productType == "3"
                          ? const Text('Document')
                          : snapshot.data?.product?.productType == "4"
                              ? const Text('Package')
                              : Text("${snapshot.data?.product?.productType}"),
              // subtitle: Text('2 Aug 2022'),
              subtitle: Text(
                date!,
                style: TextStyle(
                    color: themeColorGreen,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              trailing: Icon(Icons.arrow_forward_ios));
        } else if (snapshot.hasError) {
          return ListTile(
            onTap: () {},
            leading: Container(
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

            title: const Text(
              'Data error',
            ),
            // subtitle: Text('2 Aug 2022'),
            subtitle: Text(
              date!,
              style: TextStyle(
                  color: themeColorGreen,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            trailing: Text(""),
          );
        } else {
          return ListTile(
            onTap: () {},
            leading: CircularProgressIndicator(),

            title: const Text(
              'Loading...',
            ),
            // subtitle: Text('2 Aug 2022'),
            subtitle: Text(
              date!,
              style: TextStyle(
                  color: themeColorGreen,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            trailing: Text(""),
          );
        }
      },
    );
  }

  Widget getListItemByMonth(String month, List<BookingDetailsModel> listItems) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            month,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ),
        ...listItems.map((e) => listItem(e)).toList()
      ]),
    );
  }
}
