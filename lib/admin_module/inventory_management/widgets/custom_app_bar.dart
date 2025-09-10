import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String logoAssetPath;
  final String pageTitle;
  final bool showBackButton;
  final VoidCallback? onAddActionPressed;
  final String addActionText;
  final bool showAddAction;
  final int notificationCount;
  final VoidCallback? onNotificationPressed;
  final List<Widget>? appBarActions;

  const CustomAppBar({
    super.key,
    this.logoAssetPath = 'assets/images/edudibon.png',
    required this.pageTitle,
    this.showBackButton = true,
    this.onAddActionPressed,
    this.addActionText = '+Add Purchase Order',
    this.showAddAction = false,
    this.notificationCount = 0,
    this.onNotificationPressed,
    this.appBarActions,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    final theme = Theme.of(context);
    final double bottomRowHeight = ScreenUtilHelper.height(50);

    return AppBar(
      backgroundColor: AppColors.white,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: false,
      titleSpacing: NavigationToolbar.kMiddleSpacing,
      title: Image.asset(
        logoAssetPath,
        height: ScreenUtilHelper.height(25),
        fit: BoxFit.contain,
      ),
      actions: [
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.notifications_none_outlined,
                color: AppColors.blackHighEmphasis,
                size: ScreenUtilHelper.scaleAll(26),
              ),
              tooltip: 'Notifications',
              onPressed: onNotificationPressed ?? () {},
            ),
            if (notificationCount > 0)
              Positioned(
                right: ScreenUtilHelper.width(8),
                top: ScreenUtilHelper.height(8),
                child: Container(
                  padding: EdgeInsets.all(ScreenUtilHelper.width(1.5)),
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(
                      minWidth: ScreenUtilHelper.scaleAll(16),
                      minHeight: ScreenUtilHelper.scaleAll(16)),
                  child: Center(
                    child: Text(
                      '$notificationCount',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: ScreenUtilHelper.fontSize(9),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
          ],
        ),
        if (appBarActions != null) ...appBarActions!,
        SizedBox(width: ScreenUtilHelper.width(8)),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(bottomRowHeight),
        child: Container(
          height: bottomRowHeight,
          padding:
          EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(12.0)),
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            color: AppColors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    if (showBackButton)
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColors.blackHighEmphasis,
                          size: ScreenUtilHelper.scaleAll(20),
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        tooltip: 'Back',
                        onPressed: () => GoRouter.of(context).pop(),
                      ),
                    if (showBackButton)
                      SizedBox(width: ScreenUtilHelper.width(8)),
                    Flexible(
                      child: Text(
                        pageTitle,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.blackHighEmphasis,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              if (showAddAction && onAddActionPressed != null)
                TextButton.icon(
                  icon: Icon(Icons.add,
                      color: AppColors.secondaryDarker,
                      size: ScreenUtilHelper.scaleAll(20)),
                  label: Text(
                    addActionText,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: AppColors.secondaryDarker,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.width(10),
                        vertical: ScreenUtilHelper.height(6)),
                  ),
                  onPressed: onAddActionPressed,
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + ScreenUtilHelper.height(50));
}