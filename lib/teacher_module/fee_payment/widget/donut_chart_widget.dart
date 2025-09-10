import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart'; //  Imported for responsiveness

class DonutChartWidget extends StatelessWidget {
  final Map<String, double> data; // { 'Label': value }
  final List<Color> colors;
  final String centerText;
  final double totalValue;

  const DonutChartWidget({
    super.key,
    required this.data,
    required this.colors,
    required this.centerText,
    this.totalValue = 100.0, // Assume 100% if not provided
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    int i = 0;
    final chartSections = data.entries.map((entry) {
      final color = colors[i % colors.length];
      i++;
      return PieChartSectionData(
        color: color,
        value: entry.value,
        title: '${entry.value.toStringAsFixed(0)}%', // Show percentage
        radius: ScreenUtilHelper.scaleWidth(25), //  Adjust radius responsively
        titleStyle: TextStyle(
          fontSize: ScreenUtilHelper.scaleText(AppStyles.size.tiny), //  Responsive font
          fontWeight: AppStyles.weight.emphasis,
          color: AppColors.white,
        ),
        showTitle: false, // Hide titles on sections to avoid clutter
      );
    }).toList();

    return SizedBox(
      height: ScreenUtilHelper.scaleHeight(150), //  Responsive height
      width: ScreenUtilHelper.scaleWidth(150),   //  Responsive width
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sections: chartSections,
              centerSpaceRadius: ScreenUtilHelper.scaleWidth(40), //  Responsive center radius
              sectionsSpace: ScreenUtilHelper.scaleWidth(2), //  Responsive spacing
              startDegreeOffset: -90, // Start from top
              borderData: FlBorderData(show: false),
            ),
          ),
          Text(
            centerText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ScreenUtilHelper.scaleText(AppStyles.size.bodySmall), //  Responsive text
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// Helper Widget for Legends
class ChartLegend extends StatelessWidget {
  final Color color;
  final String text;

  const ChartLegend({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtilHelper.scaleHeight(2.0), //  Responsive vertical padding
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: ScreenUtilHelper.scaleWidth(12), //  Responsive circle size
            height: ScreenUtilHelper.scaleWidth(12),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: ScreenUtilHelper.scaleWidth(6)), //  Responsive spacing
          Text(
            text,
            style: TextStyle(
              fontSize: ScreenUtilHelper.scaleText(AppStyles.size.small), //  Responsive font
            ),
          ),
        ],
      ),
    );
  }
}
