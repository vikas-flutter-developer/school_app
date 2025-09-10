// Your updated exam_schedule_page.dart file

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ✅ STEP 1: Import the necessary helpers
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart';
import 'exam_schedule_screen.dart';
import 'view_details_screen.dart';

class ExamSchedulePage extends StatefulWidget {
  const ExamSchedulePage({Key? key}) : super(key: key);

  @override
  State<ExamSchedulePage> createState() => _ExamSchedulePageState();
}

class _ExamSchedulePageState extends State<ExamSchedulePage> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    // ✅ Initialize the helper
    ScreenUtilHelper.init(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(context),
              SizedBox(height: ScreenUtilHelper.height(5)),
              _buildBackButton(), // Contains Fix #2
              SizedBox(height: ScreenUtilHelper.height(24)),
              _buildTabBar(), // Contains Fix #1
              SizedBox(height: ScreenUtilHelper.height(24)),
              Expanded(child: _buildTabContent()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'assets/images/edudibon.png',
          height: ScreenUtilHelper.height(50),
          width: ScreenUtilHelper.width(115),
          fit: BoxFit.contain,
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () {},
        ),
      ],
    );
  }

  // ✅ FIX #2: Wrapped Text with Flexible
  Widget _buildBackButton() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => GoRouter.of(context).pop(),
          child: Icon(Icons.arrow_back_ios_new, size: ScreenUtilHelper.scaleAll(20)),
        ),
        SizedBox(width: ScreenUtilHelper.width(8)),
        Flexible(
          child: Text(
            'Exam Management',
            style: TextStyle(
              fontSize: ScreenUtilHelper.fontSize(20),
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Row(
      children: [
        _buildTabItem(title: 'Exam Schedule', index: 0),
        SizedBox(width: ScreenUtilHelper.width(8)),
        _buildTabItem(title: 'View Exam Details', index: 1),
      ],
    );
  }

  // ✅ FIX #1: Replaced FittedBox with TextOverflow.ellipsis
  Widget _buildTabItem({required String title, required int index}) {
    bool isSelected = _selectedTabIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(12)),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.bluishLightBackgroundshilu : AppColors.white,
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(6)),
            border: Border.all(color: AppColors.tertiaryLight),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: ScreenUtilHelper.fontSize(16),
              fontWeight: FontWeight.w600,
              color: isSelected ? AppColors.black : AppColors.blackMediumEmphasis,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    if (_selectedTabIndex == 0) {
      return const ExamScheduleScreen();
    } else {
      // You should have a different screen here for the second tab
      // For now, it points to the same screen as an example.
      // return const ViewExamDetailsScreen();
      return const ExamScheduleScreen();
    }
  }
}