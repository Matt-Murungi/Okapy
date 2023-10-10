import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:okapy/core/ui/components/buttons.dart';
import 'package:okapy/core/ui/components/loading_widget.dart';
import 'package:okapy/screens/createbooking/createbooking.dart';
import 'package:okapy/screens/utils/colors.dart';
import 'package:okapy/state/auth.dart';
import 'package:okapy/state/bookings.dart';
import 'package:okapy/state/order.dart';
import 'package:okapy/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../core/api.dart';
import '../../core/locator.dart';
import '../home/home.dart';

class ConfirmBooking extends StatefulWidget {
  const ConfirmBooking({Key? key}) : super(key: key);

  @override
  State<ConfirmBooking> createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  String? selectedDate = "";
  String? selectedTime = "";
  bool isTapped = false;
  bool isLoading = false;
  bool busy = false;
  String orderId = "";
  List<String> items = ["Cash", "Card"];
  String dropdownValue = "Cash";
  final Api _api = locator<Api>();

  setLoadingState(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  String format(BuildContext context, TimeOfDay timeOfDay) {
    assert(debugCheckHasMediaQuery(context));
    assert(debugCheckHasMaterialLocalizations(context));
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    return localizations.formatTimeOfDay(timeOfDay,
        alwaysUse24HourFormat: true);
  }

  @override
  Widget build(BuildContext context) {
    var auth = context.read<Auth>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarCustom('Confirm Booking'),
      body: Consumer<Bookings>(
        builder: (context, bookingsController, child) {
          const textStyle =
              TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
          return bookingsController.busy
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                'Product Information',
                                style: textStyle,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: bookingsController.selectedPartner == null
                                ? ListTile(
                                    leading: Image.asset(
                                        "${bookingsController.getProductType(bookingsController.bookingsDetailsModel!.product!.productType.toString())["image"]}"),
                                    title: Text(
                                        "${bookingsController.getProductType(bookingsController.bookingsDetailsModel!.product!.productType.toString())["productType"]}"),
                                    subtitle: Text(
                                      '${bookingsController.bookingsDetailsModel?.product?.instructions}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: themeColorGrey,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  )
                                : ListTile(
                                    leading: Image.asset(
                                        "${bookingsController.getProductType(bookingsController.bookingsDetailsModel!.product!.productType.toString())["image"]}"),
                                    title: Text(
                                        "${bookingsController.selectedPartner!.name}"),
                                    subtitle: Text(
                                      '${bookingsController.getPartnerSector(bookingsController.selectedPartner!.sector!)}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: themeColorGrey,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  )),
                        SmallListTile(
                            title: "Vehicle type",
                            trailing:
                                "${bookingsController.getVehicleType(bookingsController.bookingsModel!.vehicleType.toString())["vehicleType"]}"),
                        bookingsController.selectedPartner != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    'Total Price',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SmallListTile(
                                    title: "Item Total Price",
                                    trailing:
                                        "${bookingsController.partnerItemTotalPrice}",
                                  ),
                                  SmallListTile(
                                    title: "Delivery Fee",
                                    trailing:
                                        "${bookingsController.vehiclePrice}",
                                  ),
                                ],
                              )
                            : SmallListTile(
                                title: "Amount",
                                trailing: "${bookingsController.vehiclePrice}",
                              ),
                        Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 25),
                            child: bookingsController
                                        .bookingActiveModel?.product?.image !=
                                    null
                                ? Container(
                                    height: 200,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        // color: Colors.black,
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            "$serverUrlAssets${bookingsController.bookingActiveModel?.product?.image}",
                                          ),
                                        )),
                                  )
                                : null),
                        bookingsController.selectedPartner != null
                            ? const SizedBox.shrink()
                            : Column(
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 20.0, top: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Pickup Location',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 28.0, top: 15),
                                        child: Image.asset(
                                            'assets/locationblack-icon.png'),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 8),
                                          child: Text(
                                            '${bookingsController.bookingActiveModel?.booking?.formatedAddress}',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: themeColorGrey,
                                                fontSize: 14),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20.0, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Receiver’s Details',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 30.0, top: 15),
                              child:
                                  Image.asset('assets/locationblack-icon.png'),
                            ),
                            Flexible(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 15),
                                child: Text(
                                  '${bookingsController.bookingActiveModel?.receiver?.formatedAddress}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: themeColorGrey, fontSize: 14),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 30.0, top: 15),
                              child: Image.asset('assets/profile.png'),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 15),
                              child: Text(
                                '${bookingsController.bookingActiveModel?.receiver?.name}',
                                style: TextStyle(
                                    color: themeColorGrey, fontSize: 14),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 30.0, top: 15),
                              child: Image.asset('assets/phone-icon.png'),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 15),
                              child: Text(
                                '${bookingsController.bookingActiveModel?.receiver?.phonenumber}',
                                style: TextStyle(
                                    color: themeColorGrey, fontSize: 14),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20.0, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Payment method',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            const Icon(Icons.wallet),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .3,
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField(
                                elevation: 0,
                                isExpanded: true,
                                value: dropdownValue,
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                                decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white))),
                              )),
                            )
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                'Total amount',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                bookingsController.selectedPartner != null
                                    ? 'Ksh ${double.parse(bookingsController.partnerItemTotalPrice) + bookingsController.vehiclePrice}'
                                    : "",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        isTapped == true
                            ? Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime(2100));

                                            if (pickedDate != null) {
                                              print(
                                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                              String formattedDate =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(pickedDate);
                                              print(formattedDate);
                                              setState(() {
                                                selectedDate = formattedDate;
                                              });
                                            }
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(15.0),
                                            padding: const EdgeInsets.all(3.0),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: themeColorAmber)),
                                            child: Text(selectedDate == ""
                                                ? 'Select Date'
                                                : selectedDate!),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () async {
                                            TimeOfDay? pickedTime =
                                                await showTimePicker(
                                              initialTime: TimeOfDay.now(),
                                              initialEntryMode:
                                                  TimePickerEntryMode.dialOnly,
                                              context: context,
                                            );
                                            if (pickedTime != null) {
                                              String time =
                                                  format(context, pickedTime);
                                              print("The time is $time");
                                              setState(() {
                                                selectedTime = time;
                                              });
                                            }
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(15.0),
                                            padding: const EdgeInsets.all(3.0),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: themeColorAmber)),
                                            child: Text(selectedTime == ""
                                                ? 'Select time'
                                                : selectedTime!),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        if (selectedDate == "") {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Select date First")));
                                        } else if (selectedTime == "") {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Select Time first")));
                                        } else {
                                          int? id = bookingsController
                                              .bookingsDetailsModel
                                              ?.booking
                                              ?.id;
                                          int? owner =
                                              bookingsController.userModel?.id;

                                          bookingsController.scheduleBooking({
                                            "owner": owner.toString(),
                                            "id": id.toString(),
                                            "scheduled_date":
                                                "$selectedDate $selectedTime"
                                          },
                                              auth: auth
                                                  .authModel!).then((value) => value
                                              ? ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Booking scheduled")))
                                              : ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Booking scheduled"))));
                                        }
                                      },
                                      child: Container(
                                        height: 50,
                                        margin: const EdgeInsets.all(15.0),
                                        padding: const EdgeInsets.all(3.0),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: themeColorAmber)),
                                        child: Center(
                                            child: isLoading == false
                                                ? const Text('Schedule')
                                                : CircularProgressIndicator(
                                                    color: themeColorAmber,
                                                  )),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconedButton(
                              label: "Schedule",
                              icon: Icons.calendar_month_outlined,
                              onPressed: () {
                                setState(() {
                                  isTapped = true;
                                });
                              },
                              isOutlined: true,
                            ),
                            isLoading
                                ? const LoadingWidget()
                                : PrimaryButton(
                                    text: "Confirm Booking",
                                    onPressed: () {
                                      setLoadingState(true);
                                      Map<String, dynamic> data =
                                          bookingsController.selectedPartner !=
                                                  null
                                              ? {
                                                  "booking":
                                                      "${bookingsController.bookingActiveModel!.booking!.id!}",
                                                  "owner":
                                                      "${bookingsController.bookingActiveModel!.booking!.owner!.id!}",
                                                  "amount":
                                                      "${double.parse(bookingsController.partnerItemTotalPrice) + bookingsController.vehiclePrice}",
                                                  "status": "6",
                                                }
                                              : {
                                                  "booking":
                                                      "${bookingsController.bookingActiveModel!.booking!.id!}",
                                                  "owner":
                                                      "${bookingsController.bookingActiveModel!.booking!.owner!.id!}",
                                                        "amount":
                                                    "${bookingsController.vehiclePrice}",
                                                };
                                      print("Confirm data is ${data}");
                                      bookingsController
                                          .convertToOrder(data: data)
                                          .then((value) {
                                        if (value) {
                                          bookingsController.postPaymentType(
                                              order_id: bookingsController
                                                  .activeModel!.id!,
                                              paymentType: dropdownValue);
                                          setLoadingState(false);
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute<void>(
                                                builder:
                                                    (BuildContext context) =>
                                                        const Home(),
                                              ),
                                              (route) => false);
                                        } else {
                                          setLoadingState(false);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(bookingsController
                                                      .errorMessage)));
                                        }
                                      }).catchError((onError) {
                                        setState(() {
                                          busy = false;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content:
                                              Text("Booking was successful"),
                                        ));
                                        setState(() {
                                          busy = false;
                                        });
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  const Home(),
                                            ),
                                            (route) => false);
                                      });
                                    })
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        )
                      ],
        ),

                );
        },
      ),
    );
  }
}

class SmallListTile extends StatelessWidget {
  final String title, trailing;
  const SmallListTile({super.key, required this.title, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ListTile(
        title: Text(title),
        trailing: Text(trailing),
      ),
    );
  }
}
