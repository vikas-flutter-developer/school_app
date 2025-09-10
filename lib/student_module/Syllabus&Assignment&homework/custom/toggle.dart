import '../../../core/utils/app_decorations.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart'; // ✅ Ensure this is imported

class AssignmentHomeworkToggle extends StatefulWidget {
  final Function(bool isAssignment) onToggleChanged;

  const AssignmentHomeworkToggle({super.key, required this.onToggleChanged});

  @override
  _AssignmentHomeworkToggleState createState() =>
      _AssignmentHomeworkToggleState();
}

class _AssignmentHomeworkToggleState extends State<AssignmentHomeworkToggle> {
  bool _isAssignment = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.scaleWidth(16), // 🔁 Responsive horizontal padding
      ),
      decoration: BoxDecoration(
        color: AppColors.barChartColor1,
        borderRadius: AppDecorations.smallRadius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isAssignment = true;
                widget.onToggleChanged(_isAssignment);
              });
            },
            child: Padding(
              padding: EdgeInsets.only(
                right: ScreenUtilHelper.scaleWidth(20), // 🔁 Responsive right padding
              ),
              child: Text(
                'Assignments',
                style: AppStyles.bodyBold.copyWith(
                  color: _isAssignment ? AppColors.primaryMedium : AppColors.white,
                ),
              ),
            ),
          ),
          Text(
            ' | ',
            style: AppStyles.headingLarge.copyWith(
              color: AppColors.primaryMedium,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _isAssignment = false;
                widget.onToggleChanged(_isAssignment);
              });
            },
            child: Padding(
              padding: EdgeInsets.only(
                left: ScreenUtilHelper.scaleWidth(20), // 🔁 Responsive left padding
              ),
              child: Text(
                'Homework',
                style: AppStyles.bodyBold.copyWith(
                  color: !_isAssignment ? AppColors.primaryMedium : AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
