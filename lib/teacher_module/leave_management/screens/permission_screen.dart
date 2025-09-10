import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/permission_bloc/permission_bloc.dart';
import '../widgets/leaves_tab_content.dart';
import '../widgets/notification_badge.dart';
import '../widgets/permission_tab_content.dart';
import '../widgets/screen_header.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PermissionBloc()..add(LoadPermissions()),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: ScreenHeader(title: "Leaves Overview"),
          scrolledUnderElevation: 0,
          backgroundColor: AppColors.white,
          automaticallyImplyLeading: false,
          actions: const [NotificationBadge(count: 3)],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: ScreenUtilHelper.scaleHeight(25)),
              _buildTabSelector(),
              SizedBox(height: ScreenUtilHelper.scaleHeight(25)),
              BlocBuilder<PermissionBloc, PermissionState>(
                builder: (context, state) {
                  return state.currentTab == PermissionTab.leaves
                      ? const LeavesTabContent()
                      : const PermissionTabContent();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildTabSelector() {
    return BlocBuilder<PermissionBloc, PermissionState>(
      builder: (context, state) {
        final activeTabColor = AppColors.white;
        final inactiveTabColor = AppColors.white;

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.scaleWidth(8),
              ), // Added padding to prevent overflow
              child: Container(
                width: double.infinity, // Use full available width
                height: ScreenUtilHelper.scaleHeight(44),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      ScreenUtilHelper.scaleRadius(7)),
                  color: inactiveTabColor,
                  border: Border.all(
                    color: AppColors.cloud,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilHelper.scaleWidth(2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: _buildTabButton(
                          context,
                          'Leaves',
                          0,
                          state.currentTab == PermissionTab.leaves
                              ? activeTabColor
                              : Colors.transparent,
                        ),
                      ),
                      Expanded(
                        child: _buildTabButton(
                          context,
                          'Permission',
                          1,
                          state.currentTab == PermissionTab.permission
                              ? activeTabColor
                              : Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Widget _buildTabSelector() {
  //   return BlocBuilder<PermissionBloc, PermissionState>(
  //     builder: (context, state) {
  //       final activeTabColor = AppColors.white;
  //       final inactiveTabColor = AppColors.white;
  //
  //       return Column(
  //         children: [
  //           Container(
  //             width: ScreenUtilHelper.scaleWidth(358),
  //             height: ScreenUtilHelper.scaleHeight(44),
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(
  //                   ScreenUtilHelper.scaleWidth(7)),
  //               color: inactiveTabColor,
  //               border: Border.all(
  //                 color: AppColors.cloud,
  //               ),
  //             ),
  //             child: Padding(
  //
  //               padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 0),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 children: [
  //                   _buildTabButton(
  //                     context,
  //                     'Leaves',
  //                     0,
  //                     state.currentTab == PermissionTab.leaves
  //                         ? activeTabColor
  //                         : Colors.transparent,
  //                   ),
  //                   _buildTabButton(
  //                     context,
  //                     'Permission',
  //                     1,
  //                     state.currentTab == PermissionTab.permission
  //                         ? activeTabColor
  //                         : Colors.transparent,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Widget _buildTabButton(
      BuildContext context,
      String text,
      int index,
      Color color,
      ) {
    return GestureDetector(
      onTap:
          () => context.read<PermissionBloc>().add(ChangePermissionTab(index)),
      child: Container(
        width: ScreenUtilHelper.scaleWidth(index == 0 ? 177 : 179),
        height: ScreenUtilHelper.scaleHeight(44),
        color: color,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: ScreenUtilHelper.scaleText(AppStyles.size.heading),
              fontWeight: AppStyles.weight.regular,
              color: AppColors.blackHint,
            ),
          ),
        ),
      ),
    );
  }
}
