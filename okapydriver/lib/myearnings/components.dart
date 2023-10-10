import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:okapydriver/utils/color.dart';

class BarGrapth extends StatelessWidget {
  const BarGrapth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: BarChart(
          swapAnimationDuration: const Duration(milliseconds: 150), // Optional
          swapAnimationCurve: Curves.linear,
          BarChartData(
              titlesData: FlTitlesData(
                // show: false,
                leftTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: true,
                )),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(
                  border: const Border(
                top: BorderSide.none,
                right: BorderSide.none,
                left: BorderSide.none,
                bottom: BorderSide.none,
              )),
              groupsSpace: 10,
              barGroups: [
                BarChartGroupData(x: 1, barRods: [
                  BarChartRodData(width: 15, toY: 2, color: themeColorAmber),
                ]),
                BarChartGroupData(x: 1, barRods: [
                  BarChartRodData(width: 15, toY: 2, color: themeColorAmber),
                ]),
                BarChartGroupData(x: 2, barRods: [
                  BarChartRodData(
                    toY: 9,
                    width: 15,
                    color: themeColorAmber,
                  ),
                ]),
              ])),
    );
  }
}
