import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';
import 'package:go_router/go_router.dart';

class AssignmentGradeChart extends StatelessWidget implements PreferredSizeWidget {
  const AssignmentGradeChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: ScreenUtilHelper.scaleWidth(153.07),
                height: ScreenUtilHelper.scaleHeight(39),
                margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.scaleWidth(8.0),
                ),
                child: Image.asset(
                  'assets/images/edudibon.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none),
                onPressed: () {},
              ),
              Positioned(
                right: ScreenUtilHelper.scaleWidth(15),
                top: 0,
                child: Container(
                  padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(4.0)),
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(
                    minWidth: ScreenUtilHelper.scaleWidth(16),
                    minHeight: ScreenUtilHelper.scaleWidth(16),
                  ),
                  child: Center(
                    child: Text('3', style: AppStyles.smallText1),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtilHelper.scaleWidth(16.0),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                ),
                Text("Assignment Report", style: AppStyles.headingLNoColor),
                const Spacer(),
              ],
            ),
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(8)),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilHelper.scaleWidth(16.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: ScreenUtilHelper.scaleWidth(77),
                          height: ScreenUtilHelper.scaleHeight(30),
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtilHelper.scaleRadius(6.0)),
                              ),
                              side: const BorderSide(
                                width: 1.0,
                                color: AppColors.primaryMedium,
                              ),
                            ),
                            child: Text("Export", style: AppStyles.bodyMedium),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
                  _buildChartSection(
                    title: "Assignment Completion",
                    data: [
                      [5.0, 10.0, 10.0],
                      [6.0, 20.0, 13.0],
                      [7.0, 18.0, 8.0],
                      [5.0, 18.0, 9.0],
                      [8.0, 16.0, 6.0],
                    ],
                    legends: const [
                      _LegendItem(color: AppColors.info, label: 'On time'),
                      _LegendItem(color: AppColors.tertiaryMedium, label: 'In-complete'),
                      _LegendItem(color: AppColors.errorAccent, label: 'Late'),
                    ],
                  ),
                  _buildChartSection(
                    title: "Assignment Grade",
                    data: [
                      [5.0, 10.0, 10.0],
                      [6.0, 20.0, 13.0],
                      [7.0, 18.0, 8.0],
                      [5.0, 18.0, 9.0],
                      [8.0, 16.0, 6.0],
                    ],
                    legends: const [
                      _LegendItem(color: AppColors.info, label: 'Below 60%'),
                      _LegendItem(color: AppColors.tertiaryMedium, label: 'Above 60%'),
                      _LegendItem(color: AppColors.errorAccent, label: 'Fail'),
                    ],
                  ),
                  SizedBox(height: ScreenUtilHelper.scaleHeight(50)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildChartSection({
    required String title,
    required List<List<double>> data,
    required List<_LegendItem> legends,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(20)),
          child: Text(title, style: AppStyles.headingS),
        ),
        SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
        Center(
          child: SizedBox(
            width: ScreenUtilHelper.scaleWidth(315),
            height: ScreenUtilHelper.scaleHeight(389),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 40,
                barGroups: _buildBarGroups(data),
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: ScreenUtilHelper.scaleWidth(30),
                      interval: 10,
                      getTitlesWidget: (value, meta) => Text(
                        value.toInt().toString(),
                        style: AppStyles.font10,
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const labels = ['Ass1', 'Ass2', 'Ass3', 'Ass4', 'Ass5'];
                        return Padding(
                          padding: EdgeInsets.only(
                            top: ScreenUtilHelper.scaleHeight(4),
                          ),
                          child: Text(labels[value.toInt()], style: AppStyles.font12),
                        );
                      },
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
        ),
        SizedBox(height: ScreenUtilHelper.scaleHeight(12)),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.scaleWidth(30),
          ),
          child: const Divider(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: legends,
        ),
        SizedBox(height: ScreenUtilHelper.scaleHeight(30)),
      ],
    );
  }

  static List<BarChartGroupData> _buildBarGroups(List<List<double>> data) {
    return List.generate(data.length, (i) {
      double first = data[i][0];
      double second = data[i][1];
      double third = data[i][2];

      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: first + second + third,
            width: ScreenUtilHelper.scaleWidth(12),
            rodStackItems: [
              BarChartRodStackItem(0, first, AppColors.info),
              BarChartRodStackItem(first, first + second, AppColors.tertiaryMedium),
              BarChartRodStackItem(first + second, first + second + third, AppColors.errorAccent),
            ],
            borderRadius: BorderRadius.zero,
          ),
        ],
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: ScreenUtilHelper.scaleWidth(10),
          height: ScreenUtilHelper.scaleWidth(10),
          color: color,
        ),
        SizedBox(width: ScreenUtilHelper.scaleWidth(4)),
        Text(label, style: AppStyles.font12),
      ],
    );
  }
}
