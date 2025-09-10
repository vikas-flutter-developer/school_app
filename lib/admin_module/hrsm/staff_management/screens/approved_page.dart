import 'package:flutter/material.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/Custom_logo_appbar.dart'; // Ensure this import path is correct

class ApprovedPage extends StatelessWidget {
  const ApprovedPage({super.key});

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
              'Approved',
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
        unselectedItemColor: AppColors.ash,
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
