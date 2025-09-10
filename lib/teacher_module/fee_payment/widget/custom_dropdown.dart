import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart'; //  Added ScreenUtilHelper

class CustomDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? hintText; // Optional hint text

  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.scaleWidth(12.0), //  Responsive horizontal padding
        vertical: ScreenUtilHelper.scaleHeight(4.0), //  Responsive vertical padding
      ),
      decoration: BoxDecoration(
        color: AppColors.white, // Background color of the dropdown container
        border: Border.all(color: AppColors.cloud),
        borderRadius: BorderRadius.circular(
          ScreenUtilHelper.scaleWidth(8.0), //  Responsive border radius
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true, // Make dropdown take available width
          icon: Icon(
            Icons.arrow_drop_down,
            color: AppColors.ash,
            size: ScreenUtilHelper.scaleWidth(24.0), //  Responsive icon size
          ),
          hint: hintText != null
              ? Text(
            hintText!,
            style: TextStyle(
              color: AppColors.primaryBright,
              fontSize: ScreenUtilHelper.scaleText(AppStyles.size.body), //  Responsive font size
            ),
          )
              : null,
          items: items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  fontSize: ScreenUtilHelper.scaleText(AppStyles.size.bodySmall), //  Responsive font size
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          dropdownColor: AppColors.white, // Background color of the dropdown list
          style: TextStyle(
            color: AppColors.blackHighEmphasis,
            fontSize: ScreenUtilHelper.scaleText(AppStyles.size.body), //  Responsive font size
          ), // Text style for selected item
        ),
      ),
    );
  }
}
