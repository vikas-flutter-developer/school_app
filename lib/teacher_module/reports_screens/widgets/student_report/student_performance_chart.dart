import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_util_helper.dart';

class StudentPerformanceChart extends StatelessWidget {
  final dynamic performanceData; // {'subjects': [], 'theory': [], 'practical': []}

  const StudentPerformanceChart({super.key, this.performanceData});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    if (performanceData == null ||
        performanceData['subjects'] == null ||
        performanceData['theory'] == null ||
        performanceData['practical'] == null ||
        performanceData['subjects'].isEmpty) {
      return SizedBox(
        height: ScreenUtilHelper.height(200),
        child: const Center(
          child: Text("Performance data not available for this term."),
        ),
      );
    }

    final List<String> subjects = List<String>.from(performanceData['subjects']);
    final List<double> theoryScores = List<double>.from(performanceData['theory']);
    final List<double> practicalScores = List<double>.from(performanceData['practical']);

    final double maxTheory = theoryScores.isNotEmpty ? theoryScores.reduce(max) : 100;
    final double maxPractical = practicalScores.isNotEmpty ? practicalScores.reduce(max) : 100;
    final double maxY = (max(maxTheory, maxPractical) / 10).ceil() * 10.0 + 10;

    final List<FlSpot> theorySpots = [];
    final List<FlSpot> practicalSpots = [];

    for (int i = 0; i < subjects.length; i++) {
      theorySpots.add(FlSpot(i.toDouble(), theoryScores[i]));
      practicalSpots.add(FlSpot(i.toDouble(), practicalScores[i]));
    }

    return Column(
      children: [
        SizedBox(
          height: ScreenUtilHelper.height(250),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                getDrawingHorizontalLine: (value) =>
                    FlLine(color: AppColors.cloud, strokeWidth: 0.5),
                getDrawingVerticalLine: (value) =>
                    FlLine(color: AppColors.cloud, strokeWidth: 0.5),
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: ScreenUtilHelper.height(30),
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index >= 0 && index < subjects.length) {
                        String shortName = subjects[index];
                        if (shortName == "Social Studies") shortName = "Social";
                        return SideTitleWidget(
                          space: ScreenUtilHelper.height(8.0),
                          meta: meta,
                          child: Text(
                            shortName,
                            style: AppStyles.font10,
                          ),
                        );
                      }
                      return const Text('');
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: maxY / 5,
                    reservedSize: ScreenUtilHelper.width(32),
                    getTitlesWidget: (value, meta) => Text(
                      value.toInt().toString(),
                      style: AppStyles.font10,
                    ),
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: AppColors.silver),
              ),
              minX: 0,
              maxX: (subjects.length - 1).toDouble(),
              minY: 0,
              maxY: maxY,
              lineBarsData: [
                _buildLineChartBarData(theorySpots, AppColors.pending),
                _buildLineChartBarData(practicalSpots, AppColors.info),
              ],
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                    return touchedBarSpots.map((barSpot) {
                      final flSpot = barSpot;
                      String seriesName = flSpot.barIndex == 0 ? 'Theory' : 'Practical';
                      return LineTooltipItem(
                        '$seriesName: ${flSpot.y.toStringAsFixed(1)}',
                        AppStyles.lineTooltip1(
                          flSpot.bar.gradient?.colors.first ??
                              flSpot.bar.color ??
                              AppColors.white,
                        ),
                      );
                    }).toList();
                  },
                ),
                handleBuiltInTouches: true,
              ),
            ),
          ),
        ),
        SizedBox(height: ScreenUtilHelper.height(10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendItem(AppColors.pending, 'Theory'),
            SizedBox(width: ScreenUtilHelper.width(16)),
            _buildLegendItem(AppColors.info, 'Practical'),
          ],
        ),
      ],
    );
  }

  LineChartBarData _buildLineChartBarData(List<FlSpot> spots, Color color) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      gradient: LinearGradient(colors: AppColors.lineGradient(color)),
      barWidth: ScreenUtilHelper.width(3),
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
          radius: ScreenUtilHelper.width(4),
          color: color,
          strokeWidth: 1,
          strokeColor: AppColors.white,
        ),
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors: AppColors.areaGradient(color),
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: ScreenUtilHelper.width(12),
          height: ScreenUtilHelper.width(12),
          color: color,
        ),
        SizedBox(width: ScreenUtilHelper.width(4)),
        Text(text, style: AppStyles.font12),
      ],
    );
  }
}
