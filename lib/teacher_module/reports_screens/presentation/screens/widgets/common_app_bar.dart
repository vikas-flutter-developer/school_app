// lib/presentation/screens/widgets/common_app_bar.dart
import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/screen_util_helper.dart';


class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CommonAppBar({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context); // initialize once per screen if not already

    return AppBar(
      backgroundColor: AppColors.white,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          size: ScreenUtilHelper.scaleWidth(20), // responsive icon size
        ),
        onPressed: () => GoRouter.of(context).pop(), // Basic back action
      ),
      title: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: ScreenUtilHelper.scaleText(18), // responsive text
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications_none,
            size: ScreenUtilHelper.scaleWidth(22), // responsive icon size
          ),
          onPressed: () {
            // Handle notification tap
          },
        ),
        ...?actions, // Add custom actions if provided
      ],
      centerTitle: false, // Titles are usually left-aligned in mockups
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(ScreenUtilHelper.scaleHeight(kToolbarHeight)); // responsive height
}
