import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_decorations.dart';
import '../../core/utils/app_styles.dart';
import '../../core/utils/screen_util_helper.dart';
import '../../routes/app_routes.dart';
import 'notification_screen.dart';

class StudentFeedScreen extends StatelessWidget {
  const StudentFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {

    List<Map<String, dynamic>> feedItems = [
      {
        "title": "Holiday Notice",
        "description": "The school will remain closed on March 14, 2025, for Holi celebration. Enjoy your break!",
        "icon": Icons.event,
      },
      {
        "title": "Attendance",
        "description": "Naveen Naveen is marked as present on Feb 25, 2025",
        "icon": Icons.check_circle,
      },
      {
        "title": "Assignments & Homework",
        "description": "Mathematics: Solve Trigonometry Worksheet - Due: March 18, 2025",
        "icon": Icons.assignment,
      },
      {
        "title": "Timetable",
        "description": "Today's Math class is scheduled at 9:00 AM.",
        "icon": Icons.schedule,
      },
      {
        "title": "Assignments Alert",
        "description": "Submit science project by Friday, March 24, 2025",
        "icon": Icons.warning,
      },
      {
        "title": "Fees & Payments",
        "description": "Your next due payment of ₹5,000 is due by March 30, 2025",
        "icon": Icons.payment,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔝 Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/edudibon.png',
                    width: ScreenUtilHelper.scaleWidth(100),
                    height: ScreenUtilHelper.scaleHeight(50),
                  ),
                  Stack(
                    children: [
                      InkWell(
                        onTap: () =>context.go(AppRoutes.studentFeed),
                        child: Image.asset(
                          'assets/images/notification.png',
                          width: ScreenUtilHelper.scaleWidth(30),
                          height: ScreenUtilHelper.scaleWidth(30),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: ScreenUtilHelper.scaleHeight(20)),

              /// 🔍 Search Bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(10)),
                decoration: BoxDecoration(
                  color: AppColors.parchment,
                  borderRadius: AppDecorations.normalRadius,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: AppColors.ash),
                    SizedBox(width: ScreenUtilHelper.scaleWidth(10)),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: ScreenUtilHelper.scaleText(14)),
                      ),
                    ),
                    const Icon(Icons.mic, color: AppColors.ash),
                  ],
                ),
              ),

              SizedBox(height: ScreenUtilHelper.scaleHeight(15)),

              /// 📅 Date & Name
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's Date: March 30, 2025",
                        style: TextStyle(
                          fontSize: ScreenUtilHelper.scaleText(AppStyles.size.bodySmall),
                          color: AppColors.ash,
                        ),
                      ),
                      SizedBox(height: ScreenUtilHelper.scaleHeight(5)),
                      Text(
                        "Hello, NAVEEN NAVEEN",
                        style: AppStyles.display.copyWith(
                          fontSize: ScreenUtilHelper.scaleText(18),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Class: 10 C",
                    style: TextStyle(
                      fontSize: ScreenUtilHelper.scaleText(AppStyles.size.body),
                      fontWeight: AppStyles.weight.emphasis,
                      color: AppColors.blackMediumEmphasis,
                    ),
                  ),
                ],
              ),

              SizedBox(height: ScreenUtilHelper.scaleHeight(20)),

              /// 📰 Feed Items
              Column(
                children: feedItems.map((item) {
                  return Container(
                    width: double.infinity,
                    height: ScreenUtilHelper.scaleHeight(100),
                    margin: EdgeInsets.only(bottom: ScreenUtilHelper.scaleHeight(12)),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLighter,
                      borderRadius: AppDecorations.normalRadius,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowDefault,
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.scaleWidth(16),
                        vertical: ScreenUtilHelper.scaleHeight(8),
                      ),
                      leading: Icon(item["icon"], color: AppColors.tertiary, size: ScreenUtilHelper.scaleWidth(30)),
                      title: Text(
                        item["title"],
                        style: AppStyles.bodyEmphasis.copyWith(
                          fontSize: ScreenUtilHelper.scaleText(14),
                        ),
                      ),
                      subtitle: Text(
                        item["description"],
                        style: TextStyle(fontSize: ScreenUtilHelper.scaleText(12)),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
