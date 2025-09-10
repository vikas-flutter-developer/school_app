import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_styles.dart';
import '../../core/utils/screen_util_helper.dart'; // ✅ Added helper

class AttendancePieChart extends StatelessWidget {
  final double presentPercentage;

  const AttendancePieChart({super.key, required this.presentPercentage});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context); // ✅ Initialize helper

    double chartRadius = ScreenUtilHelper.scaleWidth(117);       // ~screenWidth / 3.2
    double legendTextSize = ScreenUtilHelper.fontSize(18);       // ~screenWidth / 20
    double centerTextSize = ScreenUtilHelper.fontSize(25);       // ~screenWidth / 15

    Map<String, double> dataMap = {
      "Present": presentPercentage,
      "Absent": 100 - presentPercentage,
    };

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(18)), // 5% of 375
      child: Column(
        children: [
          PieChart(
            dataMap: dataMap,
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 32,
            chartRadius: chartRadius,
            initialAngleInDegree: 0,
            chartType: ChartType.ring,
            ringStrokeWidth: 32,
            centerText: "${presentPercentage.toStringAsFixed(0)}%",
            legendOptions: LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.bottom,
              showLegends: true,
              legendShape: BoxShape.circle,
              legendTextStyle: AppStyles.bold.copyWith(fontSize: legendTextSize),
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValues: false,
            ),
            colorList: [
              AppColors.primaryMedium,
              AppColors.primaryLightest
            ],
            centerTextStyle: AppStyles.headingLarge.copyWith(
              color: AppColors.black,
              fontSize: centerTextSize,
            ),
          ),
          SizedBox(height: ScreenUtilHelper.height(8)),
        ],
      ),
    );
  }
}
