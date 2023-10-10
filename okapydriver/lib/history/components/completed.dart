import 'package:flutter/scheduler.dart';
import 'package:okapydriver/history/components/HistoryCard.dart';
import 'package:okapydriver/state/auth.dart';
import 'package:okapydriver/state/jobs.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:okapydriver/utils/color.dart';
import 'package:okapydriver/orderData/OrderData.dart';

class CompletedScreen extends StatefulWidget {
  final AvailableJobsController availableJobsController;
  final Auth auth;
  const CompletedScreen(
      {super.key, required this.availableJobsController, required this.auth});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  @override
  void initState() {
    // TODO: implement initState
    widget.availableJobsController
        .getCompletedJobs(id: widget.auth.userModel!.id!);
    super.initState();
  }

  Future<bool> rebuild() async {
    if (!mounted) return false;

    // if there's a current frame,
    if (SchedulerBinding.instance.schedulerPhase != SchedulerPhase.idle) {
      // wait for the end of that frame.
      await SchedulerBinding.instance.endOfFrame;
      if (!mounted) return false;
    }

    setState(() {});
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AvailableJobsController>(
        builder: (context, availableJobsController, child) => Consumer<Auth>(
            builder: (context, authController, child) => availableJobsController
                    .completedbusy
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        ...availableJobsController.completedJobs
                            .map((e) => e.driver != null
                                ? e.driver!.id == authController.userModel!.id
                                    ? HistoryCard(
                                        availableJobsController:
                                            availableJobsController,
                                        auth: authController,
                                        e: e)
                                    : const SizedBox()
                                : const SizedBox())
                            .toList()
                      ],
                    ),
                  )));
  }
}
