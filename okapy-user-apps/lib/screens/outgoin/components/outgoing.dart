import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:okapy/screens/utils/colors.dart';

class TimelineTab extends StatefulWidget {
  const TimelineTab({Key? key}) : super(key: key);

  @override
  State<TimelineTab> createState() => _TimelineTabState();
}

class _TimelineTabState extends State<TimelineTab> {
  @override
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stepper(
            currentStep: _index,
            onStepTapped: (int index) {
              setState(() {
                _index = index;
              });
            },
            controlsBuilder: (context, ControlsDetails controlls) {
              return Container();
            },
            steps: <Step>[
              Step(
                  title: const Text(
                    'Your parcel has been confirmed',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  content: Container(
                    alignment: Alignment.centerLeft,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.0, top: 4),
                        child: Text(
                          '2 Feb , 3:00 PM',
                          style: TextStyle(color: themeColorGrey, fontSize: 12),
                        ),
                      ),
                      Text(
                        'Saljona Apartment, Lower Kabete',
                        style: TextStyle(color: themeColorGrey, fontSize: 12),
                      ),
                    ],
                  ),
                  isActive: true,
                  state: StepState.complete),
              Step(
                  title: const Text(
                    'Your parcel has been Picked',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  content: Container(
                    alignment: Alignment.centerLeft,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.0, top: 4),
                        child: Text(
                          'Driver : Muhu Njenga',
                          style: TextStyle(color: themeColorGrey, fontSize: 12),
                        ),
                      ),
                      Text(
                        'KCB 3870T',
                        style: TextStyle(color: themeColorGrey, fontSize: 12),
                      ),
                    ],
                  ),
                  isActive: false,
                  // state: StepState.,
                  state: StepState.indexed),
              Step(
                title: const Text(
                  'Your parcel is on transit',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
                subtitle: Text(
                  'ETA : 2 Feb , 3:20 PM',
                  style: TextStyle(color: themeColorGrey, fontSize: 12),
                ),
                content: Container(
                  alignment: Alignment.centerLeft,
                  // child: const Text(
                  //   'ETA : 2 Feb , 3:20 PM',
                  //   style: TextStyle(color: themeColorGrey, fontSize: 12),
                  // ),
                ),
                isActive: false,
                state: StepState.indexed,
              ),
              Step(
                  title: const Text(
                    'The driver has arrived at the receiver',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.0, top: 4),
                        child: Text(
                          '2 Feb , 3:19 PM',
                          style: TextStyle(color: themeColorGrey, fontSize: 12),
                        ),
                      ),
                      Text(
                        'Brooke Manor, Lower Kabete',
                        style: TextStyle(color: themeColorGrey, fontSize: 12),
                      ),
                    ],
                  ),
                  content: Container(
                    alignment: Alignment.centerLeft,
                  ),
                  isActive: false,
                  state: StepState.indexed),
              Step(
                title: const Text(
                  'Parcel has been picked by the receiver confirmed',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 4.0, top: 4),
                      child: Text(
                        '2 Feb , 3:25 PM',
                        style: TextStyle(color: themeColorGrey, fontSize: 12),
                      ),
                    ),
                    Text(
                      'Brooke Manor, Lower Kabete',
                      style: TextStyle(color: themeColorGrey, fontSize: 12),
                    ),
                  ],
                ),
                content: Container(
                  alignment: Alignment.centerLeft,
                ),
                isActive: false,
                state: StepState.indexed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
