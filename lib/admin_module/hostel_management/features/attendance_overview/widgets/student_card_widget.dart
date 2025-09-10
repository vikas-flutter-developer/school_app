import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../bloc/student_profile/student_profile_bloc.dart';
import '../models/student_card_model.dart';
import '../screens/profile_screen.dart';

class StudentCardWidget extends StatelessWidget {
  final StudentCardModel studentData;

  const StudentCardWidget({super.key, required this.studentData});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return GestureDetector(
      onTap: ()=>context.push(AppRoutes.hostelStudentDetails,extra: studentData),
      child: Container(
        width: double.infinity,
        height: ScreenUtilHelper.height(184),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(5.0)),
          color: AppColors.ivory,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(5.0)),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: AppColors.ivory,
                  padding: EdgeInsets.only(
                    top: ScreenUtilHelper.height(12.0),
                    left: ScreenUtilHelper.width(16.0),
                    right: ScreenUtilHelper.width(12.0),
                    bottom: ScreenUtilHelper.height(8.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              studentData.roomSeat,
                              style: AppStyles.bodySmall.copyWith(color: AppColors.primaryDarkest)
                            ),
                            Text(
                              studentData.name,
                              style: AppStyles.body.copyWith(color: AppColors.black)
                            ),
                            Text(
                              studentData.email,
                              style: AppStyles.bodySmall.copyWith(color: AppColors.black)
                            ),
                            Text(
                              studentData.phone,
                              style: AppStyles.bodySmall.copyWith(color: AppColors.black)
                            ),
                            Row(
                              children: [
                                Text(
                                  studentData.department,
                                  style: AppStyles.bodySmall.copyWith(color: AppColors.black)
                                ),
                                SizedBox(width: ScreenUtilHelper.width(10)),
                                Text(
                                  studentData.year,
                                  style: AppStyles.bodySmall.copyWith(color: AppColors.black)
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: ScreenUtilHelper.width(10)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side:  BorderSide(color: AppColors.silver),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtilHelper.radius(8.0)),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtilHelper.width(16),
                                vertical: ScreenUtilHelper.height(6),
                              ),
                              minimumSize: Size(ScreenUtilHelper.width(60),
                                  ScreenUtilHelper.height(30)),
                            ),
                            child: Text(
                              'Receipt',
                              style: TextStyle(
                                color: AppColors.blackHighEmphasis,
                                fontSize: AppStyles.size.tinyPlus,
                              ),
                            ),
                          ),
                          const Spacer(),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                ScreenUtilHelper.radius(12.0)),
                            child: Image.asset(
                              studentData.profileImageUrl,
                              width: ScreenUtilHelper.width(74),
                              height: ScreenUtilHelper.height(80),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: ScreenUtilHelper.width(80),
                                  height: ScreenUtilHelper.height(80),
                                  color: AppColors.cloud,
                                  child: Icon(
                                    Icons.person,
                                    size: ScreenUtilHelper.scaleAll(40),
                                    color: AppColors.stone,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: ScreenUtilHelper.height(36),
                color: AppColors.slate,
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilHelper.width(16.0)),
                child: Row(
                  mainAxisAlignment: studentData.status == 'On leave'
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      studentData.statusText,
                      style: AppStyles.bodySmall.copyWith(color: studentData.statusColor)
                    ),
                    if (studentData.status != 'On leave')
                      Text(
                        studentData.time,
                        style: AppStyles.bodySmall.copyWith(color: studentData.statusColor)
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}