import 'package:flutter/material.dart';
import 'package:okapy_dashboard/core/ui/constants.dart';

class InformationCard extends StatelessWidget {
  final String title;
  final String information;
  final Color iconColor;
  const InformationCard(
      {super.key,
      required this.title,
      required this.information,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.data_exploration,
                  color: iconColor,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            color: AppColors.lightGrey,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        information,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              ],
            )
            // child: ListTile(
            //   leading: Icon(
            //     Icons.circle,
            //     size: 30,
            //     color: iconColor,
            //   ),
            //   title: Text(
            //     title,
            //     style: TextStyle(
            //       fontSize: 14,
            //       color: AppColors.subtitleColor,
            //       fontWeight: FontWeight.w400,
            //     ),
            //   ),
            //   subtitle: Text(
            //     information,
            //     style: const TextStyle(fontSize: 20),
            //   ),
            // ),
            ),
      ),
    );
  }
}
