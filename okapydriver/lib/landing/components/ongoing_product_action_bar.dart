import 'package:flutter/material.dart';
import 'package:okapydriver/chat/chat.dart';
import 'package:okapydriver/state/jobs.dart';
import 'package:okapydriver/utils/color.dart';
import 'package:url_launcher/url_launcher.dart';

class OngoingActionBar extends StatelessWidget {
  final AvailableJobsController availableJobsController;
  final bool ontransit;
  const OngoingActionBar(
      {super.key,
      required this.availableJobsController,
      this.ontransit = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ontransit
            ? SizedBox.shrink()
            : FloatingActionButton.extended(
                elevation: 0,
                heroTag: 'cancel',
                backgroundColor: Colors.transparent,
                onPressed: () async {
                  availableJobsController.cancelJob();
                },
                label: Row(
                  children: [
                    Icon(
                      Icons.close_rounded,
                      size: 25,
                      color: Color(0xffBB1600),
                    ),
                    Text(
                      'Cancel',
                      style: TextStyle(
                        color: themeColorGreen,
                      ),
                    )
                  ],
                ),
              ),
        FloatingActionButton.extended(
            elevation: 0,
            heroTag: 'chat',
            backgroundColor: Colors.transparent,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatScreen()),
              );
            },
            label: Row(
              children: [
                Icon(
                  Icons.chat_outlined,
                  size: 25,
                  color: themeColorAmber,
                ),
                Text(
                  'Chat',
                  style: TextStyle(
                    color: themeColorGreen,
                  ),
                )
              ],
            )),
        FloatingActionButton.extended(
            elevation: 0,
            heroTag: 'call',
            backgroundColor: Colors.transparent,
            onPressed: () async {
              final Uri url = availableJobsController.activeJobState == 4
                  ? Uri.parse(
                      "tel:${availableJobsController.bookingsDetailsModelActive?.receiver?.phonenumber}")
                  : Uri.parse(
                      "tel:${availableJobsController.bookingsDetailsModelActive?.booking?.owner?.phonenumber}");

              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            label: Row(
              children: [
                Icon(
                  Icons.phone_outlined,
                  size: 25,
                  color: themeColorAmber,
                ),
                Text(
                  'Call',
                  style: TextStyle(
                    color: themeColorGreen,
                  ),
                )
              ],
            )),
      ],
    );
  }
}
