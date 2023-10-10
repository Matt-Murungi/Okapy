import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:okapydriver/chat/chat.dart';
import 'package:okapydriver/core/components/buttons.dart';
import 'package:okapydriver/core/components/custom_divider.dart';
import 'package:okapydriver/core/components/custom_listtile.dart';
import 'package:okapydriver/core/components/custom_column.dart';
import 'package:okapydriver/core/components/loading_indicator.dart';
import 'package:okapydriver/core/constants/colors.dart';
import 'package:okapydriver/core/utils/utils.dart';
import 'package:okapydriver/landing/components/default.dart';
import 'package:okapydriver/landing/components/ongoing_order_buttons.dart';
import 'package:okapydriver/landing/components/ongoing_product_action_bar.dart';
import 'package:okapydriver/landing/components/ongoing_product_details.dart';
import 'package:okapydriver/landing/components/ongoing_product_list_tile.dart';
import 'package:okapydriver/landing/dialog/DeliveryConfirm.dart';
import 'package:okapydriver/landing/dialog/RateClient.dart';
import 'package:okapydriver/landing/landing.dart';
import 'package:okapydriver/order/order.dart';
import 'package:okapydriver/state/auth.dart';
import 'package:okapydriver/state/jobs.dart';
import 'package:okapydriver/utils/app_constants.dart';
import 'package:okapydriver/utils/color.dart';
import 'package:okapydriver/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:swipe/swipe.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../confirmBooking/confirmbooking.dart';
import '../../core/api.dart';
import '../../core/locator.dart';
import '../../state/vehicles.dart';

/**TODO LIST
 * Default driver location
 * Upload bank details
 * request for payment
 * On both apps login with phone number and password
 * Remove trace back root
 * Payment method on user to be selectable
 * SignUp Error
 * Flash messages on status change
 * Google maps crash on user
 * confirm payment
 * User booking hisroty detaus
 * Registration check
 * Waiting for approval
 * App user login issues
 * **/
Api _api = locator<Api>();

class Ongoing extends StatefulWidget {
  final AvailableJobsController availableJobsController;
  final ScrollController sc;
  final BuildContext context;

  const Ongoing(
      {super.key,
      required this.availableJobsController,
      required this.sc,
      required this.context});

  @override
  State<Ongoing> createState() => _OngoingState();
}

class _OngoingState extends State<Ongoing> {
  bool busy = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 95.0;
  bool jobState = false;
  bool status = false;

  @override
  Widget build(BuildContext context) {
    final double height = AppUtils.getHeight(context);
    final double width = AppUtils.getWidth(context);
    return Consumer<Auth>(
        builder: (context, authController, child) =>
            Consumer<AvailableJobsController>(
                builder: (context, availableJobsController, child) =>
                    availableJobsController.activeBookingBusy
                        ? const LoadingIndicator()
                        : !availableJobsController.isAvailableJobListEmpty()
                            ? Consumer<VehiclesController>(
                                builder: (context, vehicle, child) =>
                                    SingleChildScrollView(
                                      child: CustomColumn(
                                        left: 20,
                                        right: 20,
                                        isColumn: true,
                                        children: [
                                          SizedBox(
                                            height: height / 80,
                                          ),
                                          const ModalScrollDivider(),
                                          SizedBox(
                                            height: height / 400,
                                          ),
                                          OngoingProductListTile(
                                              availableJobsController:
                                                  availableJobsController),
                                          SizedBox(
                                            height: height / 50,
                                          ),
                                          OngoingProductDetails(
                                              availableJobsController:
                                                  availableJobsController),
                                          SizedBox(
                                            height: height / 100,
                                          ),
                                          OngoingOrderButtons(
                                            availableJobsController:
                                                availableJobsController,
                                            driver: authController,
                                          )
                                        ],
                                      ),
                                    ))
                            : SizedBox()));
  }
}


