import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';

class NotificationIcon extends StatelessWidget {
  final int count;
  final VoidCallback onPressed;

  const NotificationIcon({
    super.key,
    required this.count,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.notifications_none,
            size: ScreenUtilHelper.scaleWidth(24), // Optional: scale icon size
          ),
          onPressed: onPressed,
        ),
        if (count > 0)
          Positioned(
            right: ScreenUtilHelper.scaleWidth(8),
            top: ScreenUtilHelper.scaleHeight(8),
            child: Container(
              padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(2)),
              decoration: BoxDecoration(
                color: AppColors.error,
                borderRadius: BorderRadius.circular(
                  ScreenUtilHelper.scaleWidth(10),
                ),
              ),
              constraints: BoxConstraints(
                minWidth: ScreenUtilHelper.scaleWidth(16),
                minHeight: ScreenUtilHelper.scaleHeight(16),
              ),
              child: Center(
                child: Text(
                  '$count',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: ScreenUtilHelper.scaleText(AppStyles.size.tiny),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
