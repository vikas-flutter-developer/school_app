// Your updated exam_schedule_screen.dart file

import 'package:edudibon_flutter_bloc/admin_module/timetable&exam_scheduling/screens/view_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart';

// The dialog function remains the same.
void showSuccessDialogAndNavigate({
  required BuildContext context,
  required String message,
  required String destinationRoute,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 60,
              ),
            ],
          ),
        ),
      );
    },
  );

  Future.delayed(const Duration(seconds: 2), () {
    // Navigator.of(context).pop();
    // GoRouter.of(context).push(destinationRoute);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>ExamSchedulePage ()),
    );

  });
}

class ExamScheduleScreen extends StatefulWidget {
  const ExamScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ExamScheduleScreen> createState() => _ExamScheduleScreenState();
}

class _ExamScheduleScreenState extends State<ExamScheduleScreen> {
  final List<String> subjects = List.generate(7, (_) => 'Math');
  final List<String> rooms = List.generate(7, (_) => 'Room No 1');
  final List<TimeOfDay> timesFrom = List.generate(7, (_) => const TimeOfDay(hour: 8, minute: 0));
  final List<TimeOfDay> timesTo = List.generate(7, (_) => const TimeOfDay(hour: 8, minute: 0));
  final List<DateTime?> examDates = List.generate(7, (_) => null);

  final List<String> exams = ['1st Term', '2nd Term', '3rd Term', '4th Term'];
  final List<String> classes = ['Class VIII', 'Class X', 'Class XI'];

  DateTime? _selectedExamDateFrom;
  DateTime? _selectedExamDateTo;

  // ✅ STEP 1: Add state variables to store dropdown selections.
  String _selectedExam = '1st Term';
  String _selectedClass = 'Class X';

