import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';

class ProfileSectionCardWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final VoidCallback? onEditPressed;

  const ProfileSectionCardWidget({
    super.key,
    required this.title,
    required this.children,
    this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Container(
      padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(12.0)),
        boxShadow: [
          BoxShadow(
            color: AppColors.ash.withAlpha(25),
            spreadRadius: ScreenUtilHelper.radius(1),
            blurRadius: ScreenUtilHelper.radius(3),
            offset: Offset(0, ScreenUtilHelper.height(2)),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppStyles.headingLarge.copyWith(color: AppColors.black)
              ),
              GestureDetector(
                onTap: onEditPressed,
                child: Icon(
                  Icons.edit_outlined,
                  color: AppColors.ash,
                  size: ScreenUtilHelper.scaleAll(20),
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenUtilHelper.height(12)),
          ...children,
        ],
      ),
    );
  }
}