import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import 'student_section.dart' show StudentMarksSection;
import '../widget/dropdown.dart' show CustomDropdown;

class MarksProgressScreen extends StatefulWidget {
  const MarksProgressScreen({super.key});

  @override
  State<MarksProgressScreen> createState() => _MarksProgressScreenState();
}

class _MarksProgressScreenState extends State<MarksProgressScreen> {
  String? selectedYear;
  String? selectedClass;
  String? selectedSection;
  String selectedTab = 'Class';

  final academicYears = ['2025 - 2026', '2024 - 2025', '2023 - 2024', '2022 - 2023'];
  final classes = ['X', 'XI', 'XII'];
  final sections = ['A', 'B', 'C', 'D', 'E'];

  bool get showReport =>
      selectedYear != null && selectedClass != null && selectedSection != null;

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: const Text('Marks & Progress Card'),
        actions: [
          const Icon(Icons.notifications_outlined),
          SizedBox(width: ScreenUtilHelper.width(16)),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTabSwitcher(),
            SizedBox(height: ScreenUtilHelper.height(16)),
            if (selectedTab == 'Class') ...[
              _buildSearchField(),
              SizedBox(height: ScreenUtilHelper.height(16)),
              CustomDropdown(
                label: 'Select Academic Year',
                value: selectedYear,
                items: academicYears,
                onChanged: (val) => setState(() => selectedYear = val),
              ),
              CustomDropdown(
                label: 'Select Class',
                value: selectedClass,
                items: classes,
                onChanged: (val) => setState(() => selectedClass = val),
              ),
              CustomDropdown(
                label: 'Select Section',
                value: selectedSection,
                items: sections,
                onChanged: (val) => setState(() => selectedSection = val),
              ),
              SizedBox(height: ScreenUtilHelper.height(16)),
              if (showReport)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Class ${selectedClass!}${selectedSection!} (${selectedYear!}) Marks Report',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtilHelper.fontSize(16)),
                    ),
                    SizedBox(height: ScreenUtilHelper.height(12)),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: _buildMarksheetTable(),
                    ),
                  ],
                ),
            ] else ...[
              _buildStudentMarksSection(),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildTabSwitcher() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: ['Class', 'Student'].map((tab) {
        final isSelected = selectedTab == tab;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => selectedTab = tab),
            child: Column(
              children: [
                Text(
                  tab,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.fontSize(16),
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: ScreenUtilHelper.height(4)),
                Container(
                  height: ScreenUtilHelper.height(4),
                  color:
                  isSelected ? AppColors.primaryMedium : AppColors.transparent,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: const Icon(Icons.mic),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
        ),
      ),
    );
  }

  Widget _buildMarksheetTable() {
    return DataTable(
      headingRowColor: MaterialStateProperty.all(AppColors.cloud),
      dataRowColor: MaterialStateProperty.all(AppColors.white),
      headingTextStyle: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.bold,
        fontSize: ScreenUtilHelper.fontSize(14),
      ),
      dataTextStyle: TextStyle(
        color: AppColors.black,
        fontSize: ScreenUtilHelper.fontSize(14),
      ),
      columns: const [
        DataColumn(label: Text('Sr. No.')),
        DataColumn(label: Text('Roll No.')),
        DataColumn(label: Text('Student Name')),
        DataColumn(label: Text('Total Marks Obtained')),
        DataColumn(label: Text('CGPA')),
        DataColumn(label: Text('Grade')),
      ],
      rows: List.generate(9, (index) {
        return DataRow(
          cells: [
            DataCell(Text('${index + 1}')),
            DataCell(Text('445878${index % 2}')),
            const DataCell(Text('Lorem Ipsum')),
            const DataCell(Text('89')),
            const DataCell(Text('9.2')),
            const DataCell(Text('A')),
          ],
        );
      }),
    );
  }

  Widget _buildStudentMarksSection() {
    return const StudentMarksSection();
  }
}
