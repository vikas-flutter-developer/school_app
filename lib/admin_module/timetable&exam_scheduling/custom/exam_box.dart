// Your updated select_exam_dropdown.dart file

import 'package:flutter/material.dart';

// ✅ STEP 1: Import the necessary helpers
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart';

class SelectExamDropdown extends StatelessWidget {
  final String label;
  final String value;
  final void Function(String?)? onChanged;

  const SelectExamDropdown({
    Key? key,
    required this.label,
    required this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ✅ Initialize the helper
    //ScreenUtilHelper.init(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Text(
            label,
            // ✅ Use helper for font size
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtilHelper.fontSize(14),
            ),
          ),
        SizedBox(height: ScreenUtilHelper.height(8)),
        Container(
          // ✅ Use helper for padding and radius
          padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(12)),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.blackHint),
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(4)),
            color: AppColors.white,
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: const SizedBox(),
            icon: Icon(Icons.keyboard_arrow_down, size: ScreenUtilHelper.scaleAll(24)),
            // ✅ Define style for dropdown items
            style: TextStyle(
                color: Colors.black, // Set your desired text color
                fontSize: ScreenUtilHelper.fontSize(14)
            ),
            items: [
              DropdownMenuItem(
                value: value,
                child: Text(value),
              ),
            ],
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}