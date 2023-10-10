import 'package:flutter/material.dart';
import 'package:okapy/core/ui/constants/colors.dart';

class IconedButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final IconData icon;
  final bool isOutlined;
  const IconedButton(
      {Key? key,
      required this.label,
      required this.onPressed,
      required this.icon,
      this.isOutlined = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double buttonPadding = 10.0;
    return isOutlined
        ? OutlinedButton.icon(
            onPressed: onPressed,
            icon: Icon(icon),
            label: Text(label),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: const BorderSide(color: AppColors.primaryColor),
              ),
            ))
        : ElevatedButton.icon(
            onPressed: onPressed,
            icon: Icon(
              icon,
              color: AppColors.primaryColor,
            ),
            label: Text(label),
          );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final bool isOutlined;
  final void Function() onPressed;
  const PrimaryButton(
      {required this.text, required this.onPressed, this.isOutlined = false});

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
                backgroundColor:
                    MaterialStateProperty.all(AppColors.themeColorAmber)),
            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(buttonPadding),
              child: Text(
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

class SmallIconButton extends StatelessWidget {
  final IconData icon;
  final void Function() onTap;
  SmallIconButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap, child: Icon(icon));
  }
}
