import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart';
import '../../../customs/datepicker.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/attendence_table.dart';
import '../../marks&progress_cards/widget/dropdown.dart';

class StudentAttendanceScreen extends StatefulWidget {
  const StudentAttendanceScreen({super.key});

  @override
  State<StudentAttendanceScreen> createState() => _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
  String? _selectedAcademicYear;
  String? _selectedClass;
  String? _selectedSection;
  DateTime? _fromDate;
  DateTime? _toDate;

  final List<String> _academicYears = [
    '2024-2025',
    '2025-2026',
    '2026-2027',
    '2028-2029',
    '2029-2030'
  ];
  final List<String> _classes = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI', 'XII'];
  final List<String> _sections = ['A', 'B', 'C', 'D'];

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFromDate ? (_fromDate ?? DateTime.now()) : (_toDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          _fromDate = picked;
        } else {
          _toDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: ScreenUtilHelper.width(20)),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: Text(
          'Students Attendance',
          style: TextStyle(fontSize: ScreenUtilHelper.fontSize(18)),
        ),
        actions: [
          Icon(Icons.notifications_outlined, size: ScreenUtilHelper.width(24)),
          SizedBox(width: ScreenUtilHelper.width(16)),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(ScreenUtilHelper.width(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchField(),
            SizedBox(height: ScreenUtilHelper.height(16)),
            CustomDropdown(
              label: 'Academic Year',
              value: _selectedAcademicYear,
              items: _academicYears,
              onChanged: (value) => setState(() {
                _selectedAcademicYear = value;
              }),
            ),
            CustomDropdown(
              label: 'Select Class',
              value: _selectedClass,
              items: _classes,
              onChanged: (value) => setState(() {
                _selectedClass = value;
              }),
            ),
            CustomDropdown(
              label: 'Select Section',
              value: _selectedSection,
              items: _sections,
              onChanged: (value) => setState(() {
                _selectedSection = value;
              }),
            ),
            SizedBox(height: ScreenUtilHelper.height(16)),
            Row(
              children: [
                Expanded(
                  child: DatePickerWidget(
                    label: 'From :',
                    selectedDate: _fromDate,
                    onTap: () => _selectDate(context, true),
                  ),
                ),
                SizedBox(width: ScreenUtilHelper.width(16)),
                Expanded(
                  child: DatePickerWidget(
                    label: 'To :',
                    selectedDate: _toDate,
                    onTap: () => _selectDate(context, false),
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenUtilHelper.height(24)),
            if (_selectedAcademicYear != null &&
                _selectedClass != null &&
                _selectedSection != null &&
                _fromDate != null &&
                _toDate != null)
              const AttendanceTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: Icon(Icons.search, size: ScreenUtilHelper.width(24)),
        suffixIcon: Icon(Icons.mic, size: ScreenUtilHelper.width(24)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: ScreenUtilHelper.width(12),
          vertical: ScreenUtilHelper.height(12),
        ),
      ),
    );
  }
}
