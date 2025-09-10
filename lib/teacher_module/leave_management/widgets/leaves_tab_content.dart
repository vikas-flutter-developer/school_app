import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart';
import 'package:go_router/go_router.dart';
import '../bloc/leave_bloc/leave_bloc.dart';
import '../screens/apply_leave_screen.dart';
import 'leaves_overview.dart';
import 'my_ticket_tab.dart';

class LeavesTabContent extends StatefulWidget {
  const LeavesTabContent({super.key});

  @override
  State<LeavesTabContent> createState() => _LeavesTabContentState();
}

class _LeavesTabContentState extends State<LeavesTabContent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveBloc, LeaveState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: ScreenUtilHelper.scaleWidth(16)),
              child: Row(
                children: [
                  _buildLeavesTabButton(context, "Overview", 0),
                  SizedBox(width: ScreenUtilHelper.scaleWidth(20)),
                  _buildLeavesTabButton(context, "My Leaves", 1),
                ],
              ),
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
            IndexedStack(
              index: state.currentTab == LeaveTab.overview ? 0 : 1,
              children: [
                Column(
                  children: [
                    const LeavesOverview(),
                    SizedBox(height: ScreenUtilHelper.scaleHeight(15)),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: ScreenUtilHelper.scaleWidth(25)),
                        child: Text(
                          "Upcoming Leaves",
                          style: TextStyle(
                            fontSize: ScreenUtilHelper.scaleText(AppStyles.size.bodySmall),
                            fontWeight: AppStyles.weight.emphasis,
                            color: AppColors.blackHighEmphasis,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
                    _buildUpcomingLeaves(),
                    SizedBox(height: ScreenUtilHelper.scaleHeight(30)),
                    _buildApplyLeaveButton(context),
                  ],
                ),
                const MyTicketTab(),
              ],
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(50)),
          ],
        );
      },
    );
  }

  Widget _buildLeavesTabButton(BuildContext context, String text, int index) {
    final isSelected = context.select(
          (LeaveBloc bloc) =>
      bloc.state.currentTab == (index == 0 ? LeaveTab.overview : LeaveTab.myTicket),
    );

    return GestureDetector(
      onTap: () => context.read<LeaveBloc>().add(ChangeLeaveTab(index)),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: ScreenUtilHelper.scaleText(AppStyles.size.medium),
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
              color:
              isSelected ? AppColors.primaryMedium : AppColors.blackHighEmphasis,
            ),
          ),
          if (isSelected)
            Container(
              height: ScreenUtilHelper.scaleHeight(2),
              width: ScreenUtilHelper.scaleWidth(text.length * 8.0),
              color: AppColors.primaryMedium,
            ),
        ],
      ),
    );
  }

  Widget _buildUpcomingLeaves() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtilHelper.scaleWidth(15),
        ),
        child: Row(
          children: [
            Container(
              width: ScreenUtilHelper.scaleWidth(176),
              height: ScreenUtilHelper.scaleHeight(123),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius:
                BorderRadius.circular(ScreenUtilHelper.scaleWidth(15)),
                border: Border.all(color: AppColors.cloud),
                image: const DecorationImage(
                  image: AssetImage('assets/images/ed1.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(width: ScreenUtilHelper.scaleWidth(10)),
            Container(
              width: ScreenUtilHelper.scaleWidth(176),
              height: ScreenUtilHelper.scaleHeight(123),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius:
                BorderRadius.circular(ScreenUtilHelper.scaleWidth(15)),
                border: Border.all(color: AppColors.primaryMedium),
                image: const DecorationImage(
                  image: AssetImage('assets/images/ed2.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApplyLeaveButton(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(16)),
      child: SizedBox(
        width: ScreenUtilHelper.scaleWidth(346),
        height: ScreenUtilHelper.scaleHeight(50),
        child: ElevatedButton(
          onPressed: ()=>context.push(AppRoutes.applyLeave),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryMedium,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(6)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: ScreenUtilHelper.scaleWidth(12),
                backgroundColor: AppColors.white,
                child: Icon(
                  Icons.add,
                  size: ScreenUtilHelper.scaleWidth(16),
                  color: AppColors.primaryMedium,
                ),
              ),
              SizedBox(width: ScreenUtilHelper.scaleWidth(5)),
              Text(
                "Apply Leave",
                style: TextStyle(
                  fontSize: ScreenUtilHelper.scaleText(AppStyles.size.display),
                  fontWeight: AppStyles.weight.emphasis,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
