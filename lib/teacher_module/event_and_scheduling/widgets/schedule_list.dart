import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart';
import '../models/schedule_model.dart';
import 'schedule_card.dart';

class ScheduleList extends StatelessWidget {
  final List<ScheduleModel> schedules;

  const ScheduleList({super.key, required this.schedules});

  @override
  Widget build(BuildContext context) {
    if (schedules.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(20)),
          child: const Text(
            "No schedules found.",
            style: TextStyle(color: AppColors.ash),
          ),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtilHelper.scaleHeight(16),
      ),
      itemCount: schedules.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.scaleWidth(0), // Optional: customize
          ),
          child: ScheduleCard(schedule: schedules[index]),
        );
      },
      separatorBuilder: (context, index) =>
          SizedBox(height: ScreenUtilHelper.scaleHeight(15)),
    );
  }
}
