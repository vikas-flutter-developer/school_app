import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart';

class StudentMarksSection extends StatefulWidget {
  const StudentMarksSection({super.key});

  @override
  State<StudentMarksSection> createState() => _StudentMarksSectionState();
}

class _StudentMarksSectionState extends State<StudentMarksSection> {
  final List<String> exams = ['Quarter Yearly', 'Half Yearly', 'Annual Exam'];
  String? selectedExam;
  int _selectedIndex = 0; // Add in your State class

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStudentCard(),
        SizedBox(height: ScreenUtilHelper.height(16)),
        _buildExamDropdown(),
        if (selectedExam != null) ...[
          SizedBox(height: ScreenUtilHelper.height(24)),
          _buildMarksTableImage(),
          SizedBox(height: ScreenUtilHelper.height(16)),
          _buildPerformanceGraphImage(),
        ]
      ],
    );
  }


  Widget _buildStudentCard() {
    return Container(
      padding: EdgeInsets.all(ScreenUtilHelper.width(16)),
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/profile.png',
                height: ScreenUtilHelper.scaleAll(60),
                width: ScreenUtilHelper.scaleAll(60),
                fit: BoxFit.cover,
              ),
              SizedBox(width: ScreenUtilHelper.width(16)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('NAVEEN NAVEEN',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtilHelper.fontSize(16))),
                    SizedBox(height: ScreenUtilHelper.height(4)),
                    const Text('Class: 10 C  |  Roll no.: 0056'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenUtilHelper.height(12)),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StudentInfo(title: 'CGPA', value: '7.5'),
              Text('|', style: TextStyle(color: AppColors.blackMediumEmphasis)),
              _StudentInfo(title: 'Rank', value: '12'),
              Text('|', style: TextStyle(color: AppColors.blackMediumEmphasis)),
              _StudentInfo(title: 'Grade', value: 'A'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExamDropdown() {
    return DropdownButton<String>(
      value: selectedExam,
      hint: const Text("Exam Type"),
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down),
      onChanged: (val) => setState(() => selectedExam = val),
      items: exams.map((e) {
        return DropdownMenuItem(
          value: e,
          child: Text(e),
        );
      }).toList(),
    );
  }

  Widget _buildMarksTableImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10), // Outer container radius
      child: Container(
        width: 398,
        height: 211,
        color: Colors.white,
        padding: const EdgeInsets.all(8), // Gap inside the white card
        child: Container(
          width: 357,
          height: 139,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F3FF), // Light purple background
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Prevents overflow
            child: DataTable(
              headingRowHeight: 36,
              dataRowHeight: 30,
              horizontalMargin: 8,
              columnSpacing: 10,
              dividerThickness: 0, // Removes dividers
              // Transparent border (equivalent to TableBorder.none)
              border: TableBorder.all(width: 0, color: Colors.transparent),
              headingTextStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 13,
              ),
              dataTextStyle: const TextStyle(
                fontSize: 12,
                color: Colors.black87,
              ),
              columns: const [
                DataColumn(label: Text('Subject Name')),
                DataColumn(label: Text('Total Marks')),
                DataColumn(label: Text('Obtained Marks')),
                DataColumn(label: Text('Results')),
                DataColumn(label: Text('Grade')),
              ],
              rows: [
                _row("Science", "100", "75", "Pass", "B", const Color(0xFF2563EB)),
                _row("Social Science", "100", "75", "Pass", "B", const Color(0xFF2563EB)),
                _row("Mathematics", "100", "75", "Pass", "B", const Color(0xFF2563EB)),
                _row("English", "100", "75", "Pass", "B", const Color(0xFF2563EB)),
                _row("2nd Language", "100", "75", "Pass", "B", const Color(0xFF2563EB)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DataRow _row(
      String subject,
      String total,
      String obtained,
      String result,
      String grade,
      Color color,
      ) {
    return DataRow(
      cells: [
        DataCell(Text(subject, style: TextStyle(color: color, fontWeight: FontWeight.w500))),
        DataCell(Text(total)),
        DataCell(Text(obtained)),
        DataCell(Text(result)),
        DataCell(Text(grade)),
      ],
    );
  }


  Widget _buildPerformanceGraphImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        Padding(
          padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(8)),
          child: Text(
            'Performance Progress Graph',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtilHelper.fontSize(16),
            ),
          ),
        ),

        /// Graph Container
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey.shade300, width: 1),
              bottom: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.width(8),
            vertical: ScreenUtilHelper.height(12),
          ),
          child: Column(
            children: [
              /// Chart
              SizedBox(
                width: double.infinity,
                height: ScreenUtilHelper.height(160),
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 1,
                      getDrawingHorizontalLine: (_) => FlLine(
                        color: Colors.green.shade400,
                        strokeWidth: 1,
                        dashArray: [4, 4],
                      ),
                    ),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          reservedSize: ScreenUtilHelper.width(40),
                          getTitlesWidget: (value, _) {
                            switch (value.toInt()) {
                              case 0:
                                return Text("Poor", style: TextStyle(fontSize: 7));
                              case 1:
                                return Text("Average", style: TextStyle(fontSize: 8));
                              case 2:
                                return Text("Good", style: TextStyle(fontSize: 8));
                              case 3:
                                return Text("Excellent", style: TextStyle(fontSize: 8));
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    minX: 0,
                    maxX: 5,
                    minY: 0,
                    maxY: 3,
                    lineBarsData: [
                      LineChartBarData(
                        spots: const [
                          FlSpot(0, 0.1),
                          FlSpot(1, 0.4),
                          FlSpot(2, 1.5),
                          FlSpot(3, 0.2),
                          FlSpot(4, 2.4),
                          FlSpot(5, 2.6),
                        ],
                        isCurved: true,
                        color: Colors.green,
                        barWidth: 1,
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF7FFF9B), // start
                              const Color.fromRGBO(56, 240, 119, 0), // end transparent
                            ],
                            stops: const [0.0, 1.0],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            transform: const GradientRotation(
                              180.37 * (3.14159265359 / 180), // degrees to radians
                            ),
                          ),
                        ),
                        dotData: FlDotData(show: false),
                      ),
                    ],
                  ),
                ),
              ),

              /// Blue divider line
              Container(
                margin: EdgeInsets.only(top: ScreenUtilHelper.height(8)),
                width: ScreenUtilHelper.width(369.5250),
                height: ScreenUtilHelper.height(0.41),
                color: const Color(0xFF727376),
              ),

              /// Bottom labels
              Padding(
                padding: EdgeInsets.only(top: ScreenUtilHelper.height(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("1st term", style: TextStyle(fontSize: 10)),
                    Text("2nd term", style: TextStyle(fontSize: 10)),
                    Text("Quarter", style: TextStyle(fontSize: 10)),
                    Text("3rd Term", style: TextStyle(fontSize: 10)),

                    Text("Half Yearly", style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }



/* DataRow _row(String subject, String total, String obtained, String result, String grade, Color color) {
    return DataRow(
      cells: [
        DataCell(Text(subject, style: TextStyle(color: color, fontWeight: FontWeight.bold))),
        DataCell(Text(total)),
        DataCell(Text(obtained)),
        DataCell(Text(result)),
        DataCell(Text(grade)),
      ],
    );
  }*/


}

class _StudentInfo extends StatelessWidget {
  final String title;
  final String value;
  const _StudentInfo({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(2)),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtilHelper.fontSize(16)),
          ),
          Text(title, style: TextStyle(fontSize: ScreenUtilHelper.fontSize(12))),
        ],
      ),
    );
  }
}