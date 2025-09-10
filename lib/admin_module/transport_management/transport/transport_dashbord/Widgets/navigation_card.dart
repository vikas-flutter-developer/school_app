import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_decorations.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/screen_util_helper.dart';

class NavigationCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onTap;

  const NavigationCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return InkWell(
      onTap: onTap,
      borderRadius: AppDecorations.mediumRadius,
      child: Container(
        height: ScreenUtilHelper.height(117),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: AppDecorations.mediumRadius,
          border: Border.all(
            color: AppColors.silver,
            width: ScreenUtilHelper.scaleAll(1),
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(8.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    imagePath,
                    width: ScreenUtilHelper.width(30),
                    height: ScreenUtilHelper.height(30),
                  ),
                  SizedBox(height: ScreenUtilHelper.height(8)),

                  // FIX: Wrap Text with Flexible to prevent overflow
                  Flexible(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis, // Handles very long text
                      maxLines: 2,
                      style: AppStyles.smallGrey.copyWith(
                        color: AppColors.blackHighEmphasis,
                        fontSize: ScreenUtilHelper.fontSize(14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: ScreenUtilHelper.height(2),
              right: ScreenUtilHelper.width(2),
              child: Container(
                padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(4)),
                decoration: BoxDecoration(
                  color: AppColors.secondaryAccentLight,
                  borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(6)),
                ),
                child: Icon(
                  Icons.open_in_new,
                  color: AppColors.primary,
                  size: ScreenUtilHelper.scaleAll(17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}