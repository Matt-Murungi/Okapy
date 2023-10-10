import 'package:flutter/material.dart';
import 'package:okapydriver/core/components/loading_indicator.dart';
import 'package:okapydriver/core/constants/colors.dart';
import 'package:okapydriver/utils/color.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final bool isOutlined;
  final void Function() onPressed;
  const PrimaryButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isOutlined = false});

  @override
  Widget build(BuildContext context) {
    const double buttonPadding = 20.0;
    return isOutlined
        ? OutlinedButton(
            style: ButtonStyle(
                side: MaterialStateProperty.all(
                    BorderSide(color: AppColors.primaryColor)),
                shadowColor: MaterialStateProperty.all(AppColors.customWhite),
                backgroundColor:
                    MaterialStateProperty.all(AppColors.customWhite)),
            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(buttonPadding),
              child: Text(
                text,
                style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
          )
        : TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(themeColorAmber)),
            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(buttonPadding),
              child: Text(
                text,
                style: TextStyle(
                    color: themeColorGreen,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
          );
  }
}

class SwippableButton extends StatelessWidget {
  final String text;
  final VoidCallback onSlide;
  const SwippableButton({
    super.key,
    required this.text,
    required this.onSlide,
  });

  @override
  Widget build(BuildContext context) {
    const double width = double.infinity;
    return Dismissible(
        key: const Key('slideToStartTripButton'),
        direction: DismissDirection.startToEnd,
        confirmDismiss: (_) async {
          onSlide();
          return false;
        },
        background: Container(
          color: AppColors.themeColorGrey,
          padding: const EdgeInsets.only(left: 16),
          alignment: Alignment.centerLeft,
          child: const Icon(
            Icons.airport_shuttle_sharp,
            color: Colors.white,
          ),
        ),
        child: SizedBox(
            width: width, child: PrimaryButton(onPressed: () {}, text: text)));
  }
}
