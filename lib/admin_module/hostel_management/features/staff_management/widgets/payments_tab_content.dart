import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import 'attendance_overview_page.dart';

class PaymentsTabContent extends StatelessWidget {
  const PaymentsTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: ScreenUtilHelper.height(30)),
          const SizedBox(
            width: double.infinity,
            child: AttendanceOverviewPage(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtilHelper.width(16.0),
              vertical: ScreenUtilHelper.height(16.0),
            ),
            child: Column(
              children: [
                _buildPaymentRow(
                  name: "Vishnu Pratap",
                  issue: "Bank Issues",
                  status: "Pending",
                  issueColor: AppColors.tertiaryMedium,
                  statusColor: AppColors.tertiaryMedium,
                ),
                SizedBox(height: ScreenUtilHelper.height(10)),
                _buildPaymentRow(
                  name: "Manoj Mishra",
                  issue: "Incomplete work",
                  status: "On Hold",
                  issueColor: AppColors.error,
                  statusColor: AppColors.error,
                ),
                SizedBox(height: ScreenUtilHelper.height(10)),
                _buildPaymentRow(
                  name: "Vishnu Pratap",
                  issue: "Bank Issues",
                  status: "Pending",
                  issueColor: AppColors.tertiaryMedium,
                  statusColor: AppColors.tertiaryMedium,
                ),
                SizedBox(height: ScreenUtilHelper.height(10)),
                _buildPaymentRow(
                  name: "Manoj Mishra",
                  issue: "Incomplete work",
                  status: "On Hold",
                  issueColor: AppColors.error,
                  statusColor: AppColors.error,
                ),
                SizedBox(height: ScreenUtilHelper.height(10)),
                _buildPaymentRow(
                  name: "Vishnu Pratap",
                  issue: "Bank Issues",
                  status: "Pending",
                  issueColor: AppColors.tertiaryMedium,
                  statusColor: AppColors.tertiaryMedium,
                ),
                SizedBox(height: ScreenUtilHelper.height(10)),
                _buildPaymentRow(
                  name: "Manoj Mishra",
                  issue: "Incomplete work",
                  status: "On Hold",
                  issueColor: AppColors.error,
                  statusColor: AppColors.error,
                ),
                SizedBox(height: ScreenUtilHelper.height(16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentRow({
    required String name,
    required String issue,
    required String status,
    required Color issueColor,
    required Color statusColor,
  }) {
    return Container(
      width: double.infinity,
      height: ScreenUtilHelper.height(30),
      color: AppColors.ivory,
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(8.0)),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: AppStyles.small.copyWith(color: AppColors.black),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              issue,
              textAlign: TextAlign.center,
              style: AppStyles.badge1.copyWith(color: issueColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              status,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: ScreenUtilHelper.fontSize(12),
                fontWeight: FontWeight.w400,
                color: statusColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}