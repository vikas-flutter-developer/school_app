import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart'; // Ensure this import is present

class AttendanceGraph extends StatelessWidget {
  final List<double> presentData;
  final List<double> halfDayData;
  final List<double> lateData;
  final List<double> absentData;
  final double totalStudents;
  final List<String> days;
  final String title;
  final String xAxisTitle;

  const AttendanceGraph({
    Key? key,
    required this.presentData,
    required this.halfDayData,
    required this.lateData,
    required this.absentData,
    required this.totalStudents,
    required this.days,
    required this.title,
    required this.xAxisTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<List<double>> cumulativeData = List.generate(days.length, (dayIndex) {
      double cumValue = 0;
      List<double> dayValues = [];
      cumValue += absentData[dayIndex];
      dayValues.add(cumValue);
      cumValue += lateData[dayIndex];
      dayValues.add(cumValue);
      cumValue += halfDayData[dayIndex];
      dayValues.add(cumValue);
      cumValue += presentData[dayIndex];
      dayValues.add(cumValue);
      return dayValues;
    });

    return Container(
      padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)), // ScreenUtilHelper
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(8)), // ScreenUtilHelper
        boxShadow: [
          BoxShadow(
            color: AppColors.blackDivider,
            spreadRadius: ScreenUtilHelper.scaleWidth(1), // ScreenUtilHelper
            blurRadius: ScreenUtilHelper.scaleWidth(3), // ScreenUtilHelper
            offset: Offset(0, ScreenUtilHelper.scaleHeight(1)), // ScreenUtilHelper
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: ScreenUtilHelper.scaleHeight(15)), // ScreenUtilHelper
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: ScreenUtilHelper.scaleText(AppStyles.size.body), // ScreenUtilHelper
                fontWeight: AppStyles.weight.regular,
              ),
            ),
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(25)), // ScreenUtilHelper
          AspectRatio(
            aspectRatio: 1.5,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: ScreenUtilHelper.scaleHeight(40), // ScreenUtilHelper
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: Center(
                      child: Text(
                        'Total Student',
                        style: TextStyle(
                          fontSize: ScreenUtilHelper.scaleText(AppStyles.size.small), // ScreenUtilHelper
                          fontWeight: AppStyles.weight.emphasis,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: ScreenUtilHelper.scaleWidth(25),
                    right: ScreenUtilHelper.scaleWidth(5),
                    bottom: ScreenUtilHelper.scaleHeight(20),
                    top: ScreenUtilHelper.scaleHeight(10),
                  ), // ScreenUtilHelper
                  child: BarChart(
                    BarChartData(
                      maxY: totalStudents,
                      minY: 0,
                      alignment: BarChartAlignment.spaceAround,
                      barTouchData: BarTouchData(enabled: false),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: ScreenUtilHelper.scaleHeight(30), // ScreenUtilHelper
                            getTitlesWidget: (value, meta) {
                              int index = value.toInt();
                              if (index >= 0 && index < days.length) {
                                return Padding(
                                  padding: EdgeInsets.only(top: ScreenUtilHelper.scaleHeight(8)), // ScreenUtilHelper
                                  child: Text(
                                    days[index],
                                    style: TextStyle(
                                      color: AppColors.slate,
                                      fontSize: ScreenUtilHelper.scaleText(AppStyles.size.small), // ScreenUtilHelper
                                    ),
                                  ),
                                );
                              }
                              return const Text('');
                            },
                          ),
                          axisNameWidget: Padding(
                            padding: EdgeInsets.only(top: ScreenUtilHelper.scaleHeight(10)), // ScreenUtilHelper
                            child: Text(
                              xAxisTitle,
                              style: TextStyle(
                                fontSize: ScreenUtilHelper.scaleText(AppStyles.size.small), // ScreenUtilHelper
                                fontWeight: AppStyles.weight.emphasis,
                              ),
                            ),
                          ),
                          axisNameSize: ScreenUtilHelper.scaleHeight(25), // ScreenUtilHelper
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: ScreenUtilHelper.scaleWidth(30), // ScreenUtilHelper
                            interval: 10,
                            getTitlesWidget: (value, meta) {
                              if (value % 10 == 0 && value <= totalStudents) {
                                return Text(
                                  '${value.toInt()}',
                                  style: TextStyle(
                                    color: AppColors.slate,
                                    fontSize: ScreenUtilHelper.scaleText(AppStyles.size.small), // ScreenUtilHelper
                                  ),
                                  textAlign: TextAlign.right,
                                );
                              }
                              return const Text('');
                            },
                          ),
                        ),
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: AppColors.cloud,
                            strokeWidth: 0.5,
                          );
                        },
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: List.generate(days.length, (index) {
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: cumulativeData[index][3],
                              rodStackItems: [
                                BarChartRodStackItem(
                                  0,
                                  cumulativeData[index][0],
                                  AppColors.errorAccent,
                                ),
                                BarChartRodStackItem(
                                  cumulativeData[index][0],
                                  cumulativeData[index][1],
                                  AppColors.attendancePieAbsent,
                                ),
                                BarChartRodStackItem(
                                  cumulativeData[index][1],
                                  cumulativeData[index][2],
                                  AppColors.warningLight,
                                ),
                                BarChartRodStackItem(
                                  cumulativeData[index][2],
                                  cumulativeData[index][3],
                                  AppColors.successAccent,
                                ),
                              ],
                              width: ScreenUtilHelper.scaleWidth(25), // ScreenUtilHelper
                              borderRadius: BorderRadius.zero,
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(25)), // ScreenUtilHelper
          _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Center(
      child: Wrap(
        spacing: ScreenUtilHelper.scaleWidth(15), // ScreenUtilHelper
        runSpacing: ScreenUtilHelper.scaleHeight(8), // ScreenUtilHelper
        alignment: WrapAlignment.center,
        children: [
          _legendItem(AppColors.successAccent, 'Present'),
          _legendItem(AppColors.warningLight, 'Half Day'),
          _legendItem(AppColors.attendancePieAbsent, 'Late'),
          _legendItem(AppColors.errorAccent, 'Absent'),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, color: color, size: ScreenUtilHelper.scaleWidth(14)), // ScreenUtilHelper
        SizedBox(width: ScreenUtilHelper.scaleWidth(6)), // ScreenUtilHelper
        Text(
          label,
          style: TextStyle(
            fontSize: ScreenUtilHelper.scaleText(AppStyles.size.small), // ScreenUtilHelper
            color: AppColors.slate,
          ),
        ),
      ],
    );
  }
}
