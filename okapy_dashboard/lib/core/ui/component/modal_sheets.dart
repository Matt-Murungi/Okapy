import 'package:flutter/material.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';

showSideSheet(BuildContext context, Widget widget) => showModalSideSheet(
    context: context,
    body: widget,
    width: MediaQuery.of(context).size.width / 2);
