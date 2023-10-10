import 'package:flutter/material.dart';

class CustomColumn extends StatelessWidget {
  final double? bottom;
  final double? top;
  final double? left;
  final double? right;
  final bool isColumn;
  final Widget? child;
  final List<Widget>? children;

  const CustomColumn(
      {super.key,
      this.bottom,
      this.top,
      this.left,
      this.right,
      this.children,
      required this.isColumn,
      this.child});

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.only(
      top: top?.toDouble() ?? 0,
      bottom: bottom?.toDouble() ?? 0,
      left: left?.toDouble() ?? 0,
      right: right?.toDouble() ?? 0,
    );

    if (isColumn) {
      return Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children ?? [const SizedBox()],
        ),
      );
    }

    return Padding(
      padding: padding,
      child: child,
    );
  }
}
