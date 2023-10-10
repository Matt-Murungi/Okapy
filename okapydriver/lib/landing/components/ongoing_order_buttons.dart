import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:okapydriver/confirmBooking/confirmbooking.dart';
import 'package:okapydriver/core/components/buttons.dart';
import 'package:okapydriver/core/components/loading_indicator.dart';
import 'package:okapydriver/deliveryConfirmation/deliveryConfrmation.dart';
import 'package:okapydriver/landing/dialog/DeliveryConfirm.dart';
import 'package:okapydriver/landing/dialog/RateClient.dart';
import 'package:okapydriver/landing/landing.dart';
import 'package:okapydriver/state/auth.dart';
import 'package:okapydriver/state/jobs.dart';
import 'package:okapydriver/state/vehicles.dart';
import 'package:okapydriver/utils/app_constants.dart';
import 'package:provider/provider.dart';

class OngoingOrderButtons extends StatelessWidget {
  final AvailableJobsController availableJobsController;
  final Auth driver;

  const OngoingOrderButtons(
      {super.key, required this.availableJobsController, required this.driver});

  @override
  Widget build(BuildContext context) {
    return Consumer<VehiclesController>(
      builder: (context, vehicle, child) =>
          getJobState(availableJobsController.activeJobState!) == null
              ? const SizedBox()
              : availableJobsController.isLoading
                  ? LoadingIndicator()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SwippableButton(
                          text: getJobState(
                              availableJobsController.activeJobState!),
                          onSlide: () {
                            assignJobState(
                                availableJobsController.activeJobState!,
                                vehicle,
                                driver,
                                context);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        availableJobsController.activeJobState! ==
                                JobState.created
                            ? PrimaryButton(
                                text: "Decline Order",
                                onPressed: () {
                                  availableJobsController.clearJobData();
                                },
                                isOutlined: true,
                              )
                            : SizedBox(
                                height: 20,
                              )
                      ],
                    ),
    );
  }

  getJobState(int jobState) {
    switch (jobState) {
      case JobState.created:
        return 'Swipe Right To Accept Order';
      case JobState.confirmed:
        return 'Arrive for Pickup';
      case JobState.picked:
        return 'Confirm Pickup';
      case JobState.transit:
        return 'Arrive at destination';
      default:
        return null;
    }
  }

  assignJobState(int jobState, VehiclesController vehicle, Auth driver,
      BuildContext context) {
    switch (jobState) {
      case JobState.created:
        return {
          FlutterRingtonePlayer.stop(),
          Landing.isPlaying = false,
          availableJobsController.acceptJob(vehicle: vehicle)
        };
      case JobState.transit:
        return Navigator.push(context,
            MaterialPageRoute(builder: (context) => const RateClient()));

      default:
        return availableJobsController.confirmUpdate(driver: driver);
    }
  }
}
