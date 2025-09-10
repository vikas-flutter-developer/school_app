import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart' show AppStyles;
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart'; // Import ScreenUtilHelper
import 'package:flutter/material.dart';

class PerformanceDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String hint;

  const PerformanceDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtilHelper.width(167),  // ScreenUtilHelper
      height: ScreenUtilHelper.height(44), // ScreenUtilHelper
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.width(12.0), // ScreenUtilHelper
        vertical: ScreenUtilHelper.height(4.0),   // ScreenUtilHelper
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(5.0)), // ScreenUtilHelper
        border: Border.all(
          color: AppColors.primaryContrast,
          width: ScreenUtilHelper.width(1), // ScreenUtilHelper
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: AppColors.blackMediumEmphasis,
          ),
          style: TextStyle(
            color: AppColors.blackHighEmphasis,
            fontSize: ScreenUtilHelper.fontSize(AppStyles.size.bodySmall), // ScreenUtilHelper
            fontWeight: AppStyles.weight.emphasis,
          ),
          dropdownColor: AppColors.white,
          hint: Text(
            hint,
            style: TextStyle(
              color: AppColors.stone,
              fontSize: ScreenUtilHelper.fontSize(AppStyles.size.bodySmall), // ScreenUtilHelper
            ),
          ),
          items: items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  fontSize: ScreenUtilHelper.fontSize(AppStyles.size.bodySmall), // ScreenUtilHelper
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
