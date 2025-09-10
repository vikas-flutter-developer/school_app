// Your updated subject_selection_box.dart file

import 'package:flutter/material.dart';

// ✅ STEP 1: Import the necessary helpers
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart';

class SubjectSelectionBox extends StatelessWidget {
  final String subject;
  final void Function(String?)? onChanged;

  const SubjectSelectionBox({
    super.key,
    required this.subject,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Initialize the helper
    //ScreenUtilHelper.init(context);

    return Container(
      // ✅ Use helper for padding and radius
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(12)),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.blackHint),
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(4)),
        color: AppColors.white,
      ),
      child: DropdownButton<String>(
        value: subject,
        isExpanded: true,
        underline: const SizedBox(),
        // ✅ Use helper for icon size
        icon: Icon(Icons.keyboard_arrow_down, size: ScreenUtilHelper.scaleAll(24)),
        // ✅ Define style for dropdown items
        style: TextStyle(
          color: AppColors.black, // Set your desired text color
          fontSize: ScreenUtilHelper.fontSize(14),
        ),
        items: [
          DropdownMenuItem(
            value: subject,
            child: Text(subject),
          ),
        ],
        onChanged: onChanged,
      ),
    );
  }
}