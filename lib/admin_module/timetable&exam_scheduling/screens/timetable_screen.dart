// Your updated timetable_screen.dart file

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ✅ STEP 1: Import the necessary helpers
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart';
import '../../../routes/app_routes.dart';

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          // ✅ Use helper for padding
          padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Logo & Notification
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/edudibon.png',
                      height: ScreenUtilHelper.height(40)),
                  const Icon(Icons.notifications_none),
                ],
              ),
              SizedBox(height: ScreenUtilHelper.height(24)),

              // Back arrow and heading
              Row(
                children: [
                  GestureDetector(
                    onTap: () => GoRouter.of(context).pop(),
                    child: Icon(CupertinoIcons.back,
                        size: ScreenUtilHelper.scaleAll(24)),
                  ),
                  SizedBox(width: ScreenUtilHelper.width(8)),
                  Text(
                    "Timetable & Scheduling",
                    style: TextStyle(
                      fontSize: ScreenUtilHelper.fontSize(20),
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ],
              ),

              SizedBox(height: ScreenUtilHelper.height(24)),

              // Image Section
              Center(
                  child: Image.asset('assets/images/timetable&scheduling.png',
                      height: ScreenUtilHelper.height(200))),

              SizedBox(height: ScreenUtilHelper.height(32)),

              // Button 1: Timetable Management
              _buildOutlinedButton(
                context,
                label: 'Timetable Management',
                onTap: () => context.push(AppRoutes.adminTimeTableManagement),
              ),
              SizedBox(height: ScreenUtilHelper.height(16)),

              // Button 2: Exam Management
              _buildOutlinedButton(
                context,
                label: 'Exam Management',
                onTap: () => context.push(AppRoutes.examManagement),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOutlinedButton(
      BuildContext context, {
        required String label,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(12)),
      child: Container(
        // ✅ Use helper for padding and radius
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.width(16),
            vertical: ScreenUtilHelper.height(18)),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.blackMediumEmphasis, width: 1),
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(12)),
          color: AppColors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: TextStyle(fontSize: ScreenUtilHelper.fontSize(16))),
            Icon(CupertinoIcons.right_chevron,
                size: ScreenUtilHelper.scaleAll(20)),
          ],
        ),
      ),
    );
  }
}