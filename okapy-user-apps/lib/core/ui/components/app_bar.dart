import 'package:flutter/material.dart';

AppBar buildAppBar(String title, {List<Widget>? actions}) {
  return AppBar(
    title: Text(title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
    backgroundColor: Colors.white,
    actions: actions,
    elevation: 0,
  );
}
