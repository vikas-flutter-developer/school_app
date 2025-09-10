import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../../../bus_route_management/presentation/route_management_screen.dart';
import '../Widgets/navigation_card.dart';
import 'driver_management_screen.dart';
import 'live_bus_screens.dart';


class TransportManagementScreen extends StatelessWidget {
  const TransportManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtilHelper
    ScreenUtilHelper.init(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Transport management',
          style: AppStyles.heading.copyWith(
            fontWeight: AppStyles.weight.emphasis,
            color: AppColors.black,
            fontSize: ScreenUtilHelper.fontSize(18), // <-- Scaled
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: AppColors.black,
              size: ScreenUtilHelper.scaleAll(32), // <-- Scaled
            ),
            onPressed: () {},
          ),
          SizedBox(width: ScreenUtilHelper.width(8)), // <-- Scaled
        ],
      ),
      body: _buildBody(context),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.white,
        currentIndex: 0,
        selectedItemColor: AppColors.secondaryMedium,
        unselectedItemColor: AppColors.ash,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: AppStyles.bold,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'My Account'),
        ],
      ),
    );
  }


  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(16)), // <-- Scaled
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Expanded(
                child: SummaryCard(
                  title: 'Total Buses',
                  count: '50',
                ),
              ),
              SizedBox(width: ScreenUtilHelper.width(16)), // <-- Scaled
              const Expanded(
                child: SummaryCard(
                  title: 'Active Buses',
                  count: '45',
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenUtilHelper.height(16)), // <-- Scaled
          const SummaryCard(
            title: 'Inactive Buses',
            count: '5',
          ),
          SizedBox(height: ScreenUtilHelper.height(24)), // <-- Scaled
          Row(
            children: [
              Expanded(
                child: NavigationCard(
                  imagePath: 'assets/images/tracking_icon.png',
                  title: 'Live\ntracking',
                  onTap: ()=>context.push(AppRoutes.adminLiveTracking),
                ),
              ),
              SizedBox(width: ScreenUtilHelper.width(16)), // <-- Scaled
              Expanded(
                child: NavigationCard(
                  imagePath: 'assets/images/driver_icon.png',
                  title: 'Driver\nManagement',
                  onTap: ()=>context.push(AppRoutes.driverManagement),
                ),
              ),
              SizedBox(width: ScreenUtilHelper.width(16)), // <-- Scaled
              Expanded(
                child: NavigationCard(
                  imagePath: 'assets/images/route_icon.png',
                  title: 'Route\nManagement',
                  onTap: () =>context.push(AppRoutes.routeManagement),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ------------------- Reusable Custom Widgets -------------------

class SummaryCard extends StatelessWidget {
  final String title;
  final String count;

  const SummaryCard({
    Key? key,
    required this.title,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(16)), // <-- Scaled
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(12)), // <-- Scaled
        border: Border.all(
          color: AppColors.silver,
          width: ScreenUtilHelper.scaleAll(1), // <-- Scaled
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.headingS.copyWith(
              fontSize: ScreenUtilHelper.fontSize(16), // <-- Scaled
            ),
          ),
          SizedBox(height: ScreenUtilHelper.height(8)), // <-- Scaled
          Text(
            count,
            style: AppStyles.display.copyWith(
              fontSize: ScreenUtilHelper.fontSize(28), // <-- Scaled
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}