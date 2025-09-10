import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart' show AppStyles;
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart'; // Added for screen adaptation
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SubjectWisePerformance extends StatefulWidget {
  const SubjectWisePerformance({super.key});

  @override
  State<SubjectWisePerformance> createState() => _SubjectWisePerformanceState();
}

class _SubjectWisePerformanceState extends State<SubjectWisePerformance> {
  // Define the color for "below 50%" to match the image's pale mint green
  final Color below50Color = AppColors.below50;

  String selectedTerm = 'Math';

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context); // Initialize screen util helper

    // Using a fixed background color for the Scaffold as in the original code
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/edudibon.png',
              height: ScreenUtilHelper.height(30), // Scaled
              fit: BoxFit.contain,
            ),

            Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_none,
                    color: AppColors.ash,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
                Positioned(
                  right: ScreenUtilHelper.width(6), // Scaled
                  top: ScreenUtilHelper.height(6), // Scaled
                  child: Container(
                    width: ScreenUtilHelper.width(15),
                    height: ScreenUtilHelper.height(15),
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "3",
                        style: TextStyle(
                          fontSize: AppStyles.size.tiny,
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
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.blackMediumEmphasis,
                  size: 20,
                ),
                // iOS style back arrow
                onPressed: ()=>GoRouter.of(context).pop(),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                splashRadius: 20, // Smaller splash
              ),
              SizedBox(width: ScreenUtilHelper.width(8)), // Scaled spacing
              Text(
                'Subject wise Performance',
                style: TextStyle(
                  fontSize: AppStyles.size.body,
                  fontWeight: AppStyles.weight.emphasis,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenUtilHelper.height(30)),
          // Scaled
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: ScreenUtilHelper.width(20.0)),
                child: Text(
                  "Select Subject",
                  style: TextStyle(
                    fontSize: AppStyles.size.body,
                    fontWeight: AppStyles.weight.emphasis,
                    color: AppColors.black,
                  ),
                ),
              ),
              SizedBox(width: ScreenUtilHelper.width(50)),
              Container(
                width: ScreenUtilHelper.width(167),
                height: ScreenUtilHelper.height(44),
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilHelper.width(10)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      ScreenUtilHelper.radius(8)),
                  border: Border.all(
                    color: AppColors.primaryContrast,
                    width: 1,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedTerm,
                    icon: Icon(
                        Icons.keyboard_arrow_down, color: AppColors.black),
                    dropdownColor: AppColors.white,
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: AppStyles.weight.emphasis,
                      fontSize: AppStyles.size.bodySmall,
                    ),
                    items: ['Math', 'Science', 'Eng'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: AppStyles.weight.emphasis,
                            fontSize: AppStyles.size.bodySmall,
                          ),
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
              padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
              child: Container(
                width: ScreenUtilHelper.width(396),
                height: ScreenUtilHelper.height(525),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(
                      ScreenUtilHelper.radius(5)),
                  border: Border.all(color: AppColors.cloud),
                ),
                padding: EdgeInsets.all(ScreenUtilHelper.width(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(ScreenUtilHelper.width(8.0)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Class ',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: AppStyles.weight.emphasis,
                                    fontSize: AppStyles.size.bodySmall,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' XA',
                                      style: TextStyle(
                                        color: AppColors.primaryContrast,
                                        fontSize: AppStyles.size.bodySmall,
                                        fontWeight: AppStyles.weight.emphasis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: ScreenUtilHelper.width(30)),
                              RichText(
                                text: TextSpan(
                                  text: 'Year ',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' 2025',
                                      style: TextStyle(
                                        color: AppColors.primaryContrast,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(ScreenUtilHelper.width(8.0)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'sub',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: AppStyles.weight.emphasis,
                                    fontSize: AppStyles.size.bodySmall,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '     Math',
                                      style: TextStyle(
                                        color: AppColors.primaryContrast,
                                        fontSize: AppStyles.size.bodySmall,
                                        fontWeight: AppStyles.weight.emphasis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: ScreenUtilHelper.width(30)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(ScreenUtilHelper.width(8.0)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Staff ',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: AppStyles.weight.emphasis,
                                    fontSize: AppStyles.size.bodySmall,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '  Praabhu N',
                                      style: TextStyle(
                                        color: AppColors.primaryContrast,
                                        fontSize: AppStyles.size.bodySmall,
                                        fontWeight: AppStyles.weight.emphasis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: ScreenUtilHelper.width(30)),
                            ],
                          ),
                        ],
                      ),
                    ),


                    SizedBox(height: ScreenUtilHelper.height(35)),
                    // ScreenUtilHelper

                    Center(
                      child: Text(
                        'Subject wise Performance Graph',
                        style: TextStyle(
                          fontWeight: AppStyles.weight.emphasis,
                          color: AppColors.black,
                          fontSize: ScreenUtilHelper.fontSize(
                              14), // ScreenUtilHelper
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.height(25)),
                    // ScreenUtilHelper

// Chart Area
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
                                reservedSize: ScreenUtilHelper.height(30),
                                // ScreenUtilHelper
                                getTitlesWidget: (value, meta) {
                                  final labels = ['1st', '2nd', '3rd', '4th'];
                                  final index = value.toInt();
                                  if (index >= 0 && index < labels.length) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          top: ScreenUtilHelper.height(8.0)),
                                      // ScreenUtilHelper
                                      child: Text(
                                        labels[index],
                                        style: TextStyle(
                                          fontSize: ScreenUtilHelper.fontSize(
                                              AppStyles.size.small),
                                          // ScreenUtilHelper
                                          color: AppColors.blackMediumEmphasis,
                                        ),
                                      ),
                                    );
                                  }
                                  return const Text('');
                                },
                              ),
                              axisNameWidget: Padding(
                                padding: EdgeInsets.only(
                                    top: ScreenUtilHelper.height(10.0)),
                                // ScreenUtilHelper
                                child: Text(
                                  "All Term",
                                  style: TextStyle(
                                    fontSize: ScreenUtilHelper.fontSize(
                                        AppStyles.size.small),
                                    // ScreenUtilHelper
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryContrast,
                                  ),
                                ),
                              ),
                              axisNameSize: ScreenUtilHelper.height(
                                  25), // ScreenUtilHelper
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 20,
                                reservedSize: ScreenUtilHelper.width(35),
                                // ScreenUtilHelper
                                getTitlesWidget: (value, meta) {
                                  if (value > 100 || value < 0)
                                    return const SizedBox.shrink();
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        right: ScreenUtilHelper.width(4.0)),
                                    // ScreenUtilHelper
                                    child: Text(
                                      value.toInt().toString(),
                                      style: TextStyle(
                                        fontSize: ScreenUtilHelper.fontSize(
                                            AppStyles.size.small),
                                        // ScreenUtilHelper
                                        color: AppColors.blackMediumEmphasis,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  );
                                },
                              ),
                              axisNameWidget: Text(
                                "Total Student",
                                style: TextStyle(
                                  fontSize: ScreenUtilHelper.fontSize(
                                      AppStyles.size.small), // ScreenUtilHelper
                                  fontWeight: AppStyles.weight.medium,
                                ),
                              ),
                              axisNameSize: ScreenUtilHelper.height(
                                  20), // ScreenUtilHelper
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
                            checkToShowHorizontalLine: (value) =>
                            value % 20 == 0,
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.silver,
                                width: ScreenUtilHelper.height(
                                    1), // ScreenUtilHelper
                              ),
                            ),
                          ),
                          barGroups: _buildBarGroups(),
                        ),
                      ),
                    ),

                    SizedBox(height: ScreenUtilHelper.height(20)),
                    // ScreenUtilHelper
                    _buildLegend(),
                    SizedBox(height: ScreenUtilHelper.height(10)),
                    // ScreenUtilHelper
                    // Optional space at the bottom
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: ScreenUtilHelper.height(20)),
          // ScreenUtilHelper added
          Padding(
            padding: EdgeInsets.only(right: ScreenUtilHelper.width(16)),
            // ScreenUtilHelper added
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "download",
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.fontSize(
                        AppStyles.size.bodySmall), // ScreenUtilHelper added
                    fontWeight: AppStyles.weight.emphasis,
                  ),
                ),
                SizedBox(width: ScreenUtilHelper.width(15)),
                // ScreenUtilHelper added
                Icon(
                  Icons.download,
                  size: ScreenUtilHelper.fontSize(18), // ScreenUtilHelper added
                  color: AppColors.primaryBright,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// Builds the data for the bar chart groups
  List<BarChartGroupData> _buildBarGroups() {
    // Data format: [Fail, below 50%, below 60%, +75%]
    // Values estimated from the image, summing to 100
    List<List<double>> data = [
      [8, 16, 8, 68],
      [5, 18, 4, 73],
      [7, 6, 2, 85],
      [6, 4, 6, 84],
    ];

    return List.generate(data.length, (index) {
      final bars = data[index];
      // Calculate cumulative sums for stack positioning
      final cumulative = List<double>.filled(bars.length, 0);
      for (int i = 0; i < bars.length; i++) {
        cumulative[i] = bars[i] + (i == 0 ? 0 : cumulative[i - 1]);
      }

      return BarChartGroupData(
        x: index, // Represents the term index (0=1st, 1=2nd, ...)
        barRods: [
          BarChartRodData(
            toY: cumulative.last, // Total height of the bar
            width: ScreenUtilHelper.width(28), // ScreenUtilHelper added
            borderRadius: BorderRadius.zero, // Sharp corners for stacked bars
            rodStackItems: [
              // Stack Item: Fail (Red)
              BarChartRodStackItem(0, cumulative[0], AppColors.error),
              // Stack Item: below 50% (Pale Mint Green)
              BarChartRodStackItem(cumulative[0], cumulative[1], below50Color),
              // Stack Item: below 60% (Orange)
              BarChartRodStackItem(
                  cumulative[1], cumulative[2], AppColors.pending),
              // Stack Item: +75% (Green)
              BarChartRodStackItem(
                  cumulative[2], cumulative[3], AppColors.successAccent),
            ],
          ),
        ],
      );
    });
  }

// Builds the legend widget below the chart
  Widget _buildLegend() {
    // Legend items ordered as they appear visually in the image's legend row
    final items = [
      {'color': AppColors.successAccent, 'label': '+75%'},
      {'color': AppColors.pending, 'label': 'below 60%'},
      {'color': AppColors.below50, 'label': 'below 50%'},
      // Use the corrected color
      {'color': AppColors.error, 'label': 'Fail'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Center the legend items
      children: items.map((item) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.width(8), // ScreenUtilHelper added
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Row takes minimum space needed
            children: [
              Container(
                width: ScreenUtilHelper.width(12), // ScreenUtilHelper added
                height: ScreenUtilHelper.height(12), // ScreenUtilHelper added
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      ScreenUtilHelper.width(10)), // ScreenUtilHelper added
                  color: item['color'] as Color,
                ),
              ),
              SizedBox(width: ScreenUtilHelper.width(6)),
              // ScreenUtilHelper added
              Text(
                item['label'] as String,
                style: TextStyle(
                  fontSize: ScreenUtilHelper.fontSize(
                      AppStyles.size.small), // ScreenUtilHelper added
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}