  // --- Date and Time Picker Logic (No changes needed here) ---
  Future<void> _selectDateFrom(BuildContext context) async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: _selectedExamDateFrom ?? DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2101));
    if (picked != null) setState(() => _selectedExamDateFrom = picked);
  }

  Future<void> _selectDateTo(BuildContext context) async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: _selectedExamDateTo ?? DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2101));
    if (picked != null) setState(() => _selectedExamDateTo = picked);
  }

  Future<void> _selectSubjectDate(BuildContext context, int index) async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: examDates[index] ?? DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2101));
    if (picked != null) setState(() => examDates[index] = picked);
  }

  Future<void> _selectTimeFrom(int index) async {
    final TimeOfDay? picked = await showTimePicker(context: context, initialTime: timesFrom[index]);
    if (picked != null) setState(() => timesFrom[index] = picked);
  }

  Future<void> _selectTimeTo(int index) async {
    final TimeOfDay? picked = await showTimePicker(context: context, initialTime: timesTo[index]);
    if (picked != null) setState(() => timesTo[index] = picked);
  }
  // --- End of Picker Logic ---

  Widget _buildDropdown(String value, List<String> items, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(
          horizontal: ScreenUtilHelper.width(10),
          vertical: ScreenUtilHelper.height(10),
        ),
      ),
      style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14), color: AppColors.black),
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, overflow: TextOverflow.ellipsis,))).toList(),
      onChanged: onChanged,
      isExpanded: true,
    );
  }

  Widget _buildTimePicker(TimeOfDay time, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.width(10),
            vertical: ScreenUtilHelper.height(14),
          ),
        ),
        child: Text(
          time.format(context),
          style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14)),
        ),
      ),
    );
  }

  Widget _buildDateCell(DateTime? date, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: ScreenUtilHelper.height(50),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.ash),
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(4)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today_outlined, size: ScreenUtilHelper.scaleAll(20)),
            SizedBox(width: ScreenUtilHelper.width(6)),
            Flexible(
              child: Text(
                date != null ? DateFormat('dd/MM/yyyy').format(date) : 'Select',
                style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14)),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Row(
      children: [
        _headerCell('Date'),
        SizedBox(width: ScreenUtilHelper.width(8)),
        _headerCell('Subject'),
        SizedBox(width: ScreenUtilHelper.width(8)),
        _headerCell('Room'),
      ],
    );
  }

  Widget _headerCell(String title) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(12)),
        decoration: BoxDecoration(
          color: AppColors.bluishLightBackgroundshilu,
          border: Border.all(color: AppColors.black),
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(4)),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: ScreenUtilHelper.fontSize(16),
            color: AppColors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    return date != null ? DateFormat('dd/MM/yyyy').format(date) : 'Select';
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // ✅ STEP 2: Update the dropdowns to use the state variables.
                  Expanded(
                    child: _buildDropdown(_selectedExam, exams, (newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedExam = newValue;
                        });
                      }
                    }),
                  ),
                  SizedBox(width: ScreenUtilHelper.width(16)),
                  Expanded(
                    child: _buildDropdown(_selectedClass, classes, (newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedClass = newValue;
                        });
                      }
                    }),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtilHelper.height(16)),
              Text('Exam Dates', style: TextStyle(fontWeight: FontWeight.bold, fontSize: ScreenUtilHelper.fontSize(16))),
              SizedBox(height: ScreenUtilHelper.height(8)),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDateFrom(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(12), vertical: ScreenUtilHelper.height(16)),
                        decoration: BoxDecoration(border: Border.all(color: AppColors.ash), borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(4))),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today_outlined, size: ScreenUtilHelper.scaleAll(20)),
                            SizedBox(width: ScreenUtilHelper.width(8)),
                            Flexible(child: Text(_formatDate(_selectedExamDateFrom), style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14)), overflow: TextOverflow.ellipsis)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: ScreenUtilHelper.width(16)),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDateTo(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(12), vertical: ScreenUtilHelper.height(16)),
                        decoration: BoxDecoration(border: Border.all(color: AppColors.ash), borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(4))),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today_outlined, size: ScreenUtilHelper.scaleAll(20)),
                            SizedBox(width: ScreenUtilHelper.width(8)),
                            Flexible(child: Text(_formatDate(_selectedExamDateTo), style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14)), overflow: TextOverflow.ellipsis)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtilHelper.height(16)),
              _buildTableHeader(),
              SizedBox(height: ScreenUtilHelper.height(8)),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: ScreenUtilHelper.height(12)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: _buildDateCell(examDates[index], () => _selectSubjectDate(context, index)),
                            ),
                            SizedBox(width: ScreenUtilHelper.width(8)),
                            Expanded(
                                flex: 4,
                                child: _buildDropdown(subjects[index], ['Math'], (val) {})),
                            SizedBox(width: ScreenUtilHelper.width(8)),
                            Expanded(
                                flex: 3,
                                child: _buildDropdown(rooms[index], ['Room No 1'], (val) {})),
                          ],
                        ),
                        SizedBox(height: ScreenUtilHelper.height(8)),
                        Row(
                          children: [
                            Expanded(flex: 3, child: Text("Select Time", style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14)))),
                            SizedBox(width: ScreenUtilHelper.width(8)),
                            Expanded(flex: 4, child: _buildTimePicker(timesFrom[index], () => _selectTimeFrom(index))),
                            SizedBox(width: ScreenUtilHelper.width(8)),
                            Expanded(flex: 3, child: _buildTimePicker(timesTo[index], () => _selectTimeTo(index))),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: ScreenUtilHelper.height(16)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: ScreenUtilHelper.width(120),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        foregroundColor: AppColors.tertiary,
                        side: const BorderSide(color: AppColors.tertiary),
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      ),
                      child: Text('Cancel', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14))),
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtilHelper.width(120),
                    child: ElevatedButton(
                      onPressed: () {
                        // ✅ STEP 3: Create the dynamic message using state variables.
                        final String successMessage = '$_selectedClass $_selectedExam Exam is Scheduled';

                        showSuccessDialogAndNavigate(
                          context: context,
                          message: successMessage,
                          destinationRoute: '/view-exam-schedule', // Change this to your actual route
                        );
                      },
                      style: ElevatedButton.styleFrom(

                        backgroundColor: AppColors.primaryDarkest,
                        foregroundColor: AppColors.white,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      ),
                      child: Text('Save', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14))),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}