import 'package:flutter/material.dart';
import 'package:okapydriver/utils/color.dart';

class LightTextSmall extends StatelessWidget {
  final String text;
  LightTextSmall({super.key, required this.text});

  final double fontsize = 12;
  final Color textColor = themeColorGrey;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: fontsize, color: textColor),
    );
  }
}

class TextBoldedSmallEclipsed extends StatelessWidget {
  final String text;
  TextBoldedSmallEclipsed({super.key, required this.text});

  final FontWeight fontWeight = FontWeight.bold;
  final Color textColor = themeColorGreen;
  double sizeDivider = 2;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        style: TextStyle(color: textColor, fontWeight: fontWeight),
      ),
    );
  }
}
