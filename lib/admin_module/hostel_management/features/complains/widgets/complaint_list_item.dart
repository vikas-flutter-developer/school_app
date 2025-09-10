import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../../../../../routes/app_routes.dart';
import '../models/complaint_model.dart';
import '../screens/complaint_form_screen.dart';

class ComplaintListItem extends StatelessWidget {
  final ComplaintModel complaint;

  const ComplaintListItem({super.key, required this.complaint});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    Color statusColor = AppColors.black;
    switch (complaint.status.toLowerCase()) {
      case 'pending':
        statusColor = AppColors.error;
        break;
      case 'resolved':
        statusColor = AppColors.success;
        break;
      case 'cancelled':
        statusColor = AppColors.warning;
        break;
    }

    return Container(
      margin: EdgeInsets.only(bottom: ScreenUtilHelper.height(12.0)),
      padding: EdgeInsets.all(ScreenUtilHelper.width(8.0)),
      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.all(Radius.circular(ScreenUtilHelper.radius(8.0))),
        color: AppColors.ivory,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: ScreenUtilHelper.width(90),
                child: Text(
                  'Complain ID',
                  style: AppStyles.small.copyWith(color: AppColors.black),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(width: ScreenUtilHelper.width(8)),
              Text(
                complaint.id,
                style: AppStyles.bodySmallEmphasis.copyWith(color: AppColors.black),
              ),
              const Spacer(),
              Text(
                complaint.date,
                style: TextStyle(
                  color: AppColors.ash,
                  fontSize: AppStyles.size.tiny,
                  fontWeight: AppStyles.weight.regular,
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenUtilHelper.height(4)),
          Row(
            children: [
              SizedBox(
                width: ScreenUtilHelper.width(90),
                child: Text(
                  'Subject',
                  style: AppStyles.small.copyWith(color: AppColors.black),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(width: ScreenUtilHelper.width(8)),
              Text(
                complaint.subject,
                style: AppStyles.bodySmall.copyWith(color: AppColors.black),
              ),
            ],
          ),
          SizedBox(height: ScreenUtilHelper.height(4)),
          Row(
            children: [
              SizedBox(
                width: ScreenUtilHelper.width(90),
                child: Text(
                  'Status',
                  style: AppStyles.small.copyWith(color: AppColors.black),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(width: ScreenUtilHelper.width(8)),
              Text(
                complaint.status,
                style: AppStyles.bodySmall.copyWith(color: AppColors.black),
              ),
            ],
          ),
          SizedBox(height: ScreenUtilHelper.height(4)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: ScreenUtilHelper.width(90),
                    child: Text(
                      'Action',
                      style: AppStyles.bodySmall.copyWith(color: AppColors.black),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(width: ScreenUtilHelper.width(8)),
                  Text(
                    complaint.action,
                    style: AppStyles.bodySmall.copyWith(color: AppColors.black),
                  ),
                ],
              ),
              TextButton(
                onPressed: ()=>context.push(AppRoutes.hostelComplaintForm),
                child: Text(
                  'Take Action',
                  style: AppStyles.small.copyWith(color: AppColors.secondaryContrast),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}