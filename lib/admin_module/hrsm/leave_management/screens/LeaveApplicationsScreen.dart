import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_util_helper.dart';

import '../../../../teacher_module/event_and_scheduling/widgets/search_filter_bar.dart';
import '../../../../teacher_module/leave_management/bloc/leave_bloc/leave_bloc.dart';
import 'ApproveConfirmationDialog.dart';
import 'AttendanceOverviewDialog.dart';
import 'leave_screen.dart';

class LeaveApplicationsScreen extends StatefulWidget {
  const LeaveApplicationsScreen({Key? key}) : super(key: key);

  @override
  State<LeaveApplicationsScreen> createState() => _LeaveApplicationsScreenState();
}

class _LeaveApplicationsScreenState extends State<LeaveApplicationsScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LeaveBloc()..add(LoadLeaves()),
      child: Builder(
        builder: (context) {
          ScreenUtilHelper.init(context);

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColors.white,
              automaticallyImplyLeading: false,
              toolbarHeight: ScreenUtilHelper.height(60),
              titleSpacing: 0,
              title: Padding(
                padding: EdgeInsets.only(left: ScreenUtilHelper.width(16)),
                child: Image.asset(
                  'assets/images/edudibon_logo.png',
                  width: ScreenUtilHelper.width(110),
                  height: ScreenUtilHelper.height(36),
                  fit: BoxFit.contain,
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: ScreenUtilHelper.width(16)),
                  child: Icon(
                    Icons.notifications_none_outlined,
                    color: AppColors.black,
                    size: ScreenUtilHelper.width(26),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(ScreenUtilHelper.width(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back_ios, color: AppColors.black),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtilHelper.width(12),
                              vertical: ScreenUtilHelper.height(8),
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.parchment,
                              borderRadius: BorderRadius.circular(
                                ScreenUtilHelper.radius(8),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = 0;
                                    });
                                  },
                                  child: Text(
                                    "Today on Leave",
                                    style: TextStyle(
                                      color: AppColors.primaryMedium,
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtilHelper.fontSize(12),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: ScreenUtilHelper.height(16),
                                  width: ScreenUtilHelper.width(1),
                                  color: AppColors.parchment,
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      context.pushReplacement(AppRoutes.leaveManagement),
                                  child: Text(
                                    "Applications",
                                    style: TextStyle(
                                      color: AppColors.primaryMedium,
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtilHelper.fontSize(12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: ScreenUtilHelper.height(16)),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search.....',
                        hintStyle: TextStyle(
                          fontSize: ScreenUtilHelper.fontSize(14),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          size: ScreenUtilHelper.width(24),
                        ),
                        suffixIcon: Icon(
                          Icons.mic,
                          color: AppColors.blackHighEmphasis,
                          size: ScreenUtilHelper.width(24),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            ScreenUtilHelper.radius(8),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: ScreenUtilHelper.width(12),
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.height(16)),
                    Row(
                      children: [
                        Container(
                          height: ScreenUtilHelper.height(40),
                          width: ScreenUtilHelper.height(40),
                          decoration: BoxDecoration(
                            color: AppColors.parchment,
                            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.filter_alt_outlined,
                              color: AppColors.slate,
                              size: ScreenUtilHelper.width(20),
                              //color: AppColors.blackHighEmphasis,
                            ),
                          ),
                        ),
                        SizedBox(width: ScreenUtilHelper.width(8)),
                        Expanded(
                          child: Container(
                            height: ScreenUtilHelper.height(40),
                            padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(8)),
                            decoration: BoxDecoration(
                              color: AppColors.parchment,
                              borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: 'Teaching',
                                isExpanded: true,
                                icon: Icon(Icons.keyboard_arrow_down, size: ScreenUtilHelper.width(20)),
                                style: TextStyle(
                                  fontSize: ScreenUtilHelper.fontSize(14),
                                  color: AppColors.black,
                                ),
                                items: [
                                  DropdownMenuItem(value: 'Teaching', child: Text('Teaching')),
                                  DropdownMenuItem(value: 'Non-Teaching', child: Text('Non-Teaching')),
                                ],
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: ScreenUtilHelper.width(8)),
                        Expanded(
                          child: Container(
                            height: ScreenUtilHelper.height(40),
                            padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(8)),
                            decoration: BoxDecoration(
                              color: AppColors.parchment,
                              borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: 'Date',
                                isExpanded: true,
                                icon: Icon(Icons.keyboard_arrow_down, size: ScreenUtilHelper.width(20)),
                                style: TextStyle(
                                  fontSize: ScreenUtilHelper.fontSize(14),
                                  color: AppColors.black,
                                ),
                                items: [
                                  DropdownMenuItem(value: 'Date', child: Text('Date')),
                                  DropdownMenuItem(value: 'Recent', child: Text('Recent')),
                                ],
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtilHelper.height(16)),
                    _LeaveCard(
                      approvalStatus: '',
                      approvalColor: AppColors.black,
                      showApproveButton: true,
                    ),
                    SizedBox(height: ScreenUtilHelper.height(16)),
                    _LeaveCard(
                      approvalStatus: 'Granted',
                      approvalColor: Colors.green,
                      showApproveButton: false,
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.blue, // Active item color
              unselectedItemColor: Colors.grey, // Inactive item color
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'Feed'),
                BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'My Account'),
              ],
            )


          );
        },
      ),
    );
  }
}

class _LeaveCard extends StatelessWidget {
  final String approvalStatus;
  final Color approvalColor;
  final bool showApproveButton;

  const _LeaveCard({
    Key? key,
    required this.approvalStatus,
    required this.approvalColor,
    required this.showApproveButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.parchment,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          ScreenUtilHelper.radius(8),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilHelper.width(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Leave Application - 125653',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtilHelper.fontSize(14),
                  ),
                ),
                Text(
                  '19/03/25',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: ScreenUtilHelper.fontSize(12),
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenUtilHelper.height(8)),
            ...[
              'Employee name - Rutuja Yawale',
              'Employee Type - Temporary',
              'Department - Teaching',
              'Sub- Department - Primary',
              'Leave Type - Sick leave',
              'Reason - Not well',
              'Days - 15/03/25 - 17/03/25',
              'Paid/Unpaid - Unpaid',
            ].map((text) => Text(
              text,
              style: TextStyle(
                fontSize: ScreenUtilHelper.fontSize(13),
              ),
            )),
            Row(
              children: [
                Text(
                  'Approval - ',
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.fontSize(13),
                  ),
                ),
                Text(
                  approvalStatus,
                  style: TextStyle(
                    color: approvalColor,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtilHelper.fontSize(13),
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenUtilHelper.height(8)),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const AttendanceOverviewDialog(),
                    );
                  },
                  child: Text(
                    'Overview',
                    style: TextStyle(
                      fontSize: ScreenUtilHelper.fontSize(13),
                    ),
                  ),
                ),
                const Spacer(),
                if (showApproveButton)
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const ApproveConfirmationDialog(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryMedium,
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.width(12),
                        vertical: ScreenUtilHelper.height(8),
                      ),
                    ),
                    child: Text(
                      'Approve',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: ScreenUtilHelper.fontSize(13),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
