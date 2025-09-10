import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../../../../widgets/feature_card.dart';

class HostelManagementHome extends StatelessWidget {
  const HostelManagementHome({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,color: AppColors.blackHighEmphasis,size: 24,),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        title: Padding(
          padding: EdgeInsets.only(right: ScreenUtilHelper.width(16)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/edudibon_logo.png',
                height: ScreenUtilHelper.height(30),
              ),
              const Spacer(),
              GestureDetector(
                onTap: ()=>context.push(AppRoutes.notifications),
                child: Image.asset(
                  'assets/images/notification.png',
                  height: ScreenUtilHelper.height(24),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.white,
        // elevation: 1.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: ScreenUtilHelper.width(12.0),
          mainAxisSpacing: ScreenUtilHelper.height(12.0),
          children: <Widget>[
            FeatureCard(
              title: 'Occupancy',
              icon: Icons.bed_outlined,
              onTap: () => context.push(AppRoutes.hostelOccupancyDashboard),
            ),
            FeatureCard(
              title: 'Visitor Management',
              icon: Icons.groups_outlined,
              onTap: () => context.push(AppRoutes.hostelVisitorManagement),
            ),
            FeatureCard(
              title: 'Staff Management',
              icon: Icons.manage_accounts_outlined,
              onTap: () => context.push(AppRoutes.hostelStaffManagement),
            ),
            FeatureCard(
              title: 'Fee Payments',
              icon: Icons.payment_outlined,
              onTap: () => context.push(AppRoutes.hostelFeePayment),
            ),
            FeatureCard(
              title: 'Complaints',
              icon: Icons.chat_bubble_outline,
              onTap: () => context.push(AppRoutes.hostelComplaints),
            ),
            FeatureCard(
              title: 'Services',
              icon: Icons.build_outlined,
              onTap: () => context.push(AppRoutes.hostelServices),
            ),
            FeatureCard(
              title: 'Issue Items',
              icon: Icons.list_alt_outlined,
              onTap: () => context.push(AppRoutes.hostelIssueItems),
            ),
            FeatureCard(
              title: 'Emergency',
              icon: Icons.emergency_outlined,
              onTap: () => context.push(AppRoutes.hostelEmergency),
            ),
          ],
        ),
      ),
    );
  }
}