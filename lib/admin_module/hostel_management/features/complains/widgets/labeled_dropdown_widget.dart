import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/screen_util_helper.dart';

class LabeledDropdownWidget extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const LabeledDropdownWidget({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:AppStyles.bodySmall.copyWith(color: AppColors.slate),
        ),
        SizedBox(height: ScreenUtilHelper.height(8)),
        DropdownButtonFormField<String>(
          value: value,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: AppStyles.body.copyWith(color: AppColors.blackHighEmphasis),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
              borderSide:  BorderSide(color: AppColors.cloud),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
              borderSide:  BorderSide(color: AppColors.cloud),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
              borderSide: const BorderSide(
                color: AppColors.secondaryContrast,
              ),
            ),
            filled: true,
            fillColor: AppColors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: ScreenUtilHelper.width(12),
              vertical: ScreenUtilHelper.height(14),
            ),
          ),
          icon: const Icon(Icons.keyboard_arrow_down,
              color: AppColors.blackMediumEmphasis),
          isExpanded: true,
        ),
      ],
    );
  }
}