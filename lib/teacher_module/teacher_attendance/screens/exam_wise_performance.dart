import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart' show AppStyles;
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExamWisePerformance extends StatefulWidget {
  const ExamWisePerformance({super.key});

  @override
  State<ExamWisePerformance> createState() => _ExamWisePerformanceState();
}

class _ExamWisePerformanceState extends State<ExamWisePerformance> {
  final Color below50Color = AppColors.below50;
  String selectedTerm = '1st Term';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        elevation: 1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/edudibon.png',
              height: ScreenUtilHelper.scaleHeight(30),
              fit: BoxFit.contain,
            ),
            Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.notifications_none,
                    color: AppColors.ash,
                    size: ScreenUtilHelper.scaleWidth(30),
                  ),
                  onPressed: () {},
                ),
                Positioned(
                  right: ScreenUtilHelper.scaleWidth(6),
                  top: ScreenUtilHelper.scaleHeight(6),
                  child: Container(
                    width: ScreenUtilHelper.scaleWidth(15),
                    height: ScreenUtilHelper.scaleHeight(15),
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "3",
                        style: TextStyle(
                          fontSize: ScreenUtilHelper.scaleText(10),
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.blackMediumEmphasis,
                  size: ScreenUtilHelper.scaleWidth(20),
                ),
                onPressed: ()=>GoRouter.of(context).pop(),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                splashRadius: ScreenUtilHelper.scaleWidth(20),
              ),
              SizedBox(width: ScreenUtilHelper.scaleWidth(8)),
              Text(
                'Exam wise Performance',
                style: AppStyles.bodyEmphasis.copyWith(color: AppColors.black),
              ),
            ],
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(30)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: ScreenUtilHelper.scaleWidth(20)),
                child: Text(
                  "Select Exam",
                  style: AppStyles.bodyEmphasis.copyWith(
                      color: AppColors.black),
                ),
              ),
              SizedBox(width: ScreenUtilHelper.scaleWidth(50)),
              Container(
                width: ScreenUtilHelper.scaleWidth(167),
                height: ScreenUtilHelper.scaleHeight(44),
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilHelper.scaleWidth(10)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color.fromRGBO(6, 2, 124, 1),
                    width: 1,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedTerm,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.black,
                      size: ScreenUtilHelper.scaleWidth(20),
                    ),
                    dropdownColor: AppColors.white,
                    style: AppStyles.bodySmallEmphasis.copyWith(
                        color: AppColors.black),
                    items: ['1st Term', '2nd Term', '3rd Term'].map((
                        String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: AppStyles.bodySmallEmphasis.copyWith(
                              color: AppColors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedTerm = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)),
              child: Container(
                width: ScreenUtilHelper.scaleWidth(396),
                height: ScreenUtilHelper.scaleHeight(525),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.cloud),
                ),
                padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(8)),
                      child: Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Class ',
                              style: AppStyles.bodySmall,
                              children: [
                                TextSpan(
                                  text: 'X A',
                                  style: AppStyles.bodySmallEmphasis.copyWith(
                                    color: const Color.fromRGBO(6, 2, 124, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: ScreenUtilHelper.scaleWidth(30)),
                          RichText(
                            text: TextSpan(
                              text: 'Year ',
                              style: AppStyles.bodySmall,
                              children: [
                                TextSpan(
                                  text: '2025',
                                  style: AppStyles.bodySmallBold.copyWith(
                                    color: const Color.fromRGBO(6, 2, 124, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(8)),
                      child: Text(
                        "1st Term",
                        style: AppStyles.bodySmallEmphasis.copyWith(
                          color: const Color.fromRGBO(6, 2, 124, 1),
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.scaleHeight(35)),
                    Center(
                      child: Text(
                        'Exam Wise Performance Graph',
                        style: AppStyles.bodySmallBold,
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.scaleHeight(25)),
                    Expanded(child: _buildBarChart()),
                    SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
                    _buildLegend(),
                    SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
          Padding(
            padding: EdgeInsets.only(right: ScreenUtilHelper.scaleWidth(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("download", style: AppStyles.bodySmallBold),
                SizedBox(width: ScreenUtilHelper.scaleWidth(15)),
                Icon(Icons.download, size: ScreenUtilHelper.scaleWidth(18),
                    color: AppColors.primaryBright),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 105,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: ScreenUtilHelper.scaleHeight(30), // Responsive
              getTitlesWidget: (value, meta) {
                final labels = ['Eng', 'Math', 'Sci', 'C cs', 'His', 'Geog'];
                final index = value.toInt();
                if (index >= 0 && index < labels.length) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtilHelper.scaleHeight(8)), // Responsive
                    child: Text(
                      labels[index],
                      style: AppStyles.bodySmall.copyWith(
                        color: AppColors.blackMediumEmphasis,
                        fontSize: ScreenUtilHelper.scaleText(12), // Responsive
                      ),
                    ),
                  );
                }
                return const Text('');
              },
            ),
            axisNameWidget: Padding(
              padding: EdgeInsets.only(top: ScreenUtilHelper.scaleHeight(10)),
              // Responsive
              child: Text("Subject", style: AppStyles.bodySmall.copyWith(
                  fontSize: ScreenUtilHelper.scaleText(13))), // Responsive
            ),
            axisNameSize: ScreenUtilHelper.scaleHeight(25), // Responsive
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 20,
              reservedSize: ScreenUtilHelper.scaleWidth(35), // Responsive
              getTitlesWidget: (value, meta) {
                if (value > 100 || value < 0) return const SizedBox.shrink();
                return Padding(
                  padding: EdgeInsets.only(
                      right: ScreenUtilHelper.scaleWidth(4)), // Responsive
                  child: Text(
                    value.toInt().toString(),
                    style: AppStyles.bodySmall.copyWith(
                      color: AppColors.blackMediumEmphasis,
                      fontSize: ScreenUtilHelper.scaleText(12), // Responsive
                    ),
                  ),
                );
              },
            ),
            axisNameWidget: Text("Total Student",
                style: AppStyles.bodySmallBold.copyWith(
                    fontSize: ScreenUtilHelper.scaleText(13))), // Responsive
            axisNameSize: ScreenUtilHelper.scaleHeight(20), // Responsive
          ),
          rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) =>
          const FlLine(color: AppColors.ash, strokeWidth: 0.8),
          checkToShowHorizontalLine: (value) => value % 20 == 0,
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(bottom: BorderSide(color: AppColors.silver, width: 1)),
        ),
        barGroups: _buildBarGroups(),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    List<List<double>> data = [
      [8, 16, 8, 68],
      [5, 18, 4, 73],
      [7, 6, 2, 85],
      [6, 4, 6, 84],
      [5, 18, 4, 73],
      [7, 6, 2, 85],
    ];

    return List.generate(data.length, (index) {
      final bars = data[index];
      final cumulative = List<double>.filled(bars.length, 0);
      for (int i = 0; i < bars.length; i++) {
        cumulative[i] = bars[i] + (i == 0 ? 0 : cumulative[i - 1]);
      }

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: cumulative.last,
            width: ScreenUtilHelper.scaleWidth(22), // Responsive
            borderRadius: BorderRadius.zero,
            rodStackItems: [
              BarChartRodStackItem(0, cumulative[0], AppColors.error),
              BarChartRodStackItem(
                  cumulative[0], cumulative[1], AppColors.below50),
              BarChartRodStackItem(
                  cumulative[1], cumulative[2], AppColors.pending),
              BarChartRodStackItem(
                  cumulative[2], cumulative[3], AppColors.successAccent),
            ],
          ),
        ],
      );
    });
  }

  Widget _buildLegend() {
    final items = [
      {'color': AppColors.successAccent, 'label': '+75%'},
      {'color': AppColors.pending, 'label': 'below 60%'},
      {'color': AppColors.below50, 'label': 'below 50%'},
      {'color': AppColors.error, 'label': 'Fail'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: items.map((item) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenUtilHelper.scaleWidth(8)), // Responsive
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: ScreenUtilHelper.scaleWidth(12), // Responsive
                height: ScreenUtilHelper.scaleWidth(12), // Responsive
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      ScreenUtilHelper.scaleWidth(10)), // Responsive
                  color: item['color'] as Color,
                ),
              ),
              SizedBox(width: ScreenUtilHelper.scaleWidth(6)), // Responsive
              Text(
                item['label'] as String,
                style: AppStyles.bodySmall.copyWith(
                    fontSize: ScreenUtilHelper.scaleText(12)), // Responsive
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}