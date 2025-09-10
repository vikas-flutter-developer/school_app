import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../models/student_profile_model.dart';
import 'profile_info_row_widget.dart';

class ProfilePaymentsCardWidget extends StatelessWidget {
  final StudentProfileModel profile;
  final VoidCallback? onEditPressed;
  final VoidCallback? onReceiptPressed;

  const ProfilePaymentsCardWidget({
    super.key,
    required this.profile,
    this.onEditPressed,
    this.onReceiptPressed,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Container(
      padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(12.0)),
        boxShadow: [
          BoxShadow(
            color: AppColors.ash.withAlpha(25),
            spreadRadius: ScreenUtilHelper.radius(1),
            blurRadius: ScreenUtilHelper.radius(3),
            offset: Offset(0, ScreenUtilHelper.height(2)),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Payments",
                style: AppStyles.heading.copyWith(color: AppColors.blackHighEmphasis)
              ),
              GestureDetector(
                onTap: onEditPressed,
                child: Icon(
                  Icons.edit_outlined,
                  color: AppColors.silver,
                  size: ScreenUtilHelper.scaleAll(20),
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenUtilHelper.height(12)),
          ProfileInfoRowWidget("Advance - ${profile.advancePayment}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ProfileInfoRowWidget(
                  "Pending - ${profile.pendingPayment}",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: ScreenUtilHelper.height(2.0)),
                child: Text(
                  "due - ${profile.pendingDueDate}",
                  style: AppStyles.feedbackNote.copyWith(color: AppColors.black)
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: ProfileInfoRowWidget(
                  "Caution - ${profile.cautionMoney}\nMoney",
                  bottomPadding: 0,
                ),
              ),
              SizedBox(
                height: ScreenUtilHelper.height(32),
                child: OutlinedButton(
                  onPressed: onReceiptPressed,
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.width(16)),
                    side: BorderSide(color: AppColors.silver),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
                    ),
                  ),
                  child: Text(
                    "Receipt",
                    style: AppStyles.small.copyWith(color: AppColors.blackDisabled)
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}