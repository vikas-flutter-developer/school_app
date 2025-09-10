import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../message_management/widgets/schedule_tab_widget.dart';
import '../bloc/mail_bloc.dart';
import '../../../../core/utils/screen_util_helper.dart'; // Add this import

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the screen util helper
    ScreenUtilHelper.init(context);

    return BlocProvider(
      create: (context) => MailBloc(), // Provide MailBloc here
      child: Scaffold(
        // Apply padding and scaling for responsiveness
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.width(16),  // Scaled horizontal padding
            vertical: ScreenUtilHelper.height(16),  // Scaled vertical padding
          ),
          child: const ScheduleTabWidget(),  // The widget inside the body
        ),
      ),
    );
  }
}
