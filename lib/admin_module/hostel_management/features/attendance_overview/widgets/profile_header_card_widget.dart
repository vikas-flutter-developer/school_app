import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../models/student_profile_model.dart';

class ProfileHeaderCardWidget extends StatelessWidget {
  final StudentProfileModel profile;

  const ProfileHeaderCardWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Container(
      width: double.infinity,
      height: ScreenUtilHelper.height(228),
      padding: EdgeInsets.all(ScreenUtilHelper.width(8.0)),
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(12.0)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.roomSeat,
                  style:AppStyles.headingRegular.copyWith(color: AppColors.black)
                ),
                SizedBox(height: ScreenUtilHelper.height(4)),
                Text(
                  profile.name,
                  style:AppStyles.display.copyWith(color: AppColors.black)
                ),
                const Spacer(),
                Text(
                  profile.expiryDate,
                  style: AppStyles.body
                ),
              ],
            ),
          ),
          SizedBox(width: ScreenUtilHelper.width(16)),
          SizedBox(
            width: ScreenUtilHelper.width(167),
            height: ScreenUtilHelper.height(202),
            child: ClipRRect(
              borderRadius:
              BorderRadius.circular(ScreenUtilHelper.radius(12.0)),
              child: Image.asset(
                profile.profileImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: ScreenUtilHelper.width(167),
                    height: ScreenUtilHelper.height(202),
                    color: AppColors.cloud,
                    child: Icon(
                      Icons.person,
                      size: ScreenUtilHelper.scaleAll(50),
                      color: AppColors.stone,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}