// filename: occupancy_dashboard_screen.dart

import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Make sure these import paths are correct for your project
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../../../../../routes/app_routes.dart';
import '../bloc/occupancy_bloc.dart';

class OccupancyDashboardScreen extends StatefulWidget {
  const OccupancyDashboardScreen({super.key});

  @override
  State<OccupancyDashboardScreen> createState() =>
      _OccupancyDashboardScreenState();
}

class _OccupancyDashboardScreenState extends State<OccupancyDashboardScreen> {
  // int _selectedBottomNavIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<OccupancyBloc>().add(LoadOccupancyDashboard());
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () => context.pop(),
        ),
        title: Image.asset(
          'assets/images/edudibon.png',
          width: ScreenUtilHelper.scaleWidth(100),
          height: ScreenUtilHelper.scaleHeight(50),
          fit: BoxFit.contain,
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.bell, color: AppColors.primary),
            onPressed: () {},
          ),
          SizedBox(width: ScreenUtilHelper.scaleWidth(8)),
        ],
      ),
      body: BlocBuilder<OccupancyBloc, OccupancyState>(
        builder: (context, state) {
          if (state is OccupancyLoading &&
              state is! OccupancyDashboardLoadSuccess) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is OccupancyError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          if (state is OccupancyDashboardLoadSuccess) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(16.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSearchBar(context),
                  SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
                  _buildOccupancySection(context, state),
                  SizedBox(height: ScreenUtilHelper.scaleHeight(30)),
                  _buildAttendanceSection(context, state),
                ],
              ),
            );
          }
          return const Center(child: Text('Loading Data...'));
        },
      ),
    );
  }

  Widget buildSearchBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: ScreenUtilHelper.scaleHeight(40),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius:
              BorderRadius.circular(ScreenUtilHelper.scaleAll(8.0)),
              border: Border.all(color: AppColors.silver, width: 1.0),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by name, room',
                hintStyle: AppStyles.bodySmall.copyWith(color: AppColors.silver),
                prefixIcon: Icon(Icons.search,
                    color: AppColors.ash, size: ScreenUtilHelper.scaleAll(22)),
                suffixIcon: Icon(Icons.mic,
                    color: AppColors.ash, size: ScreenUtilHelper.scaleAll(22)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: ScreenUtilHelper.scaleHeight(11),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: ScreenUtilHelper.scaleWidth(8)),
        Container(
          height: ScreenUtilHelper.scaleHeight(40),
          width: ScreenUtilHelper.scaleWidth(40),
          decoration: BoxDecoration(
            color: AppColors.bluishLightBackgroundshilu,
            borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleAll(9)),
          ),
          child:
          const Icon(Icons.filter_list, size: 22, color: AppColors.primary),
        ),
      ],
    );
  }

  Widget _buildOccupancySection(
      BuildContext context, OccupancyDashboardLoadSuccess state) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.ivory
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Occupancy',
                  style: theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: () => context.push(AppRoutes.hostelRoomList),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryMedium,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),),
                ),
                child: const Text('Allocate'),
              ),
            ],
          ),
          Text('${state.totalBeds} Bed', style: theme.textTheme.bodyMedium),
          SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: ScreenUtilHelper.scaleWidth(10),
            mainAxisSpacing: ScreenUtilHelper.scaleHeight(10),
            childAspectRatio: 1.8,
            children: [
              _StatCard(
                  title: 'Occupied',
                  value: state.occupied.toString(),
                  color: AppColors.slate),
              _StatCard(
                  title: 'Vacant',
                  value: state.vacant.toString(),
                  color: AppColors.slate),
              _StatCard(
                  title: 'Inquiry',
                  value: state.inquiry.toString(),
                  color: AppColors.slate),
              _StatCard(
                  title: 'Pending',
                  value: state.pending.toString(),
                  color: AppColors.slate),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceSection(
      BuildContext context, OccupancyDashboardLoadSuccess state) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.ivory
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Attendance',
                  style: theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryMedium,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),),
                ),
                onPressed: () => context.push(AppRoutes.hostelAttendanceOverview),
                child: const Text('Overview'),
              ),
            ],
          ),
          Text('${state.totalStudents} Students',
              style: theme.textTheme.bodyMedium),
          SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: ScreenUtilHelper.scaleWidth(10),
            mainAxisSpacing: ScreenUtilHelper.scaleHeight(10),
            childAspectRatio: 1.8,
            children: [
              _StatCard(
                  title: 'Present',
                  value: state.present.toString(),
                  color: AppColors.slate),
              _StatCard(
                  title: 'Leave',
                  value: state.onLeave.toString(),
                  color: AppColors.slate),
              _StatCard(
                  title: 'Check In',
                  value: state.checkIn.toString(),
                  color: AppColors.slate),
              _StatCard(
                  title: 'Check Out',
                  value: state.checkOut.toString(),
                  color: AppColors.slate),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: AppColors.white,
      elevation: 2,
      shadowColor: AppColors.shadowDefault,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleAll(10)),
      ),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(12.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(4)),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}