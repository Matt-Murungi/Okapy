import 'package:flutter/material.dart';
import 'package:okapydriver/core/constants/colors.dart';

class ModalScrollDivider extends StatelessWidget {
  const ModalScrollDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final horizontalMargin = MediaQuery.of(context).size.width / 2.2;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
      child: Divider(
        thickness: 6.0,
        color: AppColors.themeColorGrey,
      ),
    );
  }
}
