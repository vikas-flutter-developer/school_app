import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_styles.dart';
import '../../core/utils/screen_util_helper.dart';
import 'custom/chapterDropdown.dart'; // Make sure this path is correct

class MathematicsDetails extends StatelessWidget {
  const MathematicsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context); // ✅ Initialize ScreenUtil globally if not already done

    // return Scaffold(
    //   appBar: AppBar(
    //     leadingWidth: ScreenUtilHelper.scaleWidth(110),
    //     leading: Row(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         IconButton(
    //           icon: Icon(Icons.arrow_back_ios, size: ScreenUtilHelper.scaleWidth(20)),
    //           onPressed: () {
    //             GoRouter.of(context).pop();
    //           },
    //         ),
    //         Image.asset(
    //           'assets/images/edudibon_logo.png',
    //           height: ScreenUtilHelper.scaleHeight(24),
    //           width: ScreenUtilHelper.scaleWidth(24),
    //         ),
    //       ],
    //     ),
    //     title: Text(
    //       'Syllabus List',
    //       style: TextStyle(
    //         fontSize: ScreenUtilHelper.scaleText(18),
    //       ),
    //     ),
    //     actions: [
    //       IconButton(
    //         icon: Icon(
    //           Icons.notifications,
    //           size: ScreenUtilHelper.scaleWidth(22),
    //         ),
    //         onPressed: () {
    //           // Handle notification icon tap
    //         },
    //       ),
    //     ],
    //   ),
    //   body: Center(
    //     child: Text(
    //       'Mathematics Details Page',
    //       style: TextStyle(
    //         fontSize: ScreenUtilHelper.scaleText(16),
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        titleSpacing: 0,
        title: Row(
          children: [
            SizedBox(
              height: ScreenUtilHelper.scaleHeight(50),
              width: ScreenUtilHelper.scaleWidth(120),
              child: Padding(
                padding: EdgeInsets.only(
                  left: ScreenUtilHelper.scaleWidth(20),
                ),
                child: Image.asset(
                  'assets/images/edudibon.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Notification tap logic
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(8)),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                  ),
                  SizedBox(width: ScreenUtilHelper.scaleWidth(8)),
                  Text(
                    'Chemical Bond List',
                    style: AppStyles.heading.copyWith(
                      fontSize: ScreenUtilHelper.scaleText(18),
                    ),
                  ),
                ],
              ),
            ),

            // Responsive dropdowns
            ChapterDropdown(
              chapters: ['1.1', '1.2', '1.3', '1.4', '1.5', '1.6'],
              chapterTitle: 'Chapter 1',

            ),
            ChapterDropdown(
              chapters: ['2.1', '2.2', '2.3', '2.4', '2.5', '2.6'],
              chapterTitle: 'Chapter 2',
            ),
            ChapterDropdown(
              chapters: ['3.1', '3.2', '3.3', '3.4', '3.5', '3.6'],
              chapterTitle: 'Chapter 3',
            ),
            ChapterDropdown(
              chapters: ['4.1', '4.2', '4.3', '4.4', '4.5', '4.6'],
              chapterTitle: 'Chapter 4',
            ),
            ChapterDropdown(
              chapters: ['5.1', '5.2', '5.3', '5.4', '5.5', '5.6'],
              chapterTitle: 'Chapter 5',
            ),
            ChapterDropdown(
              chapters: ['6.1', '6.2', '6.3', '6.4', '6.5', '6.6'],
              chapterTitle: 'Chapter 6',
            ),

            SizedBox(height: ScreenUtilHelper.scaleHeight(50)),

            Center(
              child: Text(
                'Mathematics Details Page',
                style: TextStyle(
                  fontSize: ScreenUtilHelper.scaleText(16),
                  fontWeight: AppStyles.weight.medium,
                ),
              ),
            ),

            SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
          ],
        ),
      ),
    );
  }
}
