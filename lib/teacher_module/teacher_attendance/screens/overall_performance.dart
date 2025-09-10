import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart' show AppStyles;
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart'; //  Added for responsiveness
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OverallPerformancePage extends StatefulWidget {
  const OverallPerformancePage({super.key});

  @override
  State<OverallPerformancePage> createState() => _OverallPerformancePageState();
}

class _OverallPerformancePageState extends State<OverallPerformancePage> {
  final Color below50Color = AppColors.below50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/edudibon.png',
              height: ScreenUtilHelper.scaleHeight(30), //  Responsive height
              fit: BoxFit.contain,
            ),
            Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.notifications_none,
                    color: AppColors.ash,
                    size: ScreenUtilHelper.scaleText(30), //  Responsive size
                  ),
                  onPressed: () {},
                ),
                Positioned(
                  right: ScreenUtilHelper.scaleWidth(6), //  Responsive offset
                  top: ScreenUtilHelper.scaleHeight(6), //  Responsive offset
                  child: Container(
                    width: ScreenUtilHelper.scaleWidth(15), //  Responsive size
                    height: ScreenUtilHelper.scaleHeight(15), //  Responsive size
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "3",
                        style: TextStyle(
                          fontSize: ScreenUtilHelper.scaleText(AppStyles.size.tiny), //  Responsive font
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
                  size: ScreenUtilHelper.scaleText(20), //  Responsive size
                ),
                onPressed: ()=>GoRouter.of(context).pop(),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                splashRadius: 20,
              ),
              SizedBox(width: ScreenUtilHelper.scaleWidth(8)), //  Responsive spacing
              Text(
                'Overall Performance',
                style: TextStyle(
                  fontSize: ScreenUtilHelper.scaleText(AppStyles.size.body), //  Responsive font
                  fontWeight: AppStyles.weight.emphasis,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(30)), //  Responsive spacing
          Center(
            child: Padding(
              padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(16)), //  Responsive padding
              child: Container(
                width: ScreenUtilHelper.scaleWidth(396), //  Responsive width
                height: ScreenUtilHelper.scaleHeight(525), //  Responsive height
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(5)), //  Responsive radius
                  border: Border.all(color: AppColors.cloud),
                ),
                padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(16)), //  Responsive padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Class ',
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: ScreenUtilHelper.scaleText(AppStyles.size.bodySmall), //  Responsive font
                              fontFamily: 'Arial',
                            ),
                            children: [
                              TextSpan(
                                text: 'X A',
                                style: TextStyle(
                                  color: AppColors.primaryContrast,
                                  fontSize: ScreenUtilHelper.scaleText(AppStyles.size.bodySmall), //  Responsive font
                                  fontWeight: AppStyles.weight.emphasis,
                                  fontFamily: 'Arial',
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: ScreenUtilHelper.scaleWidth(30)), //  Responsive spacing
                        RichText(
                          text: TextSpan(
                            text: 'Year ',
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: ScreenUtilHelper.scaleText(AppStyles.size.bodySmall), //  Responsive font
                              fontFamily: 'Arial',
                            ),
                            children: [
                              TextSpan(
                                text: '2025',
                                style: TextStyle(
                                  color: AppColors.primaryContrast,
                                  fontSize: ScreenUtilHelper.scaleText(AppStyles.size.bodySmall), //  Responsive font
                                  fontWeight: AppStyles.weight.heading,
                                  fontFamily: 'Arial',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtilHelper.scaleHeight(35)), //  Responsive spacing
                    Center(
                      child: Text(
                        'Overall Performance Graph',
                        style: TextStyle(
                          fontWeight: AppStyles.weight.emphasis,
                          color: AppColors.black,
                          fontSize: ScreenUtilHelper.scaleText(AppStyles.size.bodySmall), //  Responsive font
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.scaleHeight(25)), //  Responsive spacing
                    Expanded(
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 105,
                          barTouchData: BarTouchData(enabled: false),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: ScreenUtilHelper.scaleHeight(30), //  Responsive height
                                getTitlesWidget: (value, meta) {
                                  final labels = ['1st', '2nd', '3rd', '4th'];
                                  final index = value.toInt();
                                  if (index >= 0 && index < labels.length) {
                                    return Padding(
                                      padding: EdgeInsets.only(top: ScreenUtilHelper.scaleHeight(8.0)), //  Responsive padding
                                      child: Text(
                                        labels[index],
                                        style: TextStyle(
                                          fontSize: ScreenUtilHelper.scaleText(AppStyles.size.small), //  Responsive font
                                          color: AppColors.blackMediumEmphasis,
                                          fontFamily: 'Arial',
                                        ),
                                      ),
                                    );
                                  }
                                  return const Text('');
                                },
                              ),
                              axisNameWidget: Padding(
                                padding: EdgeInsets.only(top: ScreenUtilHelper.scaleHeight(10.0)), //  Responsive padding
                                child: Text(
                                  "All Terms",
                                  style: TextStyle(
                                    fontSize: ScreenUtilHelper.scaleText(AppStyles.size.small), //  Responsive font
                                    fontWeight: AppStyles.weight.emphasis,
                                    fontFamily: 'Arial',
                                  ),
                                ),
                              ),
                              axisNameSize: ScreenUtilHelper.scaleHeight(25), //  Responsive size
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 20,
                                reservedSize: ScreenUtilHelper.scaleWidth(35), //  Responsive width
                                getTitlesWidget: (value, meta) {
                                  if (value > 100 || value < 0) {
                                    return const SizedBox.shrink();
                                  }
                                  return Padding(
                                    padding: EdgeInsets.only(right: ScreenUtilHelper.scaleWidth(4.0)), //  Responsive padding
                                    child: Text(
                                      value.toInt().toString(),
                                      style: TextStyle(
                                        fontSize: ScreenUtilHelper.scaleText(AppStyles.size.small), //  Responsive font
                                        color: AppColors.blackMediumEmphasis,
                                        fontFamily: 'Arial',
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  );
                                },
                              ),
                              axisNameWidget: Text(
                                "Total Student",
                                style: TextStyle(
                                  fontSize: ScreenUtilHelper.scaleText(AppStyles.size.small), //  Responsive font
                                  fontWeight: AppStyles.weight.emphasis,
                                  fontFamily: 'Arial',
                                ),
                              ),
                              axisNameSize: ScreenUtilHelper.scaleHeight(20), //  Responsive size
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            getDrawingHorizontalLine: (value) {
                              return const FlLine(
                                color: AppColors.ash,
                                strokeWidth: 0.8,
                              );
                            },
                            checkToShowHorizontalLine: (value) => value % 20 == 0,
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.silver,
                                width: 1,
                              ),
                            ),
                          ),
                          barGroups: _buildBarGroups(),
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.scaleHeight(20)), //  Responsive spacing
                    _buildLegend(),
                    SizedBox(height: ScreenUtilHelper.scaleHeight(10)), // 📱 Responsive spacing
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(20)), //  Responsive spacing
          Padding(
            padding: EdgeInsets.only(right: ScreenUtilHelper.scaleWidth(16.0)), //  Responsive padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "download",
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.scaleText(AppStyles.size.bodySmall), //  Responsive font
                    fontWeight: AppStyles.weight.emphasis,
                  ),
                ),
                SizedBox(width: ScreenUtilHelper.scaleWidth(15)), //  Responsive spacing
                Icon(
                  Icons.download,
                  size: ScreenUtilHelper.scaleText(18), //  Responsive size
                  color: AppColors.primaryBright,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    List<List<double>> data = [
      [8, 16, 8, 68],
      [5, 18, 4, 73],
      [7, 6, 2, 85],
      [6, 4, 6, 84],
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
            width: 22,
            borderRadius: BorderRadius.zero,
            rodStackItems: [
              BarChartRodStackItem(0, cumulative[0], AppColors.error),
              BarChartRodStackItem(cumulative[0], cumulative[1], below50Color),
              BarChartRodStackItem(cumulative[1], cumulative[2], AppColors.pending),
              BarChartRodStackItem(cumulative[2], cumulative[3], AppColors.successAccent),
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
      {'color': below50Color, 'label': 'below 50%'},
      {'color': AppColors.error, 'label': 'Fail'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: items.map((item) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(8)), //  Responsive padding
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: ScreenUtilHelper.scaleWidth(12), //  Responsive size
                height: ScreenUtilHelper.scaleHeight(12), //  Responsive size
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(10)), //  Responsive radius
                  color: item['color'] as Color,
                ),
              ),
              SizedBox(width: ScreenUtilHelper.scaleWidth(6)), //  Responsive spacing
              Text(
                item['label'] as String,
                style: TextStyle(fontSize: ScreenUtilHelper.scaleText(AppStyles.size.small)), //  Responsive font
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
