// lib/presentation/screens/reports_insights/reports_insights_screen.dart
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart'; //  added
import '../widgets/common_app_bar.dart';
import 'exam_overview_tab.dart';
import 'results_tab.dart';

class ReportsInsightsScreen extends StatefulWidget {
  const ReportsInsightsScreen({super.key});

  @override
  State<ReportsInsightsScreen> createState() => _ReportsInsightsScreenState();
}

class _ReportsInsightsScreenState extends State<ReportsInsightsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      // Optional tab switch logic
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context); //  init screen util

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CommonAppBar(title: 'Reports & Insights'),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(ScreenUtilHelper.width(16.0)), //  responsive margin
            padding: EdgeInsets.all(ScreenUtilHelper.width(4.0)), //  responsive padding
            decoration: BoxDecoration(
              color: AppColors.accentLight,
              borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)), //  responsive radius
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.transparent,
              labelStyle: AppStyles.heading,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.graphite,
              tabs: const [
                Tab(text: 'Exam Overview'),
                Tab(text: 'Results'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ExamOverviewTab(),
                ResultsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
