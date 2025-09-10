// lib/presentation/screens/widgets/error_message.dart
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/screen_util_helper.dart'; // added import

class ErrorMessage extends StatelessWidget {
  final String message;
  const ErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context); // ensure screen scaling is initialized

    return Center(
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)), // responsive padding
        child: Text(
          message,
          style: AppStyles.errorMessage.copyWith(
            fontSize: ScreenUtilHelper.scaleText(14), // responsive font size
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
