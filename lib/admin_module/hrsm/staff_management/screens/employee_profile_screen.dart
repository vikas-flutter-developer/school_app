import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart';

import '../../widgets/documents_card.dart';
import '../../widgets/employee_info_card.dart';
import '../../widgets/joining_lcard.dart';
import '../../widgets/leave-card.dart';
import '../../widgets/profile_header.dart';
import '../../widgets/salary_details_card.dart';
import '../bloc/employee_bloc.dart';
import '../bloc/employee_state.dart';
import '../bloc/employee_event.dart'; // <-- Make sure you import this
import '../model/employee_entity.dart';

class EmployeeProfileScreen extends StatelessWidget {
  final String index;
  const EmployeeProfileScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmployeeBloc()..add(LoadEmployeeEvent()),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: BlocBuilder<EmployeeBloc, EmployeeState>(
            builder: (context, state) {
              if (state is EmployeeLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is EmployeeLoaded) {
                final EmployeeEntity employee = state.employee;
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilHelper.width(16),
                    vertical: ScreenUtilHelper.height(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileHeader(employee: employee),
                      SizedBox(height: ScreenUtilHelper.height(16)),
                      EmployeeInfoCard(employee: employee),
                      SizedBox(height: ScreenUtilHelper.height(16)),
                      DocumentsCard(employee: employee),
                      SizedBox(height: ScreenUtilHelper.height(16)),
                      SalaryDetailsCard(employee: employee),
                      SizedBox(height: ScreenUtilHelper.height(16)),
                      JoiningDetailsCard(employee: employee),
                      SizedBox(height: ScreenUtilHelper.height(16)),
                      LeavesCard(employee: employee),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text('No employee data available'),
                );
              }
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          selectedFontSize: ScreenUtilHelper.fontSize(12),
          unselectedFontSize: ScreenUtilHelper.fontSize(12),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                size: ScreenUtilHelper.width(24),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.feed_outlined,
                size: ScreenUtilHelper.width(24),
              ),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                size: ScreenUtilHelper.width(24),
              ),
              label: 'My Account',
            ),
          ],
        ),
      ),
    );
  }
}
