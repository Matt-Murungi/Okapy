import 'package:flutter/material.dart';
import 'package:okapy_dashboard/core/ui/component/buttons.dart';

DataColumn buildTableHeader(String heading) => DataColumn(
        label: Text(
      heading,
      style: const TextStyle(fontWeight: FontWeight.w600),
    ));

DataCell buildTableCell(String text) => DataCell(
      Text(text),
    );

DataCell buildActionWidgets(Function onPressed) => DataCell(
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ButtonWithIcon(
            icon: Icons.remove_red_eye_outlined,
            tooltip: "View",
            onPressed: () {},
          ),
          ButtonWithIcon(
            icon: Icons.delete_outline_outlined,
            tooltip: "Delete",
            onPressed: () {},
          )
          // Button(icon: Icon(Icons.remove_red_eye_outlined), onPressed: (){},)
        ],
      ),
    );
