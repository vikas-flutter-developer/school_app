import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart'; // ✅ Added
import 'package:edudibon_flutter_bloc/teacher_module/teacher_attendance/bloc/attendance_bloc/attendance_bloc.dart'
    show AttendancesBloc, LoadAttendanceOptions;
import 'package:edudibon_flutter_bloc/teacher_module/teacher_attendance/screens/performance_screen.dart'
    show PerformanceScreen;
import 'package:edudibon_flutter_bloc/teacher_module/teacher_attendance/screens/view_attendance.dart'
    show ViewAttendanceScreen;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/app_routes.dart';

class AttendancePerformanceScreen extends StatelessWidget {
  const AttendancePerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    return BlocProvider(
      create: (context) => AttendancesBloc()..add(LoadAttendanceOptions()),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/edudibon.png',
                height: ScreenUtilHelper.scaleHeight(30), //  Responsive
                fit: BoxFit.contain,
              ),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.notifications_none,
                      color: AppColors.ash,
                      size: ScreenUtilHelper.scaleWidth(30), //  Responsive
                    ),
                    onPressed: () {},
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: ScreenUtilHelper.scaleHeight(1),
                        right: ScreenUtilHelper.scaleWidth(5),
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                      width: ScreenUtilHelper.scaleWidth(15), //  Responsive
                      height: ScreenUtilHelper.scaleHeight(15), //  Responsive
                      child: Center(
                        child: Text(
                          "3",
                          style: AppStyles.small.copyWith(color: AppColors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(16)), //  Responsive
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: ScreenUtilHelper.scaleHeight(5),
                  bottom: ScreenUtilHelper.scaleHeight(30),
                ), //  Responsive
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.blackMediumEmphasis,
                        size: ScreenUtilHelper.scaleWidth(20), //  Responsive
                      ),
                      onPressed: ()=>GoRouter.of(context).pop(),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      splashRadius: ScreenUtilHelper.scaleWidth(20), //  Responsive
                    ),
                    SizedBox(width: ScreenUtilHelper.scaleWidth(8)), //  Responsive
                    Text(
                      'Attendance & Performance',
                      style: AppStyles.bodyEmphasis.copyWith(color: AppColors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(30)), //  Responsive
              Column(
                children: [
                  GestureDetector(
                    onTap: ()=>context.push(AppRoutes.teacherAttendance),
                    child: Column(
                      children: [
                        Text(
                          'Student Attendance',
                          style: AppStyles.headingLargeEmphasis.copyWith(color: AppColors.black),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: ScreenUtilHelper.scaleHeight(30)), //  Responsive
                        SizedBox(
                          width: ScreenUtilHelper.scaleWidth(234), //  Responsive
                          height: ScreenUtilHelper.scaleHeight(180), //  Responsive
                          child: Image.asset(
                            'assets/images/student_attendance.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtilHelper.scaleHeight(50)), //  Responsive
                  GestureDetector(
                    onTap: ()=>context.push(AppRoutes.teacherPerformance),
                    child: Column(
                      children: [
                        Text(
                          'Student Performance',
                          style: AppStyles.headingLargeEmphasis.copyWith(
                            color: AppColors.blackHighEmphasis,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: ScreenUtilHelper.scaleHeight(30)), //  Responsive
                        SizedBox(
                          width: ScreenUtilHelper.scaleWidth(195), //  Responsive
                          height: ScreenUtilHelper.scaleHeight(195), //  Responsive
                          child: Image.asset(
                            'assets/images/student_performance.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
