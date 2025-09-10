// filename: exam_schedule_page.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart';


class ExamSchedulePage extends StatelessWidget {
  const ExamSchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    // Dummy data to display since there's no editor now.
    final Map<String, dynamic> mockExamData = {
      'class': 'Class X',
      'examTerm': '1st Term',
      'dateFrom': DateTime(2025, 1, 1),
      'dateTo': DateTime(2025, 1, 8),
      'schedule': List.generate(
          8,
              (i) => {
            'date': DateTime(2025, 1, i + 1),
            'subject': 'Math',
            'room': 'Room No 1',
            'timeFrom': const TimeOfDay(hour: 8, minute: 0),
            'timeTo': const TimeOfDay(hour: 9, minute: 0),
          }),
    };

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(context),
              SizedBox(height: ScreenUtilHelper.height(5)),
              _buildHeader(context), // Pass context to the header
              SizedBox(height: ScreenUtilHelper.height(24)),
              Expanded(
                child: ViewExamDetailsScreen(examData: mockExamData),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Header: Logo and Bell Icon
  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'assets/images/edudibon.png', // Make sure this path is correct
          height: ScreenUtilHelper.height(50),
          width: ScreenUtilHelper.width(115),
          fit: BoxFit.contain,
        ),
        IconButton(
          icon: const Icon(CupertinoIcons.bell),
          onPressed: () {
            // Add notification functionality here
          },
        ),
      ],
    );
  }

  // Header: Back Button and Title
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          // ✅ Changed GoRouter.pop() to Navigator.pop() as requested
          onTap: () => Navigator.of(context).pop(),
          child: Icon(Icons.arrow_back_ios_new,
              size: ScreenUtilHelper.scaleAll(20)),
        ),
        SizedBox(width: ScreenUtilHelper.width(8)),
        Flexible(
          child: Text(
            'Exam Management',
            style: TextStyle(
              fontSize: ScreenUtilHelper.fontSize(20),
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// ==========================================================
//   VIEWER WIDGET - Shows the details (from your screenshot)
// ==========================================================

class ViewExamDetailsScreen extends StatelessWidget {
  final Map<String, dynamic>? examData;
  const ViewExamDetailsScreen({super.key, this.examData});

  @override
  Widget build(BuildContext context) {
    if (examData == null) {
      return const Center(
        child: Text('No exam data available.',
            style: TextStyle(fontSize: 16, color: Colors.grey)),
      );
    }

    // Extract data from the map
    final String selectedClass = examData!['class'];
    final String selectedTerm = examData!['examTerm'];
    final DateTime dateFrom = examData!['dateFrom'];
    final DateTime dateTo = examData!['dateTo'];
    final List<Map<String, dynamic>> schedule = examData!['schedule'];

    return Column(
      children: [
        // Top dropdowns (for display purposes)
        Row(
          children: [
            Expanded(
              child: AbsorbPointer(
                child: DropdownButtonFormField<String>(
                  value: selectedClass,
                  items: [selectedClass]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) {},
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AbsorbPointer(
                child: DropdownButtonFormField<String>(
                  value: selectedTerm,
                  items: [selectedTerm]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) {},
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Timetable Title
        Text('$selectedTerm Exam Timetable',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(
            '${DateFormat('d-MMM yyyy').format(dateFrom)} To ${DateFormat('d-MMM yyyy').format(dateTo)}',
            style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 16),

        // The main timetable table
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                _buildTableHeader(),
                Expanded(
                  child: ListView.builder(
                    itemCount: schedule.length,
                    itemBuilder: (context, index) {
                      return _buildTableRow(context, schedule[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Download Button
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.download_outlined),
          label: const Text('Download'),
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: AppColors.primaryDark,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
        )
      ],
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.bluishLightBackgroundshilu.withOpacity(0.4),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      ),
      child: const Row(
        children: [
          Expanded(child: Center(child: Text('Date', style: TextStyle(fontWeight: FontWeight.bold)))),
          Expanded(child: Center(child: Text('Time', style: TextStyle(fontWeight: FontWeight.bold)))),
          Expanded(child: Center(child: Text('Subject', style: TextStyle(fontWeight: FontWeight.bold)))),
          Expanded(child: Center(child: Text('Room', style: TextStyle(fontWeight: FontWeight.bold)))),
        ],
      ),
    );
  }

  Widget _buildTableRow(BuildContext context, Map<String, dynamic> data) {
    final DateTime? date = data['date'];
    final TimeOfDay timeFrom = data['timeFrom'];
    final TimeOfDay timeTo = data['timeTo'];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade300))),
      child: Row(
        children: [
          Expanded(
              child: Center(
                  child: Text(
                      date != null ? DateFormat('d MMM yyyy').format(date) : '-'))),
          Expanded(
              child: Center(
                  child: Text(
                      '${timeFrom.format(context)} to ${timeTo.format(context)}',
                      textAlign: TextAlign.center))),
          Expanded(child: Center(child: Text(data['subject'] ?? '-'))),
          Expanded(child: Center(child: Text(data['room'] ?? '-'))),
        ],
      ),
    );
  }
}