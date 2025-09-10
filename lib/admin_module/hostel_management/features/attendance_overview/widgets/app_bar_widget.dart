import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';

class CommonBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleText;
  final bool showBackButton;
  final VoidCallback? onNotificationPressed;

  const CommonBar({
    super.key,
    this.titleText,
    this.showBackButton = true,
    this.onNotificationPressed,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return AppBar(
      leading:
          showBackButton
              ? IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.blackMediumEmphasis,
                  size: ScreenUtilHelper.scaleAll(20),
                ),
                onPressed: () => GoRouter.of(context).pop(),
              )
              : null,
      title:
          titleText != null
              ? Text(
                titleText!,
                style: AppStyles.headingRegular.copyWith(color: AppColors.black)
              )
              : SizedBox(
                width: ScreenUtilHelper.width(159),
                height: ScreenUtilHelper.height(39),
                child: Image.asset("assets/images/edudibon.png"),
              ),
      centerTitle: titleText != null ? true : false,
      actions: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            IconButton(
              icon: Icon(
                Icons.notifications_none_outlined,
                color: AppColors.blackMediumEmphasis,
                size: ScreenUtilHelper.scaleAll(28),
              ),
              onPressed: onNotificationPressed ?? () {},
            ),
            Positioned(
              right: ScreenUtilHelper.width(8),
              top: ScreenUtilHelper.height(8),
              child: Container(
                padding: EdgeInsets.all(ScreenUtilHelper.width(2)),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(
                    ScreenUtilHelper.radius(8),
                  ),
                ),
                constraints: BoxConstraints(
                  minWidth: ScreenUtilHelper.width(16),
                  minHeight: ScreenUtilHelper.height(16),
                ),
                child: Text(
                  '3',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: ScreenUtilHelper.fontSize(10),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: ScreenUtilHelper.width(8)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
