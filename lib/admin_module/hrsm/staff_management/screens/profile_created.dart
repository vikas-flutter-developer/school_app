import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../../widgets/Custom_logo_appbar.dart';



class ProfileCompleteScreen extends StatelessWidget {
  const ProfileCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomLogoAppBar(
        onBackPressed: () {

          if (context.canPop()) {
            context.pop();
          }
        },
        notificationCount: 1,
      ),
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Aap yahan apni "Profile Complete" wali image daal sakte hain
            Container(
              child: Center(
                child: Image.asset(
                  'assets/images/approved.png', // <-- Replace with your actual asset path
                  width: ScreenUtilHelper.scaleAll(100), // ScreenUtilHelper
                  height: ScreenUtilHelper.scaleAll(100), // ScreenUtilHelper // ScreenUtilHelper
                  fit: BoxFit.contain,
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
            const SizedBox(height: 100),
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
