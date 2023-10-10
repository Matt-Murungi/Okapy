import 'package:flutter/material.dart';
import 'package:okapydriver/core/components/custom_column.dart';
import 'package:okapydriver/core/components/custom_listtile.dart';
import 'package:okapydriver/landing/components/ongoing_product_action_bar.dart';
import 'package:okapydriver/state/jobs.dart';
import 'package:okapydriver/utils/app_constants.dart';

class OngoingProductDetails extends StatelessWidget {
  final AvailableJobsController availableJobsController;
  const OngoingProductDetails(
      {super.key, required this.availableJobsController});

  @override
  Widget build(BuildContext context) {
    print(
        "availableJobsController.activeJobState! ${availableJobsController.activeJobState!}");
    return CustomColumn(
      isColumn: true,
      children: [
        isJobStateCreated()
            ? ModalListTile(
                leadingImage: ImageConstant.pickupImageIcon,
                title: "Pickup",
                trailing: "${availableJobsController.productPickupAddress}",
              )
            : const SizedBox.shrink(),
        ModalListTile(
          leadingImage: ImageConstant.destinationImageIcon,
          title: "Destination",
          trailing: "${availableJobsController.productDestinationAddress}",
        ),
        const Divider(),
        !isJobStateCreated()
            ? Column(
                children: [
                  ModalListTileWithRating(
                    image: ImageConstant.personAvatarImage,
                    title: "${availableJobsController.receiverName}",
                  ),
                  isBetweenJobStateConfirmedAndJobStateTransit()
                      ? OngoingActionBar(
                          availableJobsController: availableJobsController,
                          ontransit: false)
                      : OngoingActionBar(
                          availableJobsController: availableJobsController,
                          ontransit: true)
                ],
              )
            : const SizedBox.shrink()
      ],
    );
  }

  bool isJobStateCreated() =>
      availableJobsController.activeJobState! == JobState.created;
  bool isBetweenJobStateConfirmedAndJobStateTransit() =>
      availableJobsController.activeJobState! >= JobState.confirmed &&
      availableJobsController.activeJobState! < JobState.transit;
}
