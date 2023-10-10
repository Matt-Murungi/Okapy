import 'package:flutter/material.dart';
import 'package:okapy_dashboard/core/ui/constants.dart';

class HeadingText extends StatelessWidget {
  final String text;
  const HeadingText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: AppColors.themeColorGreen),
    );
  }
}

class SubHeadingText extends StatelessWidget {
  final String text;
  final TextAlign align;
  const SubHeadingText(
      {super.key, required this.text, this.align = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic,
          color: AppColors.themeColorGreen),
    );
  }
}
