import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: ScreenUtilHelper.scaleWidth(153),
              height: ScreenUtilHelper.scaleHeight(39),
              margin: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.scaleWidth(8),
              ),
              child: Image.asset(
                'assets/images/edudibon.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
      actions: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () {
                // Handle notification icon tap
              },
            ),
            Positioned(
              right: ScreenUtilHelper.scaleWidth(15),
              top: ScreenUtilHelper.scaleHeight(0),
              child: Container(
                padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(4)),
                decoration: const BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                ),
                constraints: BoxConstraints(
                  minWidth: ScreenUtilHelper.scaleWidth(16),
                  minHeight: ScreenUtilHelper.scaleHeight(16),
                ),
                child: Center(
                  child: Text(
                    '3',
                    style: AppStyles.whiteFont10.copyWith(
                      fontSize: ScreenUtilHelper.scaleText(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(ScreenUtilHelper.scaleHeight(kToolbarHeight));
}
