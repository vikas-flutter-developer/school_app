// Your updated notifications_screen.dart file

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

// ✅ STEP 1: Import the necessary helpers
import '../../../core/utils/app_colors.dart';
import 'bloc/notifications_bloc.dart';
import 'models/notification_item.dart';
import '../../../core/utils/screen_util_helper.dart'; // ⚠️ अपने प्रोजेक्ट का सही पाथ डालें

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsBloc(),
      child: const NotificationsView(),
    );
  }
}

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Initialize the helper
    ScreenUtilHelper.init(context);

    // ❌ STEP 2: Remove old MediaQuery and manual responsive logic.

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      body: BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (context, state) {
          if (state.status == NotificationStatus.loading && state.groupedNotifications.isEmpty) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primaryDark));
          }
          if (state.status == NotificationStatus.failure) {
            return Center(child: Padding(padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(16)), child: Text("Error: ${state.errorMessage ?? 'Could not load notifications'}", textAlign: TextAlign.center)));
          }
          if (state.groupedNotifications.isEmpty && state.status == NotificationStatus.success) {
            return Center(child: Text("No notifications found.", style: GoogleFonts.openSans(color: AppColors.stone)));
          }

          final sortedDates = state.groupedNotifications.keys.toList();

          return RefreshIndicator(
            onRefresh: () async {
              context.read<NotificationsBloc>().add(LoadNotifications());
              await context.read<NotificationsBloc>().stream.firstWhere((s) => s.status != NotificationStatus.loading);
            },
            color: AppColors.primaryDark,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.width(15),
                  vertical: ScreenUtilHelper.height(12)),
              itemCount: sortedDates.length,
              itemBuilder: (context, groupIndex) {
                final dateString = sortedDates[groupIndex];
                final notificationsForDate = state.groupedNotifications[dateString]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDateHeader(dateString),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: notificationsForDate.length,
                      padding: EdgeInsets.only(
                          top: ScreenUtilHelper.height(6),
                          bottom: ScreenUtilHelper.height(12)),
                      itemBuilder: (context, itemIndex) {
                        final item = notificationsForDate[itemIndex];
                        // ✅ No longer need to pass sizes, the card handles it internally
                        return _buildNotificationCard(item);
                      },
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.bottomNavIndex,
            onTap: (index) => context.read<NotificationsBloc>().add(BottomNavTapped(index)),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.primaryDark,
            unselectedItemColor: AppColors.error,
            selectedLabelStyle: GoogleFonts.openSans(fontWeight: FontWeight.w600, fontSize: ScreenUtilHelper.fontSize(11)),
            unselectedLabelStyle: GoogleFonts.openSans(fontSize: ScreenUtilHelper.fontSize(11)),
            backgroundColor: AppColors.white,
            elevation: 5.0,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.feed_outlined), label: 'Feed'),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'My Account'),
            ],
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.5,
      shadowColor: AppColors.blackDivider,
      backgroundColor: AppColors.white,
      elevation: 1,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, size: ScreenUtilHelper.scaleAll(20), color: AppColors.slate),
        onPressed: () => GoRouter.of(context).pop(),
      ),
      title: Text(
        'Library notifications',
        style: GoogleFonts.openSans(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtilHelper.fontSize(18),
        ),
      ),
      centerTitle: true,
      actions: [SizedBox(width: ScreenUtilHelper.width(48))],
    );
  }

  Widget _buildDateHeader(String dateText) {
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtilHelper.height(18),
          bottom: ScreenUtilHelper.height(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dateText,
            style: GoogleFonts.openSans(
              fontSize: ScreenUtilHelper.fontSize(14),
              fontWeight: FontWeight.w600,
              color: AppColors.slate,
            ),
          ),
          SizedBox(height: ScreenUtilHelper.height(4)),
           Divider(color: AppColors.parchment, thickness: 1.0, height: 1),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(NotificationItem item) {
    return Card(
      elevation: 0.5,
      margin: EdgeInsets.only(bottom: ScreenUtilHelper.height(6)),
      color: AppColors.ivory,
      shadowColor: AppColors.blackDivider,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10))),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: ScreenUtilHelper.height(10),
            horizontal: ScreenUtilHelper.width(14)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                item.message,
                style: GoogleFonts.openSans(
                  fontSize: ScreenUtilHelper.fontSize(14.5),
                  color: AppColors.graphite,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: ScreenUtilHelper.width(10)),
            Text(
              item.time,
              style: GoogleFonts.openSans(
                fontSize: ScreenUtilHelper.fontSize(14),
                color: AppColors.slate,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}