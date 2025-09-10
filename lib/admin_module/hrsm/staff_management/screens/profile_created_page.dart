import 'package:flutter/material.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/Custom_logo_appbar.dart';

class ProfileCreatedPage extends StatelessWidget {
  const ProfileCreatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomLogoAppBar(
        onBackPressed: () => GoRouter.of(context).pop(),
        notificationCount: 3,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Responsive circle container
            Container(
              width: ScreenUtilHelper.scaleAll(100),
              height: ScreenUtilHelper.scaleAll(100),
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.check,
                  color: AppColors.white,
                  size: ScreenUtilHelper.scaleAll(60),
                ),
              ),
            ),
            SizedBox(height: ScreenUtilHelper.height(24)),
            Text(
              'Profile Created',
              style: AppStyles.headingLargeEmphasis.copyWith(
                fontSize: ScreenUtilHelper.fontSize(24), // Optional override
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: AppColors.selected,
        unselectedItemColor: AppColors.iconGray,
        selectedFontSize: ScreenUtilHelper.fontSize(12),
        unselectedFontSize: ScreenUtilHelper.fontSize(12),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            activeIcon: Icon(Icons.article),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'My Account',
          ),
        ],
      ),
    );
  }
}
