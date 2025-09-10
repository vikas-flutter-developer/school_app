import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart'; // Import fl_chart
import 'package:intl/intl.dart'; // For date formatting

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart'; // ✅ Import ScreenUtilHelper
import '../bloc/fee_bloc.dart';
import '../bloc/fee_event.dart';

import '../bloc/fee_state.dart';
import '../widget/custom_dropdown.dart';
import '../widget/donut_chart_widget.dart';
// Import donut chart

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    return BlocBuilder<FeesBloc, FeesState>(
      builder: (context, state) {
        if (state.status == FeesStatus.loading &&
            state.paymentStatusData.isEmpty) {
          // Show loading only on initial load
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == FeesStatus.failure) {
          return Center(
            child: Text('Failed to load data: ${state.errorMessage}'),
          );
        }

        // Define colors for charts
        final paymentStatusColors = [
          AppColors.successAccent,
          AppColors.pending,
          AppColors.primaryDarker,
        ]; // Match legend order
        final feeStructureColors = [
          AppColors.pending,
          AppColors.pendingLight,
          AppColors.primaryDarker,
          AppColors.success,
        ]; // Match legend order

        return SingleChildScrollView(
          padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16.0)), //  Responsive
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Fees Statistics Section ---
              Text(
                'Fees Statistics',
                style: TextStyle(
                  fontSize: ScreenUtilHelper.scaleText(AppStyles.size.bodyLarge), //  Responsive
                  fontWeight: AppStyles.weight.emphasis,
                ),
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(16)), //  Responsive
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        if (state.paymentStatusData.isNotEmpty)
                          DonutChartWidget(
                            data: state.paymentStatusData,
                            colors: paymentStatusColors,
                            centerText: 'Payment\nStatus',
                          )
                        else
                          SizedBox(height: ScreenUtilHelper.scaleHeight(150)), //  Responsive
                        SizedBox(height: ScreenUtilHelper.scaleHeight(10)), //  Responsive
                        _buildLegend(
                          state.paymentStatusData,
                          paymentStatusColors,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: ScreenUtilHelper.scaleWidth(16)), //  Responsive
                  Expanded(
                    child: Column(
                      children: [
                        if (state.feeStructureData.isNotEmpty)
                          DonutChartWidget(
                            data: state.feeStructureData,
                            colors: feeStructureColors,
                            centerText: 'Fee\nStructure',
                          )
                        else
                          SizedBox(height: ScreenUtilHelper.scaleHeight(150)), //  Responsive
                        SizedBox(height: ScreenUtilHelper.scaleHeight(10)), //  Responsive
                        _buildLegend(
                          state.feeStructureData,
                          feeStructureColors,
                        ),
                      ],
                    ),
                  ),
                  // Add Month/Year Dropdown (Optional, simplified)
                  _buildMonthDropdown(context),
                ],
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(24)), //  Responsive
              const Divider(),
              SizedBox(height: ScreenUtilHelper.scaleHeight(16)), // Responsive

              // --- Overall Track Section ---
              Text(
                'Overall Track',
                style: TextStyle(
                  fontSize: ScreenUtilHelper.scaleText(AppStyles.size.bodyLarge), //  Responsive
                  fontWeight: AppStyles.weight.heading,
                ),
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(16)), //  Responsive
              _buildOverallTrackFilters(context, state),
              SizedBox(height: ScreenUtilHelper.scaleHeight(20)), //  Responsive
              if (state.overallTrackData.isNotEmpty)
                _buildBarChart(context, state.overallTrackData)
              else
                const Center(
                  child: Text("No track data available"),
                ), // Handle empty data
            ],
          ),
        );
      },
    );
  }

  // Helper to build legend items
  Widget _buildLegend(Map<String, double> data, List<Color> colors) {
    int i = 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: data.keys.map((label) {
        final legend = ChartLegend(
          color: colors[i % colors.length],
          text: label,
        );
        i++;
        return legend;
      }).toList(),
    );
  }

  Widget _buildMonthDropdown(BuildContext context) {
    // Simple placeholder - replace with actual month selection logic if needed
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtilHelper.scaleWidth(8), //  Responsive
          vertical: ScreenUtilHelper.scaleHeight(4), //  Responsive
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.cloud),
          borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(4)), //  Responsive
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Month',
              style: TextStyle(
                fontSize: ScreenUtilHelper.scaleText(AppStyles.size.small), //  Responsive
                color: AppColors.slate,
              ),
            ),
            SizedBox(width: ScreenUtilHelper.scaleWidth(4)), //  Responsive
            Icon(Icons.calendar_today, size: ScreenUtilHelper.scaleWidth(14), color: AppColors.ash), //  Responsive
          ],
        ),
      ),
    );
  }

  // Filter Row for Overall Track
  Widget _buildOverallTrackFilters(BuildContext context, FeesState state) {
    final bloc = context.read<FeesBloc>();
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: CustomDropdown(
            value: state.selectedOverviewClass,
            items: state.overviewClassOptions,
            onChanged: (value) {
              if (value != null) {
                bloc.add(FeesOverviewFilterChanged(selectedClass: value));
              }
            },
          ),
        ),
        SizedBox(width: ScreenUtilHelper.scaleWidth(10)), //  Responsive
        Expanded(
          flex: 2,
          child: CustomDropdown(
            value: state.selectedOverviewTerm,
            items: state.overviewTermOptions,
            onChanged: (value) {
              if (value != null) {
                bloc.add(FeesOverviewFilterChanged(selectedTerm: value));
              }
            },
          ),
        ),
        SizedBox(width: ScreenUtilHelper.scaleWidth(10)), //  Responsive
        Expanded(
          flex: 3, // Give date picker a bit more space
          child: InkWell(
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: state.selectedOverviewDate,
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );
              if (picked != null && picked != state.selectedOverviewDate) {
                bloc.add(FeesOverviewFilterChanged(selectedDate: picked));
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.scaleWidth(12.0), //  Responsive
                vertical: ScreenUtilHelper.scaleHeight(12.0), //  Responsive
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: AppColors.cloud),
                borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(8.0)), //  Responsive
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('dd-MM-yyyy').format(state.selectedOverviewDate),
                    style: TextStyle(
                      fontSize: ScreenUtilHelper.scaleText(AppStyles.size.bodySmall), //  Responsive
                    ),
                  ),
                  Icon(
                    Icons.calendar_today,
                    size: ScreenUtilHelper.scaleWidth(18), //  Responsive
                    color: AppColors.ash,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Bar Chart Widget (using fl_chart)
  Widget _buildBarChart(
      BuildContext context,
      Map<String, Map<String, double>> data,
      ) {
    final List<String> terms = data.keys.toList();

    var paidColor = AppColors.attendancePieAbsent;
    const unpaidColor = AppColors.barChartFailColor2;
    const overdueColor = AppColors.primaryBright;

    // Calculate max Y value dynamically
    double maxY = 0;
    data.values.forEach((termData) {
      double currentTotal = termData.values.fold(0, (sum, val) => sum + val);
      if (currentTotal > maxY) {
        maxY = currentTotal;
      }
    });
    maxY = (maxY * 1.1).ceilToDouble(); // Add 10% padding and round up

    return SizedBox(
      height: ScreenUtilHelper.scaleHeight(250), //  Responsive
      child: BarChart(
        BarChartData(
          maxY: maxY, // Dynamic max Y
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(
            enabled: false,
          ), // Disable touch interaction for simplicity
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: ScreenUtilHelper.scaleHeight(30), //  Responsive
                getTitlesWidget: (double value, TitleMeta meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < terms.length) {
                    return Padding(
                      padding: EdgeInsets.only(top: ScreenUtilHelper.scaleHeight(8.0)), //  Responsive
                      child: Text(
                        terms[index],
                        style: TextStyle(fontSize: ScreenUtilHelper.scaleText(AppStyles.size.tiny)), // Responsive
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
                reservedSize: ScreenUtilHelper.scaleWidth(30), //  Responsive
                interval: maxY / 5,
                getTitlesWidget: (value, meta) => Text(
                  value.toInt().toString(),
                  style: TextStyle(fontSize: ScreenUtilHelper.scaleText(AppStyles.size.tiny)), //  Responsive
                ),
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) {
              return FlLine(color: AppColors.cloud, strokeWidth: 0.5);
            },
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              bottom: BorderSide(color: AppColors.silver, width: 1),
              left: BorderSide(color: AppColors.silver, width: 1),
            ),
          ),
          barGroups: List.generate(terms.length, (index) {
            final term = terms[index];
            final termData = data[term]!;
            final paidValue = termData['Paid'] ?? 0;
            final unpaidValue = termData['Unpaid'] ?? 0;
            final overdueValue = termData['Overdue'] ?? 0;

            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: paidValue + unpaidValue + overdueValue,
                  rodStackItems: [
                    BarChartRodStackItem(0, overdueValue, overdueColor),
                    BarChartRodStackItem(overdueValue, overdueValue + unpaidValue, unpaidColor),
                    BarChartRodStackItem(overdueValue + unpaidValue, paidValue + unpaidValue + overdueValue, paidColor),
                  ],
                  width: ScreenUtilHelper.scaleWidth(25), //  Responsive
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
