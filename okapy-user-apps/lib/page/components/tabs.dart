import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:okapy/page/components/tabsData.dart';
import 'package:okapy/screens/home/components/outgoing.dart';

class HomeTabsDumy extends StatefulWidget {
  const HomeTabsDumy({Key? key}) : super(key: key);

  @override
  State<HomeTabsDumy> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabsDumy> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    'Scheduled',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
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
              children: [ongoingDummy(context), scheduledDummy(context)],
            ),
          ),
        ],
      ),
    );
  }
}
