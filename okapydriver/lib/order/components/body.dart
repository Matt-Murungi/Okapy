import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:okapydriver/core/constants/colors.dart';
import 'package:okapydriver/state/jobs.dart';
import 'package:okapydriver/utils/color.dart';
import 'package:okapydriver/deliveryConfirmation/deliveryConfrmation.dart';
import 'package:okapydriver/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AvailableJobsController>(
      builder: (context, availableJobsController, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text('Order ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black)),
        ),
        body: DefaultTabController(
          length: 2,
          child: SingleChildScrollView(
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
                            "$serverUrlAssets${availableJobsController.bookingsDetailsModelActive?.product?.image}",
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
                      availableJobsController.bookingsDetailsModelActive
                                  ?.product?.productType ==
                              1
                          ? const Text('Electronics')
                          : availableJobsController.bookingsDetailsModelActive
                                      ?.product?.productType ==
                                  2
                              ? const Text('Gift')
                              : availableJobsController
                                          .bookingsDetailsModelActive
                                          ?.product
                                          ?.productType ==
                                      3
                                  ? const Text('Document')
                                  : availableJobsController
                                              .bookingsDetailsModelActive
                                              ?.product
                                              ?.productType ==
                                          4
                                      ? const Text('Package')
                                      : const Text(""),
                      Text(
                        'Ksh. ${availableJobsController.bookingsDetailsModelActive?.amount}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: themeColorGreen),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ListTile(
                          leading: availableJobsController
                                      .bookingsDetailsModelActive
                                      ?.product
                                      ?.productType ==
                                  1
                              ? Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(71, 7, 36, 154),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Icon(
                                    Icons.headphones,
                                    size: 30,
                                    color: Color(0xff07259A),
                                  ),
                                )
                              : availableJobsController
                                          .bookingsDetailsModelActive
                                          ?.product
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
                                  : availableJobsController
                                              .bookingsDetailsModelActive
                                              ?.product
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
                                      : availableJobsController
                                                  .bookingsDetailsModelActive
                                                  ?.product
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
                                                      BorderRadius.circular(5)),
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
                                                      BorderRadius.circular(5)),
                                              child: const Center(
                                                  child: Icon(
                                                Icons.add,
                                                size: 30,
                                              )),
                                            ),
                          title: availableJobsController
                                      .bookingsDetailsModelActive
                                      ?.product
                                      ?.productType ==
                                  1
                              ? const Text('Electronics')
                              : availableJobsController
                                          .bookingsDetailsModelActive
                                          ?.product
                                          ?.productType ==
                                      2
                                  ? const Text('Gift')
                                  : availableJobsController
                                              .bookingsDetailsModelActive
                                              ?.product
                                              ?.productType ==
                                          3
                                      ? const Text('Document')
                                      : availableJobsController
                                                  .bookingsDetailsModelActive
                                                  ?.product
                                                  ?.productType ==
                                              4
                                          ? const Text('Package')
                                          : const Text(""),
                          subtitle: Text(
                            '${availableJobsController.bookingsDetailsModelActive?.product?.instructions}',
                            style: TextStyle(
                              fontSize: 12,
                              color: themeColorGrey,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, DeliveryConfirmation.routerName);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                'Sender’s Details',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
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
                                "${serverUrlAssets}${availableJobsController.bookingsDetailsModelActive?.product?.image}"),
                          ),
                          title: Text(
                            "${availableJobsController.bookingsDetailsModelActive?.booking?.owner?.firstName} ${availableJobsController.bookingsDetailsModelActive?.booking?.owner?.lastName}",
                            style: const TextStyle(fontSize: 12),
                          ),
                          trailing: InkWell(
                            onTap: () async {
                              Uri url = Uri.parse(
                                  "tel:${availableJobsController.bookingsDetailsModelActive?.booking?.owner?.phonenumber}");
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: Container(
                              height: 39,
                              width: 105,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.amber),
                                // color: const Color(0xff1A411D),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Icon(
                                    Icons.phone,
                                    color: Colors.amber,
                                    size: 22,
                                  ),
                                  Text(
                                    'Call Sender',
                                    style: TextStyle(
                                        color: Colors.amber,
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
                            padding: const EdgeInsets.only(left: 28.0, top: 15),
                            child: Image.asset('assets/locationblack-icon.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8),
                            child: Text(
                              '${availableJobsController.bookingsDetailsModelActive?.booking?.formatedAddress}',
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
                            padding: const EdgeInsets.only(left: 30.0, top: 15),
                            child: Image.asset('assets/locationblack-icon.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 15),
                            child: Text(
                              '${availableJobsController.bookingsDetailsModelActive?.receiver?.formatedAddress}',
                              style: TextStyle(
                                  color: themeColorGrey, fontSize: 14),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0, top: 15),
                            child: Image.asset('assets/profile.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 15),
                            child: Text(
                              '${availableJobsController.bookingsDetailsModelActive?.receiver?.name}',
                              style: TextStyle(
                                  color: themeColorGrey, fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
