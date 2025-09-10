import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_attendance/screens/subject_wise_performance.dart' show SubjectWisePerformance;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/performance_bloc/performance_bloc.dart';
import '../models/performance_model.dart';
import '../widgets/performance_card.dart';
import '../widgets/performance_dropdown.dart';
import 'exam_wise_performance.dart';
import 'overall_performance.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart'; //  Added for responsive scaling

class PerformanceScreen extends StatelessWidget {
  const PerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context); //  Initialize ScreenUtilHelper

    return BlocProvider(
      create: (context) => PerformanceBloc()..add(const LoadPerformanceData()),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/edudibon.png',
                height: ScreenUtilHelper.height(30), //  Responsive height
                fit: BoxFit.contain,
              ),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.notifications_none,
                      color: AppColors.ash,
                      size: ScreenUtilHelper.fontSize(30), //  Responsive icon size
                    ),
                    onPressed: () {},
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: ScreenUtilHelper.height(1), //  Responsive margin
                        right: ScreenUtilHelper.width(5), //  Responsive margin
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                      width: ScreenUtilHelper.width(15), //  Responsive size
                      height: ScreenUtilHelper.height(15),
                      child: Center(
                        child: Text(
                          "3",
                          style: TextStyle(
                            fontSize: ScreenUtilHelper.fontSize(AppStyles.size.tiny), //  Responsive text
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: BlocBuilder<PerformanceBloc, PerformanceState>(
          builder: (context, state) {
            if (state is PerformanceInitial || state is PerformanceLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PerformanceError) {
              return Center(child: Text(state.message));
            } else if (state is PerformanceLoaded) {
              return _PerformanceContent(
                performanceData: state.performanceData,
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _PerformanceContent extends StatelessWidget {
  final PerformanceData performanceData;

  const _PerformanceContent({required this.performanceData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
              splashRadius: ScreenUtilHelper.radius(20), //  Responsive radius
              icon: Icon(
                Icons.chevron_left,
                size: ScreenUtilHelper.fontSize(30), //  Responsive icon size
                color: AppColors.blackHighEmphasis,
              ),
              onPressed: () =>GoRouter.of(context).pop(),
            ),
            Text(
              'View Performance',
              style: TextStyle(
                fontSize: ScreenUtilHelper.fontSize(AppStyles.size.body), //  Responsive font size
                fontWeight: AppStyles.weight.emphasis,
                color: AppColors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: ScreenUtilHelper.height(30)), //  Responsive spacing
        Padding(
          padding: EdgeInsets.only(
            left: ScreenUtilHelper.width(30), //  Responsive padding
            right: ScreenUtilHelper.width(30),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: PerformanceDropdown(
                      value: performanceData.selectedClass,
                      items: performanceData.classes,
                      onChanged: (newValue) {
                        context.read<PerformanceBloc>().add(ChangeClass(newValue!));
                      },
                      hint: 'Select Class',
                    ),
                  ),
                  SizedBox(width: ScreenUtilHelper.width(16)), //  Responsive spacing
                  Expanded(
                    child: PerformanceDropdown(
                      value: performanceData.selectedYear,
                      items: performanceData.years,
                      onChanged: (newValue) {
                        context.read<PerformanceBloc>().add(ChangeYear(newValue!));
                      },
                      hint: 'Select Year',
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtilHelper.height(25)), //  Responsive spacing
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtilHelper.height(12), //  Responsive padding
                  horizontal: ScreenUtilHelper.width(16),
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondaryAccentLight,
                  borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)), //  Responsive radius
                ),
                child: Center(
                  child: Text(
                    '${performanceData.selectedClass} Performance',
                    style: TextStyle(
                      fontSize: ScreenUtilHelper.fontSize(AppStyles.size.bodySmall), //  Responsive text
                      fontWeight: AppStyles.weight.emphasis,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: ScreenUtilHelper.height(25)), //  Responsive spacing
            ],
          ),
        ),
        GestureDetector(
          onTap: ()=>context.push(AppRoutes.overallPerformance),
          child: const PerformanceCard(
            titleLine1: 'Overall',
            titleLine2: 'Performance',
            iconAssetPath: 'assets/images/bar-chart.png',
          ),
        ),
        SizedBox(height: ScreenUtilHelper.height(16)), //  Responsive spacing
        GestureDetector(
          onTap: ()=>context.push(AppRoutes.examWisePerformance),
          child: const PerformanceCard(
            titleLine1: 'Exam Wise',
            titleLine2: 'Performance',
            iconAssetPath: 'assets/images/bar-chart.png',
          ),
        ),
        SizedBox(height: ScreenUtilHelper.height(16)), //  Responsive spacing
        GestureDetector(
          onTap: ()=>context.push(AppRoutes.subjectWisePerformance),
          child: const PerformanceCard(
            titleLine1: 'Subject wise',
            titleLine2: 'Performance',
            iconAssetPath: 'assets/images/bar-chart.png',
          ),
        ),
        SizedBox(height: ScreenUtilHelper.height(20)), //  Responsive spacing
      ],
    );
  }
}
