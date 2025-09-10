import 'package:flutter/material.dart';
import '../../../../core/utils/screen_util_helper.dart'; // Import ScreenUtilHelper
import '../../mail_management/widgets/schedule_tab_widget.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtilHelper
    ScreenUtilHelper.init(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtilHelper.width(16), // Adjust horizontal padding
        ),
        child: const ScheduleTabWidget(),
      ),
    );
  }
}
