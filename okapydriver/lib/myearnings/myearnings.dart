import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:okapydriver/state/earnings.dart';
import 'package:okapydriver/utils/color.dart';
import 'package:okapydriver/myearnings/components.dart';
import 'package:provider/provider.dart';

class MyEarnings extends StatefulWidget {
  const MyEarnings({Key? key}) : super(key: key);

  @override
  State<MyEarnings> createState() => _MyEarningsState();
}

class _MyEarningsState extends State<MyEarnings> {
  @override
  Widget build(BuildContext context) {
    var padding2 = Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width * .6) / 2,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .4,
                  child: Center(
                    child: Text(
                      'Dec 7-14',
                      style: TextStyle(color: themeColorGrey, fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width * .4) / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Weekly',
                        style: TextStyle(
                            color: themeColorGreen,
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Monthly',
                          style: TextStyle(
                              color: themeColorGrey,
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back_ios_new,
                  color: themeColorGrey,
                  size: 14,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 18.0,
                    right: 18.0,
                  ),
                  child: Text(
                    '200',
                    style: TextStyle(
                      fontSize: 20,
                      color: themeColorGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: themeColorGrey,
                  size: 14,
                )
              ],
            ),
            Container(
              height: 312,
              width: MediaQuery.of(context).size.width,
              child: BarGrapth(),
            ),
          ],
        ),
      ),
    );
    return Consumer<EarningsController>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: themeColorAmber.withOpacity(.38),
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          title: const Text(
            'Order history ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 107,
                        width: MediaQuery.of(context).size.width * .6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Text(
                                'Wallet balance',
                                style: TextStyle(
                                    fontSize: 14, color: themeColorGrey),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Text(
                                '${value.totals}',
                                style: TextStyle(
                                  fontSize: 26,
                                  color: themeColorGreen,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      value.totals < 1
                          ? SizedBox()
                          : Expanded(
                              child: Center(
                              child: SizedBox(
                                height: 49,
                                width: 106,
                                child: TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                themeColorAmber)),
                                    onPressed: () {},
                                    child: Text(
                                      'Withdraw',
                                      style: TextStyle(
                                        color: themeColorGreen,
                                      ),
                                    )),
                              ),
                            ))
                    ],
                  ),
                ),
              ),
              // padding2,
              Expanded(
                  child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Recent activity',
                            style:
                                TextStyle(color: themeColorGreen, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .85,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: SizedBox(
                              width: 326,
                              height: 45,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: themeColorGreen,
                                  ),
                                  // border: InputBorder()
                                  hintText: 'Search',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.calendar_today_rounded,
                          color: themeColorGreen,
                        )
                      ],
                    ),
                    ...value.history
                        .map((e) => ListTile(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => const Outgoing()),
                                // );
                              },
                              leading: Image.asset(
                                'assets/addal.png',
                                height: 29,
                              ),
                              title: Text('Groceries'),
                              subtitle: Text('2 Aug 2022'),
                              trailing: Text(
                                'Ksh.350',
                                style: TextStyle(
                                    color: themeColorGreen,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ))
                        .toList()
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
