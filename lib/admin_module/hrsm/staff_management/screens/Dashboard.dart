import 'package:edudibon_flutter_bloc/admin_module/hrsm/staff_management/screens/AttendanceScreen.dart';
import 'package:flutter/material.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart';
import 'package:go_router/go_router.dart';
import '../../../../routes/app_routes.dart';
import 'EmployeeScreen.dart';
import 'RecruitmentScreen.dart';

class StaffManagementDashboard extends StatelessWidget {
  const StaffManagementDashboard({super.key});

  Widget buildStatBox(String value, String label, Color valueColor, Color labelColor) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(14)),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: AppStyles.bodyBold.copyWith(fontSize: ScreenUtilHelper.scaleText(22), color: valueColor),
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(4)),
          Text(label, style: AppStyles.bodySmall.copyWith(color: labelColor)),
        ],
      ),
    );
  }

  Widget buildMenuButton(String label, IconData icon) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(4)),
      padding: EdgeInsets.all(ScreenUtilHelper.scaleHeight(18)),
      decoration: BoxDecoration(
        color: AppColors.primaryMedium.withAlpha(32),
        borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon,color: AppColors.primaryMedium,size: ScreenUtilHelper.scaleWidth(24),),
          SizedBox(height: ScreenUtilHelper.scaleHeight(4)),
          Text(label,
              style: AppStyles.small.copyWith(
                color: AppColors.black,
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(15)),
          child: Column(
            children: [
              SizedBox(height: ScreenUtilHelper.scaleHeight(12)),
              // AppBar substitute
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
                    onPressed: () => GoRouter.of(context).pop(),
                  ),
                  Image.asset('assets/images/edudibon1.png', height: ScreenUtilHelper.scaleHeight(30)),
                  Spacer(),
                  Icon(Icons.notifications_outlined, color: AppColors.black,size: ScreenUtilHelper.scaleWidth(24)),
                  SizedBox(width: ScreenUtilHelper.scaleWidth(10)),
                ],
              ),

              SizedBox(height: ScreenUtilHelper.scaleHeight(12)),
              // Search bar
              TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: AppColors.greyLight,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(20))),
                ),
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
              // Banner with Image
              Container(
                width: double.infinity,
                height: ScreenUtilHelper.scaleHeight(142),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(12)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(12)),
                  child: Image.asset('assets/images/hrsm_dashboard.png', fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(18)),
              // Total Employees Section
              Card(
                color: AppColors.primaryMedium.withAlpha(32),
                elevation: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilHelper.scaleWidth(18), vertical: ScreenUtilHelper.scaleHeight(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Employees", style: AppStyles.heading),
                      SizedBox(height: ScreenUtilHelper.scaleHeight(8)),
                      Text("480", style: AppStyles.display),
                      SizedBox(height: ScreenUtilHelper.scaleHeight(12)),
                      GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        childAspectRatio: 2,
                        crossAxisSpacing: ScreenUtilHelper.scaleWidth(12),
                        mainAxisSpacing: ScreenUtilHelper.scaleHeight(12),
                        children: [
                          GestureDetector(
                            onTap: () =>context.go(AppRoutes.staffAttendance),
                            child: buildStatBox(
                                "400", "Present", AppColors.black, AppColors.black,),
                          ),
                          buildStatBox("80", "Absent", AppColors.black, AppColors.black,),
                          buildStatBox("05", "New Join", AppColors.black, AppColors.success,),
                          buildStatBox("05", "Half Day", AppColors.black, AppColors.error,),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(24)),
              // Bottom Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () =>context.push(AppRoutes.staffAttendance),
                      child: buildMenuButton("Attendance",Icons.groups)),
                  GestureDetector(
                      onTap: () =>context.push(AppRoutes.employees),
                      child: buildMenuButton("Employees", Icons.account_balance_wallet)),
                  GestureDetector(
                      onTap: () =>context.push(AppRoutes.recruitment),
                      child: buildMenuButton("Recruitment", Icons.note)),
                ],
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(40)),
            ],
          ),
        ),
      ),
    );
  }
}
