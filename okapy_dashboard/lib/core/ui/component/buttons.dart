import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:okapy_dashboard/core/ui/constants.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final bool isOutlined;
  final void Function() onPressed;
  final bool isDisabled;
  final IconData? icon;
  const PrimaryButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isOutlined = false,
      this.icon,
      this.isDisabled = false});

  @override
  Widget build(BuildContext context) {
    const double buttonPadding = 10.0;
    return isOutlined
        ? OutlinedButton(
            style: ButtonStyle(
                side: MaterialStateProperty.all(
                    BorderSide(color: AppColors.primaryColor)),
                shadowColor: MaterialStateProperty.all(AppColors.customWhite),
                backgroundColor:
                    MaterialStateProperty.all(AppColors.customWhite)),
            onPressed: isDisabled ? () {} : onPressed,
            child: Padding(
                padding: const EdgeInsets.all(buttonPadding),
                child: Text(
                  text,
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                )),
          )
        : TextButton(
            style: ButtonStyle(
                backgroundColor: isDisabled
                    ? MaterialStateProperty.all(AppColors.themeColorGrey)
                    : MaterialStateProperty.all(AppColors.primaryColor)),
            onPressed: isDisabled ? () {} : onPressed,
            child: Padding(
              padding: const EdgeInsets.all(buttonPadding),
              child: icon != null
                  ? Row(
                      children: [
                        Icon(
                          icon,
                          color: AppColors.themeColorGreen,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          text,
                          style: TextStyle(
                              color: isDisabled
                                  ? AppColors.themeColorGrey
                                  : AppColors.themeColorGreen,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )
                  : Text(
                      text,
                      style: TextStyle(
                          color: AppColors.themeColorGreen,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
            ),
          );
  }
}

class ButtonWithIcon extends StatelessWidget {
  final IconData icon;
  final String? tooltip;
  final void Function()? onPressed;
  const ButtonWithIcon({
    required this.icon,
    required this.onPressed,
    this.tooltip,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
      ),
    );
  }
}

class FloatingButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final Color? backgroundColor;
  FloatingButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      label: Text(label),
      backgroundColor:
          backgroundColor ??  AppColors.primaryColor,
    );
  }
}

class IconTextButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final void Function() onTap;
  const IconTextButton(
      {super.key,
      required this.label,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 100,
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.primaryColor,
            ),
            Text(
              label,
              style: TextStyle(color: AppColors.primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
