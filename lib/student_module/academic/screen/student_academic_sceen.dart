import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../app_colors.dart';
import '../bloc/student_academic_bloc.dart';
import '../bloc/student_academic_event.dart';
import '../bloc/student_academic_state.dart';
import '../model/student_report_model.dart';

class StudentacademicScreen extends StatelessWidget {
  const StudentacademicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We are no longer wrapping with BlocProvider here,
    // as it is already provided by GoRoute.
    // The context here can now correctly find the Bloc.
    print(0.02);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: _buildAppBar(context),
      body: BlocBuilder<StudentAcademicBloc, StudentAcademicState>(
        builder: (context, state) {
          if (state is StudentReportInitial) {
            StudentReportModel report = StudentReportModel(
              rank: 15,
              totalResult: "Pass",
              scores: [
                SubjectScore(srNo: 1, subject: 'Science', score: 75, percentage: 75.0, result: "Pass", total: 100),
                SubjectScore(srNo: 2, subject: 'Maths', score: 82, percentage: 82.0, result: "Pass", total: 100),
              ],
              performanceData: [60, 70, 75, 82, 78, 85],
            );
            return _buildReportBody(context, report, 'Annual Exam');
          }
          if (state is StudentReportLoaded) {
            return _buildReportBody(context, state.report, state.selectedExamType);
          }
          if (state is StudentReportError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.white,
      elevation: 0,
      leading: GestureDetector(
          onTap: ()=>GoRouter.of(context).pop(),
          child: const Icon(Icons.arrow_back, color: AppColor.primaryText)),
      title: const Text(
        'Student Report',
        style: TextStyle(color: AppColor.primaryText, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: AppColor.primaryText),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildReportBody(BuildContext context, StudentReportModel report, String selectedExamType) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderSection(context, report, selectedExamType),
          const SizedBox(height: 24),
          Text(selectedExamType, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildScoresTable(context, report.scores),
          const SizedBox(height: 24),
          const Text('Performance Graph', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildPerformanceGraph(context, report.performanceData),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, StudentReportModel report, String selectedExamType) {
    final examTypes = ['Annual Exam', 'Quarter yearly', 'Half yearly'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isDense: true,
              value: selectedExamType,
              items: examTypes.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  context.read<StudentAcademicBloc>().add(FetchStudentReport(examType: newValue));
                }
              },
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text('Rank', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.rankText)),
            Text(
              report.rank.toString(),
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColor.rankText,
              ),
            ),
            // Display the totalResult here
            Text(
              'Result: ${report.totalResult}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryText,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildScoresTable(BuildContext context, List<SubjectScore> scores) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColor.cardBackground,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth),
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.transparent),
                columns: const [
                  DataColumn(label: Text('Sr.No', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Subject', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Score', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Percentage', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Result', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: scores
                    .map((score) => DataRow(
                  color: MaterialStateProperty.all(AppColor.white),
                  cells: [
                    DataCell(Text(score.srNo.toString())),
                    DataCell(Text(score.subject)),
                    DataCell(Text(score.score.toString())),
                    DataCell(Text('${score.percentage}%')),
                    DataCell(Text(score.result)),
                    DataCell(Text(score.total.toString())),
                  ],
                ))
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPerformanceGraph(BuildContext context, List<double> performanceData) {
    final List<String> bottomLabels = [
      '1st term',
      '2nd term',
      'Quarterly',
      '3rd Term',
      '4th Term',
      'Half Yearly',
    ];

    final Map<double, String> yLabels = {
      50: 'Poor',
      65: 'Average',
      80: 'Good',
      95: 'Excellent',
    };

    final List<FlSpot> spots = performanceData.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value);
    }).toList();

    int highestIndex = 0;
    if (performanceData.isNotEmpty) {
      highestIndex = performanceData.indexWhere(
            (e) => e == performanceData.reduce((a, b) => a > b ? a : b),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: AspectRatio(
        aspectRatio: 1.8,
        child: LineChart(
          LineChartData(
            minY: 50,
            maxY: 100,
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              getDrawingHorizontalLine: (value) {
                return const FlLine(
                  color: Colors.grey,
                  strokeWidth: 0.5,
                  dashArray: [5, 5],
                );
              },
            ),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                  reservedSize: 28,
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 65,
                  getTitlesWidget: (value, meta) {
                    if (yLabels.containsKey(value)) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          yLabels[value]!,
                          style: const TextStyle(color: Colors.black54, fontSize: 12),
                          textAlign: TextAlign.left,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 42,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (value == index && index >= 0 && index < bottomLabels.length) {
                      return SideTitleWidget(
                        meta: meta,
                        space: 4,
                        angle: -math.pi / 4,
                        child: Text(
                          bottomLabels[index],
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 11,
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            extraLinesData: ExtraLinesData(
              verticalLines: [
                VerticalLine(
                  x: highestIndex.toDouble(),
                  color: Colors.deepPurpleAccent,
                  strokeWidth: 1,
                  dashArray: [5, 5],
                  label: VerticalLineLabel(
                    show: true,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 5),
                    style: const TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    labelResolver: (line) => "Highest performance",
                  ),
                ),
              ],
            ),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: Colors.indigo,
                barWidth: 1,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: false,
                  color: Colors.indigoAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
