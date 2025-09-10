// lib/presentation/widgets/exam_overview/exam_plan_list.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../../data/models/exam_schedule.dart';

class ExamTimetableList extends StatelessWidget {
  final List<ExamPlanItem> items;
  final bool isLoading;

  const ExamTimetableList({
    super.key,
    required this.items,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context); // initialize ScreenUtilHelper

    if (isLoading && items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (items.isEmpty) {
      return const Center(
        child: Text("No exam plan found for the selected criteria."),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _ExamPlanCard(item: item);
      },
    );
  }
}

class _ExamPlanCard extends StatelessWidget {
  final ExamPlanItem item;

  const _ExamPlanCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('d MMMM'); // e.g., 10 March
    final DateFormat timeFormat = DateFormat('hh:mm a'); // e.g., 09:00 AM

    return Card(
      margin: EdgeInsets.only(bottom: ScreenUtilHelper.height(12.0)),
      color: item.color.withOpacity(0.9), // Color from model (already dynamic)
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
      ),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
        child: Row(
          children: [
            // Icon box
            Container(
              padding: EdgeInsets.all(ScreenUtilHelper.width(12.0)),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
              ),
              child: Icon(
                Icons.menu_book,
                size: ScreenUtilHelper.width(24),
                color: AppColors.blackMediumEmphasis,
              ),
            ),
            SizedBox(width: ScreenUtilHelper.width(16)),
            // Subject and Type
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.subject,
                    style: AppStyles.heading16Bold,
                  ),
                  SizedBox(height: ScreenUtilHelper.height(4)),
                  Text(
                    item.type,
                    style: AppStyles.body14Grey,
                  ),
                ],
              ),
            ),
            // Date & Time
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.width(12.0),
                vertical: ScreenUtilHelper.height(8.0),
              ),
              decoration: BoxDecoration(
                color: AppColors.withOpacity(Colors.black, 0.15),
                borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(6.0)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    dateFormat.format(item.date),
                    style: TextStyle(
                      fontSize: ScreenUtilHelper.fontSize(14),
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: ScreenUtilHelper.height(2)),
                  Text(
                    timeFormat.format(
                      DateTime(
                        item.date.year,
                        item.date.month,
                        item.date.day,
                        item.time.hour,
                        item.time.minute,
                      ),
                    ),
                    style: AppStyles.bodySmall1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
