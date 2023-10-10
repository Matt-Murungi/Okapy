import 'package:flutter/material.dart';

class AppUtils {
  static getAppHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static getAppWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
