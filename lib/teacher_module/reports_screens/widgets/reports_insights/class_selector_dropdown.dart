// lib/presentation/widgets/reports_insights/class_selector_dropdown.dart
import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_util_helper.dart'; // Import for scaling

class ClassSelectorDropdown extends StatelessWidget {
  final String selectedClass;
  final List<String> availableClasses;
  final ValueChanged<String?> onChanged;

  const ClassSelectorDropdown({
    super.key,
    required this.selectedClass,
    required this.availableClasses,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    final String? currentSelection =
    availableClasses.contains(selectedClass) ? selectedClass : null;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.scaleWidth(12),
        vertical: ScreenUtilHelper.scaleHeight(4),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(8)),
        border: Border.all(color: AppColors.cloud),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentSelection,
          isExpanded: true,
          icon: Icon(
            Icons.arrow_drop_down,
            color: AppColors.blackMediumEmphasis,
            size: ScreenUtilHelper.scaleWidth(20),
          ),
          items: availableClasses.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: AppStyles.mediumPrimary.copyWith(
                  fontSize: ScreenUtilHelper.scaleText(14),
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          hint: Text(
            "Select Class",
            style: AppStyles.selectClass.copyWith(
              fontSize: ScreenUtilHelper.scaleText(14),
            ),
          ),
        ),
      ),
    );
  }
}
