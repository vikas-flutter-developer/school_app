import 'package:flutter/material.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart';

class NotificationBadge extends StatelessWidget {
  final int count;

  const NotificationBadge({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox.shrink();

    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: EdgeInsets.only(right: ScreenUtilHelper.scaleWidth(16)),
          child: SizedBox(
            width: ScreenUtilHelper.scaleWidth(38),
            height: ScreenUtilHelper.scaleHeight(42),
            child: IconButton(
              icon: const Icon(
                Icons.notifications_none,
                color: AppColors.primaryMedium,
              ),
              iconSize: ScreenUtilHelper.scaleWidth(30),
              onPressed: () {},
            ),
          ),
        ),
        Positioned(
          right: ScreenUtilHelper.scaleWidth(12),
          top: ScreenUtilHelper.scaleHeight(0),
          child: Container(
            padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(4.0)),
            constraints: BoxConstraints(
              minWidth: ScreenUtilHelper.scaleWidth(16),
              minHeight: ScreenUtilHelper.scaleHeight(16),
            ),
            decoration: const BoxDecoration(
              color: AppColors.error,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$count',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: ScreenUtilHelper.scaleText(AppStyles.size.small),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
