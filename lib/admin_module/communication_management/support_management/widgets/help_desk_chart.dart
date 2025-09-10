import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_util_helper.dart';

class HelpDeskChart extends StatelessWidget {
  const HelpDeskChart({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Card(
      elevation: 2.0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0))),
      color: AppColors.white,
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ticket Status',
              style: TextStyle(
                fontSize: ScreenUtilHelper.fontSize(16),
                fontWeight: FontWeight.w600,
                color: AppColors.blackHighEmphasis,
              ),
            ),
            SizedBox(height: ScreenUtilHelper.height(25)),
            AspectRatio(
              aspectRatio: 1.8,
              child: LineChart(
                _buildChartData(AppColors.raisedColor, AppColors.resolvedColor,
                    AppColors.pendingColor),
              ),
            ),
            SizedBox(height: ScreenUtilHelper.height(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLegendItem(AppColors.raisedColor, 'Raised Tickets'),
                _buildLegendItem(AppColors.resolvedColor, 'Resolved Tickets'),
                _buildLegendItem(AppColors.pendingColor, 'Pending Tickets'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: ScreenUtilHelper.width(10),
          height: ScreenUtilHelper.height(10),
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        SizedBox(width: ScreenUtilHelper.width(6)),
        Text(
          text,
          style: TextStyle(
            fontSize: ScreenUtilHelper.fontSize(11),
            color: AppColors.ash,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  LineChartData _buildChartData(
      Color raisedColor,
      Color resolvedColor,
      Color pendingColor,
      ) {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: true,
        horizontalInterval: 80,
        getDrawingHorizontalLine: (value) {
          return FlLine(
              color: AppColors.ash,
              strokeWidth: ScreenUtilHelper.width(1),
              dashArray: [4, 4]);
        },
      ),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: ScreenUtilHelper.height(30),
            interval: 1,
            getTitlesWidget: (value, meta) {
              final style = TextStyle(
                color: AppColors.ash,
                fontWeight: FontWeight.w500,
                fontSize: ScreenUtilHelper.fontSize(11),
              );
              String text = '';
              switch (value.toInt()) {
                case 0:
                  text = 'Apr';
                  break;
                case 1:
                  text = 'Mar';
                  break;
                case 2:
                  text = 'Feb';
                  break;
                case 3:
                  text = 'Jan';
                  break;
              }
              return Text(text, style: style);
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 80,
            reservedSize: ScreenUtilHelper.width(35),
            getTitlesWidget: (value, meta) {
              if (value % 80 == 0) {
                return Text(
                  value.toInt().toString(),
                  style: TextStyle(
                    color: AppColors.ash,
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtilHelper.fontSize(11),
                  ),
                  textAlign: TextAlign.left,
                );
              }
              return Container();
            },
          ),
        ),
        topTitles:
        const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles:
        const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: 3,
      minY: 0,
      maxY: 240,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 180),
            FlSpot(1, 190),
            FlSpot(2, 170),
            FlSpot(3, 160),
          ],
          isCurved: true,
          color: pendingColor,
          barWidth: ScreenUtilHelper.width(3),
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: pendingColor.withOpacity(0.8),
          ),
        ),
        LineChartBarData(
          spots: const [
            FlSpot(0, 120),
            FlSpot(1, 140),
            FlSpot(2, 110),
            FlSpot(3, 100),
          ],
          isCurved: true,
          color: resolvedColor,
          barWidth: ScreenUtilHelper.width(3),
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: resolvedColor.withOpacity(0.8),
          ),
        ),
        LineChartBarData(
          spots: const [
            FlSpot(0, 80),
            FlSpot(1, 95),
            FlSpot(2, 70),
            FlSpot(3, 60),
          ],
          isCurved: true,
          color: raisedColor,
          barWidth: ScreenUtilHelper.width(3),
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: raisedColor.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}