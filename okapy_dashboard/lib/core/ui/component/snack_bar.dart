import 'package:flutter/material.dart';

void buildSnackbar(BuildContext context, String message, {TextAlign alignment = TextAlign.center}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      textAlign: alignment,
    ),
  ));
}

