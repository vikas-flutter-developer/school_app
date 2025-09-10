// Your updated student_detail_screen.dart file

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:fl_chart/fl_chart.dart';

// ✅ STEP 1: Import the helper
import '../../core/utils/screen_util_helper.dart';

import '../../core/utils/app_colors.dart';
import '../Student_Academic/model.dart';
import 'bloc/student_detail_bloc.dart';
import 'bloc/student_detail_state.dart';
import 'models/student_performance.dart';


class StudentDetailScreen extends StatelessWidget {
  final Student student;
  final String previousScreenTitle;

  const StudentDetailScreen({
    super.key,
    required this.student,
    required this.previousScreenTitle,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Initialize the helper here if not done in MyApp/MaterialApp
    ScreenUtilHelper.init(context);

    return BlocProvider(
      create: (context) => StudentDetailBloc()
        ..add(LoadStudentDetails(student, previousScreenTitle)),
      child: const StudentDetailView(),
    );
  }
}

class StudentDetailView extends StatelessWidget {
  const StudentDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ STEP 2: Remove old MediaQuery logic. All sizing is now done directly with the helper.

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      body: BlocBuilder<StudentDetailBloc, StudentDetailState>(
        builder: (context, state) {
          if (state.status == DetailStatus.initial || state.status == DetailStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == DetailStatus.failure) {
            return Center(child: Text('Error: ${state.errorMessage ?? 'Could not load details'}'));
          }
          if (state.status == DetailStatus.success && state.student != null) {
            return SingleChildScrollView(
              child: Padding(
                // ✅ Use helper for padding
                padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBreadcrumb(context, state.breadcrumbTitle),
                    SizedBox(height: ScreenUtilHelper.height(6)),
                    _buildStudentInfoCard(context, state),
                    SizedBox(height: ScreenUtilHelper.height(18)),
                    _buildSectionTitle('Subject/percentage graph'),
                    SizedBox(height: ScreenUtilHelper.height(12)),
                    _buildBarChart(context, state.subjectGraphData),
                    SizedBox(height: ScreenUtilHelper.height(18)),
                    _buildSectionTitle('Student growth'),
                    SizedBox(height: ScreenUtilHelper.height(12)),
                    _buildLineChart(context, state.growthData),
                    SizedBox(height: ScreenUtilHelper.height(24)),
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text('An unexpected error occurred.'));
        },
      ),
      bottomNavigationBar: BlocBuilder<StudentDetailBloc, StudentDetailState>(
          builder: (context, state) {
            return BottomNavigationBar(
              currentIndex: state.bottomNavIndex,
              onTap: (index) => context.read<StudentDetailBloc>().add(BottomNavTapped(index)),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.info,
              unselectedItemColor: AppColors.ash,
              // ✅ Use helper for font sizes
              selectedLabelStyle: GoogleFonts.openSans(fontWeight: FontWeight.w500, fontSize: ScreenUtilHelper.fontSize(12)),
              unselectedLabelStyle: GoogleFonts.openSans(fontSize: ScreenUtilHelper.fontSize(12)),
              backgroundColor: AppColors.white,
              elevation: 4.0, // Elevation is unitless, no need to scale
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.feed_outlined), activeIcon: Icon(Icons.feed), label: 'Feed'),
                BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'My Account'),
              ],
            );
          }
      ),

    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        // ✅ Use helper for icon size
        icon: Icon(Icons.arrow_back_ios, size: ScreenUtilHelper.scaleAll(20), color: AppColors.blackMediumEmphasis),
        onPressed: () => GoRouter.of(context).pop(),
      ),
      title: Text(
        'Student Academics',
        style: GoogleFonts.openSans(
          color: AppColors.blackHighEmphasis,
          fontWeight: FontWeight.bold,
          // ✅ Use helper for font size
          fontSize: ScreenUtilHelper.fontSize(17),
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: AppColors.blackMediumEmphasis),
          onPressed: () { },
        ),
        // ✅ Use helper for spacing
        SizedBox(width: ScreenUtilHelper.width(8)),
      ],
    );
  }

  Widget _buildBreadcrumb(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.openSans(
                fontSize: ScreenUtilHelper.fontSize(14),
                fontWeight: FontWeight.w600,
                color: AppColors.blackHighEmphasis,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: Icon(Icons.print_outlined, color: AppColors.printIconColor, size: ScreenUtilHelper.scaleAll(24)),
            onPressed: () { },
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
            tooltip: 'Print Details',
          ),
        ],
      ),
    );
  }

  Widget _buildStudentInfoCard(BuildContext context, StudentDetailState state) {
    final student = state.student ?? const Student(srNo: '', admissionNo: 'N/A', name: 'N/A', contactNo: '', stat: '');
    final performance = state.performanceData;

    return Card(
      elevation: 2.0,
      margin: EdgeInsets.zero,
      color: AppColors.secondaryAccentLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(12))),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(12)),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: ScreenUtilHelper.scaleAll(68) / 2, // 34
                  backgroundColor: AppColors.cloud,
                  backgroundImage: const AssetImage('assets/images/profile.png'),
                ),
                SizedBox(width: ScreenUtilHelper.width(12)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.name.toUpperCase(),
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtilHelper.fontSize(13),
                          color: AppColors.blackHighEmphasis,
                        ),
                      ),
                      SizedBox(height: ScreenUtilHelper.height(4)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoText('class: 10 C', ScreenUtilHelper.fontSize(11)),
                          _buildInfoText('Roll no: 0056', ScreenUtilHelper.fontSize(11)),
                        ],
                      ),
                      SizedBox(height: ScreenUtilHelper.height(6)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoColumn('Admission Number', student.admissionNo),
                          _buildInfoColumn('Academic Year', '2024-2025'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenUtilHelper.height(15)),
            _buildProgressBar('Theory', performance.theory),
            SizedBox(height: ScreenUtilHelper.height(8)),
            _buildProgressBar('Practical', performance.practical),
            SizedBox(height: ScreenUtilHelper.height(8)),
            _buildProgressBar('Attendance', performance.attendance),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoText(String text, double fontSize) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        fontSize: fontSize,
        color: AppColors.blackHighEmphasis,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.openSans(
            fontSize: ScreenUtilHelper.fontSize(11),
            color: AppColors.blackHighEmphasis,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: ScreenUtilHelper.height(2)),
        Text(
          value,
          style: GoogleFonts.openSans(
            fontSize: ScreenUtilHelper.fontSize(13),
            color: AppColors.blackHighEmphasis,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(String label, double value) {
    final labelSize = ScreenUtilHelper.fontSize(13);
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: GoogleFonts.openSans(
              fontSize: labelSize,
              fontWeight: FontWeight.w600,
              color: AppColors.blackHighEmphasis,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: LinearPercentIndicator(
            percent: value / 100.0,
            lineHeight: ScreenUtilHelper.height(10),
            animation: true,
            animationDuration: 800,
            barRadius: Radius.circular(ScreenUtilHelper.radius(5)),
            progressColor: AppColors.success,
            backgroundColor: AppColors.cloud,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '${value.toStringAsFixed(0)}%',
            textAlign: TextAlign.end,
            style: GoogleFonts.openSans(
              fontSize: labelSize,
              fontWeight: FontWeight.w600,
              color: AppColors.blackHighEmphasis,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.openSans(
        fontSize: ScreenUtilHelper.fontSize(14),
        fontWeight: FontWeight.bold,
        color: AppColors.blackHighEmphasis,
      ),
    );
  }

  Widget _buildBarChart(BuildContext context, List<SubjectPerformance> data) {
    if (data.isEmpty) return SizedBox(height: ScreenUtilHelper.height(150), child: const Center(child: Text("No data")));

    return SizedBox(
      height: ScreenUtilHelper.height(245),
      child: BarChart(
        BarChartData(
          maxY: 100,
          minY: 0,
          alignment: BarChartAlignment.spaceAround,
          borderData: FlBorderData(
            show: true,
            border: const Border(bottom: BorderSide(color: AppColors.gridLineColor, width: 1)),
          ),
          gridData: const FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 10,
            getDrawingHorizontalLine: _getGridLine,
          ),
          extraLinesData: ExtraLinesData(
            horizontalLines: [
              HorizontalLine(y: 30, color: AppColors.dottedLineColor, strokeWidth: 1, dashArray: [4, 4]),
            ],
          ),
          titlesData: FlTitlesData(
            show: true,
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: ScreenUtilHelper.height(30),
                getTitlesWidget: (double value, TitleMeta meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < data.length) {

                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: ScreenUtilHelper.height(30),
                        getTitlesWidget: (double value, TitleMeta meta) {
                          final index = value.toInt();
                          String text = '';
                          if (index >= 0 && index < data.length) {
                            text = data[index].subject;
                          }
                          return SideTitleWidget(
                            meta: meta, //
                            space: ScreenUtilHelper.height(4),

                            child: Text(
                              text,
                              style: GoogleFonts.openSans(
                                color: AppColors.blackHighEmphasis,
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtilHelper.fontSize(10),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                    // return SideTitleWidget(
                    //   axisSide: meta.axisSide,
                    //   space: ScreenUtilHelper.height(4),
                    //   child: Text(
                    //     data[index].subject,
                    //     style: GoogleFonts.openSans(
                    //       color: AppColors.blackHighEmphasis,
                    //       fontWeight: FontWeight.w500,
                    //       fontSize: ScreenUtilHelper.fontSize(10),
                    //     ),
                    //   ),
                    // );
                  }
                  return const Text('');
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: ScreenUtilHelper.width(35),
                interval: 10,
                getTitlesWidget: (double value, TitleMeta meta) {
                  if (value % 10 == 0) {
                    return Text(
                      '${value.toInt()}',
                      style: GoogleFonts.openSans(
                        color: AppColors.blackHighEmphasis,
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtilHelper.fontSize(10),
                      ),
                      textAlign: TextAlign.right,
                    );
                  }
                  return const Text('');
                },
              ),
            ),
          ),
          barGroups: data.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: item.value,
                  gradient: LinearGradient(
                    colors: item.isFailure
                        ? [AppColors.barChartFailColor1, AppColors.barChartFailColor2]
                        : [AppColors.barChartColor1, AppColors.barChartColor2],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  width: ScreenUtilHelper.width(18),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(ScreenUtilHelper.radius(4)),
                    topRight: Radius.circular(ScreenUtilHelper.radius(4)),
                  ),
                ),
              ],
            );
          }).toList(),
          barTouchData: BarTouchData(enabled: false),
        ),
      ),
    );
  }


  Widget _buildLineChart(BuildContext context, List<FlSpot> data) {
    if (data.isEmpty) return SizedBox(height: ScreenUtilHelper.height(150), child: const Center(child: Text("No growth data")));

    final Map<double, String> yLabels = { 10: 'Poor', 40: 'Average', 60: 'Good', 80: 'Excellent' };

    return SizedBox(
      height: ScreenUtilHelper.height(245),
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: 100,
          gridData: const FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 20,
            getDrawingHorizontalLine: _getDashedGridLine,
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            show: true,
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: ScreenUtilHelper.width(60),
                interval: 20,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return yLabels.containsKey(value)
                      ? Padding(
                    padding: EdgeInsets.only(left: ScreenUtilHelper.width(8)),
                    child: Text(
                      yLabels[value]!,
                      style: GoogleFonts.openSans(
                        color: AppColors.blackHighEmphasis,
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtilHelper.fontSize(10),
                      ),
                    ),
                  )
                      : Container();
                },
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: data,
              isCurved: true,
              gradient: const LinearGradient(
                colors: [AppColors.lineChartColor, AppColors.lineChartAltColor],
              ),
              barWidth: ScreenUtilHelper.width(4),
              isStrokeCapRound: true,
              dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: ScreenUtilHelper.scaleAll(5),
                      color: AppColors.white,
                      strokeWidth: ScreenUtilHelper.scaleAll(2),
                      strokeColor: AppColors.lineChartColor,
                    );
                  }
              ),
              belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [AppColors.lineChartColor.withOpacity(0.3), AppColors.lineChartColor.withOpacity(0.0)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                  return touchedBarSpots.map((barSpot) {
                    final flSpot = barSpot;
                    return LineTooltipItem(
                      'Exam ${flSpot.x.toInt() + 1}\n',
                      GoogleFonts.openSans(color: AppColors.white, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: flSpot.y.toStringAsFixed(0),
                          style: GoogleFonts.openSans(color: AppColors.white, fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: '%',
                          style: GoogleFonts.openSans(color: AppColors.white, fontWeight: FontWeight.w500, fontSize: ScreenUtilHelper.fontSize(10)),
                        ),
                      ],
                    );
                  }).toList();
                }
            ),
          ),
        ),
      ),
    );
  }

  // Helper functions for chart grid lines
  static FlLine _getGridLine(double value) {
    return const FlLine(color: AppColors.gridLineColor, strokeWidth: 0.5);
  }

  static FlLine _getDashedGridLine(double value) {
    return const FlLine(color: AppColors.gridLineColor, strokeWidth: 1, dashArray: [5, 5]);
  }

}