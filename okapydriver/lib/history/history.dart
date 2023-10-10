import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:okapydriver/history/components/completed.dart';
import 'package:okapydriver/history/components/tabs.dart';
import 'package:okapydriver/models/availableJobs.dart';
import 'package:okapydriver/state/auth.dart';
import 'package:okapydriver/state/jobs.dart';
import 'package:provider/provider.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0,
          backgroundColor: Colors.white,

          iconTheme: const IconThemeData(color: Colors.black),
          foregroundColor: Colors.black,
          title: const Text(
            'Order history ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: DefaultTabController(
          length: 2,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                  // alignment: Alignment.bottomCenter,
                  // color: Colors.amber,
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
                          'Scheduled',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Completed',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                  height: 2,
                ),
                Consumer<Auth>(
                  builder: (context, authController, child) =>
                      Consumer<AvailableJobsController>(
                    builder: (context, availableController, child) => SizedBox(
                      height: ((MediaQuery.of(context).size.height / 1.2) - 50),
                      child: TabBarView(
                        children: [
                          CompletedScreen(
                              auth: authController,
                              availableJobsController: availableController),
                          CompletedScreen(
                              auth: authController,
                              availableJobsController: availableController),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
