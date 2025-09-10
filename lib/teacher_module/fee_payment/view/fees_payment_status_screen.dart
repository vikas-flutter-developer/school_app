import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart'; //  ScreenUtilHelper import
import '../bloc/fee_bloc.dart';
import '../bloc/fee_event.dart';
import 'overview_tab.dart';
import 'student_fee_tab.dart';

class FeesPaymentStatusScreen extends StatelessWidget {
  const FeesPaymentStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context); //  Initialize ScreenUtilHelper once

    return BlocProvider(
      create: (context) =>
      FeesBloc()..add(FeesLoadInitialData()), // Create and load initial data
      child: DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          backgroundColor: AppColors.linen,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.blackMediumEmphasis),
              onPressed: () => GoRouter.of(context).pop(),
            ),
            title: Text(
              'Fees and Payment Status',
              style: TextStyle(
                color: AppColors.stone,
                fontSize: ScreenUtilHelper.scaleText(AppStyles.size.bodyLarge), // Responsive font
                fontWeight: AppStyles.weight.emphasis,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_none,
                  color: AppColors.blackMediumEmphasis,
                ),
                onPressed: () {
                  // Handle notification tap
                },
              ),
            ],
            backgroundColor: AppColors.white,
            elevation: 1.0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(ScreenUtilHelper.scaleHeight(kToolbarHeight)), //  Responsive height
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.scaleWidth(16.0), //  Responsive margin
                  vertical: ScreenUtilHelper.scaleHeight(8.0),  //  Responsive margin
                ),
                padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(4.0)), //  Responsive padding
                decoration: BoxDecoration(
                  color: AppColors.linen,
                  borderRadius: BorderRadius.circular(
                    ScreenUtilHelper.scaleWidth(10.0), //  Responsive radius
                  ),
                ),
                child: TabBar(
                  tabs: const [Tab(text: 'Overview'), Tab(text: 'Student Fee')],
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      ScreenUtilHelper.scaleWidth(8.0), //  Responsive radius
                    ),
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.slate,
                        spreadRadius: ScreenUtilHelper.scaleWidth(1), //  Responsive shadow
                        blurRadius: ScreenUtilHelper.scaleWidth(3),
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  labelColor: AppColors.primaryBright,
                  unselectedLabelColor: AppColors.blackMediumEmphasis,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
              ),
            ),
          ),
          body: const TabBarView(children: [OverviewTab(), StudentFeeTab()]),
        ),
      ),
    );
  }
}
