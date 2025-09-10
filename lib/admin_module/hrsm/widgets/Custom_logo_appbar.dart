import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart';
import 'package:go_router/go_router.dart'; // ✅ Import the helper

class CustomLogoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBackPressed;
  final int notificationCount;

  const CustomLogoAppBar({
    Key? key,
    this.onBackPressed,
    this.notificationCount = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtilHelper.width(12),
          vertical: ScreenUtilHelper.height(10),
        ),
        color: AppColors.white,
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: ScreenUtilHelper.scaleAll(22),
              ),
              onPressed: onBackPressed ?? () => GoRouter.of(context).pop(),
            ),
            SizedBox(width: ScreenUtilHelper.width(6)),
            Image.asset(
              'assets/images/edudibon_logo.png',
              height: ScreenUtilHelper.height(39),
              width: ScreenUtilHelper.width(159),
              fit: BoxFit.contain,
            ),
            const Spacer(),
            Stack(
              children: [
                Icon(Icons.notifications_outlined,color: AppColors.black,size: ScreenUtilHelper.scaleAll(32),),
                if (notificationCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: ScreenUtilHelper.scaleAll(14),
                      height: ScreenUtilHelper.scaleAll(14),
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          notificationCount.toString(),
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: ScreenUtilHelper.fontSize(9),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + ScreenUtilHelper.height(20));
}
