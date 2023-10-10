import 'package:flutter/material.dart';
import 'package:okapy_dashboard/core/ui/constants.dart';

class CustomTextInputField extends StatelessWidget {
  final String title;
  final String? hint;
  final IconData? icon;
  final TextEditingController textEditingController;
  final bool isPassword;
  final bool? isMultiline;
  final bool? isEnabled;
  final  Function(String)? onChanged;

  const CustomTextInputField(
      {super.key,
      required this.title,
      this.hint,
      this.icon,
      required this.textEditingController,
      this.isPassword = false,
      this.isEnabled = true,
      this.isMultiline = false,
      this.onChanged
      });

  const CustomTextInputField.withPassword(
      {super.key,
      required this.title,
      required this.hint,
      this.icon = Icons.lock_outline,
      required this.textEditingController,
      this.isMultiline = false,
      this.isEnabled = true,
      this.isPassword = true,
this.onChanged
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.themeColorGreen),
          ),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                color: AppColors.themeColorAmber,
                width: 1.0,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 5.0),
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    maxLines: isMultiline == true ? 5 : 1,
                    obscureText: isPassword,
                    enabled: isEnabled,
                    onChanged: onChanged,
                    decoration: InputDecoration(
                      hintText: hint,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
