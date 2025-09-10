import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_util_helper.dart';

class MessageMainScreenAppBar extends StatelessWidget {
  final String title;
  const MessageMainScreenAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Container(
      width: ScreenUtilHelper.width(378),
      height: ScreenUtilHelper.height(40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(4)),
        color: AppColors.accentLight,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // --- FIX START ---
          // Replaced IconButton with GestureDetector for more reliable tap detection
          GestureDetector(
            onTap: () => GoRouter.of(context).pop(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(12)), // Added padding to create a larger tap area
              child: const Icon(Icons.arrow_back_ios_new),
            ),
          ),
          // --- FIX END ---
          Text(
            title,
            style: TextStyle(
              fontSize: ScreenUtilHelper.fontSize(16),
              fontWeight: AppStyles.weight.emphasis,
              color: AppColors.graphite,
            ),
          ),
        ],
      ),
    );
  }
}