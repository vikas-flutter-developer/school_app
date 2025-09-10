// lib/presentation/widgets/exam_overview/exam_timetable_list.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_util_helper.dart'; //  Added for responsiveness
import '../../data/models/exam_schedule.dart';

class ExamPlanList extends StatelessWidget {
  final List<ExamTimetableItem> items;
  final bool isLoading;

  const ExamPlanList({super.key, required this.items, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context); //  Initialize scaling

    if (isLoading && items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (items.isEmpty) {
      return const Center(
        child: Text("No timetable found for the selected criteria."),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16.0)), //  responsive padding
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _ExamTimetableCard(item: item);
      },
    );
  }
}

class _ExamTimetableCard extends StatelessWidget {
  final ExamTimetableItem item;

  const _ExamTimetableCard({required this.item});

  // Map status to AppColors.
  Map<String, dynamic> _getStatusStyle(ExamStatus status) {
    switch (status) {
      case ExamStatus.Completed:
        return {
          'color': AppColors.successLight,
          'textColor': AppColors.successDark,
          'text': 'Completed',
        };
      case ExamStatus.Ongoing:
        return {
          'color': AppColors.tertiaryLighter,
          'textColor': AppColors.primaryDarker,
          'text': 'Ongoing',
        };
      case ExamStatus.Postponed:
        return {
          'color': AppColors.inventoryIconBg,
          'textColor': AppColors.pending,
          'text': 'Postponed',
        };
      case ExamStatus.Upcoming:
        return {
          'color': AppColors.cloud,
          'textColor': AppColors.graphite,
          'text': 'Upcoming',
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context); // initialize scaling
    final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    final TimeOfDay startTime = item.startTime;
    final TimeOfDay endTime = item.endTime;
    final statusStyle = _getStatusStyle(item.status);
    final String timeRange = "${startTime.format(context)} - ${endTime.format(context)}";

    return Card(
      margin: EdgeInsets.only(bottom: ScreenUtilHelper.scaleHeight(12.0)), //  responsive margin
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: statusStyle['color']!,
          width: ScreenUtilHelper.scaleWidth(1.5), //  responsive border
        ),
        borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(8.0)), //  responsive radius
      ),
      elevation: 1.5,
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(12.0)), //  responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subject & Date Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "${item.subject} | ${item.term}",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: ScreenUtilHelper.scaleText(14), //  responsive icon
                      color: AppColors.stone,
                    ),
                    SizedBox(width: ScreenUtilHelper.scaleWidth(4)), //  responsive spacing
                    Text(
                      dateFormat.format(item.dateTime),
                      style: AppStyles.dateText,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(8)), // ✅ responsive spacing
            Text(
              timeRange,
              style: AppStyles.timeRange,
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(8)), // spacing
            const Divider(),
            SizedBox(height: ScreenUtilHelper.scaleHeight(8)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Teacher & Room
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Teacher Allocated: ${item.teacher}",
                      style: AppStyles.teacherAllocated,
                    ),
                    SizedBox(height: ScreenUtilHelper.scaleHeight(2)),
                    Text(
                      "Room No: ${item.roomNo}",
                      style: AppStyles.roomNumber,
                    ),
                  ],
                ),
                // Status Chip
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilHelper.scaleWidth(10.0),
                    vertical: ScreenUtilHelper.scaleHeight(4.0),
                  ),
                  decoration: BoxDecoration(
                    color: statusStyle['color']!,
                    borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(12.0)),
                  ),
                  child: Text(
                    statusStyle['text']!,
                    style: AppStyles.labelMediumWithColor(statusStyle['textColor']!),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
