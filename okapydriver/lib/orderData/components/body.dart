import 'package:flutter/material.dart';
import 'package:okapydriver/models/BookingDetailsModel.dart';
import 'package:okapydriver/models/completed.dart';
import 'package:okapydriver/state/jobs.dart';
import 'package:okapydriver/utils/color.dart';
import 'package:okapydriver/orderData/components/body.dart';
import 'package:okapydriver/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Body extends StatefulWidget {
  final BookingDetailsModel bookingDetailsModel;
  final CompletedJobs e;
  const Body({Key? key, required this.bookingDetailsModel, required this.e})
      : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print( "thhe dis is $serverUrlAssets${widget.bookingDetailsModel.product?.image}  ");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,

        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Order history ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Consumer<AvailableJobsController>(
        builder: (context, availableJobsController, child) =>
            DefaultTabController(
          length: 2,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                              "$serverUrlAssets${widget.bookingDetailsModel.product?.image?.substring(1)}  ",
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.bookingDetailsModel.product?.productType == 1
                            ? const Text('Electronics')
                            : widget.bookingDetailsModel.product?.productType ==
                                    2
                                ? const Text('Gift')
                                : widget.bookingDetailsModel.product
                                            ?.productType ==
                                        3
                                    ? const Text('Document')
                                    : widget.bookingDetailsModel.product
                                                ?.productType ==
                                            4
                                        ? const Text('Package')
                                        : Text(
                                            "${widget.bookingDetailsModel.product?.productType}"),
                        Text(
                          'Ksh. ${widget.e.amount}',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: themeColorGreen),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ListTile(
                            leading: widget.bookingDetailsModel.product
                                        ?.productType ==
                                    1
                                ? Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            71, 7, 36, 154),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: const Icon(
                                      Icons.headphones,
                                      size: 30,
                                      color: Color(0xff07259A),
                                    ),
                                  )
                                : widget.bookingDetailsModel.product
                                            ?.productType ==
                                        2
                                    ? Container(
                                        // E1CAFF
                                        height: 47,
                                        width: 47,
                                        decoration: BoxDecoration(
                                            color: const Color(0xffE1CAFF),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                          child: Image.asset(
                                            'assets/giftBox.png',
                                            height: 27,
                                          ),
                                        ),
                                      )
                                    : widget.bookingDetailsModel.product
                                                ?.productType ==
                                            3
                                        ? Container(
                                            // E1CAFF
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                color: const Color(0xffDDF4FF),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Center(
                                              child: Image.asset(
                                                'assets/doc.png',
                                                height: 27,
                                              ),
                                            ),
                                          )
                                        : widget.bookingDetailsModel.product
                                                    ?.productType ==
                                                4
                                            ? Container(
                                                // E1CAFF
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffE2FFE3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
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
                                                    color:
                                                        const Color(0xffFFECB3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: const Center(
                                                    child: Icon(
                                                  Icons.add,
                                                  size: 30,
                                                )),
                                              ),
                            title: const Text('Instructions'),
                            subtitle: Text(
                              '${widget.bookingDetailsModel.product?.instructions}',
                              style: TextStyle(
                                fontSize: 12,
                                color: themeColorGrey,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => ConfirmPick()),
                            // );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  'Sender’s Details',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "${serverUrlAssets}${widget.bookingDetailsModel.booking?.owner?.image!}"),
                            ),
                            title: Text(
                              "${widget.bookingDetailsModel.booking?.owner?.firstName} ${widget.bookingDetailsModel.booking?.owner?.lastName}",
                              style: const TextStyle(fontSize: 12),
                            ),
                            trailing: Container(
                              height: 39,
                              width: 105,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.amber),
                                // color: const Color(0xff1A411D),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  final Uri url = Uri.parse(
                                      "tel:${widget.bookingDetailsModel.booking?.owner?.phonenumber}");

                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      color: themeColorAmber,
                                      size: 22,
                                    ),
                                    Text(
                                      'Call Sender',
                                      style: TextStyle(
                                          color: themeColorAmber,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                'Pickup Location',
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
                                  const EdgeInsets.only(left: 28.0, top: 15),
                              child:
                                  Image.asset('assets/locationblack-icon.png'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 8),
                              child: Text(
                                '${widget.e.booking?.formatedAddress}',
                                style: TextStyle(
                                    color: themeColorGrey, fontSize: 14),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
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
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 15),
                              child: Text(
                                '${widget.bookingDetailsModel.receiver?.formatedAddress}',
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
                              child: Image.asset('assets/profile.png'),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 15),
                              child: Text(
                                '${widget.bookingDetailsModel.receiver?.name}',
                                style: TextStyle(
                                    color: themeColorGrey, fontSize: 14),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                'Created on',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset('assets/clock-icon.png'),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  '${widget.e.createdAt}',
                                  style: TextStyle(color: themeColorGrey),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 39,
                          width: 255,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: themeColorAmber),
                            // color: const Color(0xff1A411D),
                          ),
                          child: InkWell(
                            onTap: () async {
                              availableJobsController.requestPayment(
                                  amount: widget.e.amount!,
                                  owner: widget.e.booking!.id!);

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Request Sent "),
                              ));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.monetization_on,
                                  color: themeColorAmber,
                                  size: 22,
                                ),
                                Text(
                                  'Request Payment',
                                  style: TextStyle(
                                      color: themeColorAmber,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
