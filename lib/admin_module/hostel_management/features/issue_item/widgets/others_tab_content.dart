import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';

class OthersTabContent extends StatelessWidget {
  const OthersTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context); // Ensure screen init

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.width(16),
          ),
          child: Column(
            children: [
              SizedBox(height: ScreenUtilHelper.height(20)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.width(16),
                ),
                child: Column(
                  children: [
                    _buildInfoRow("Mayuri Shah", "21/02/25", "03/02/25"),
                    _buildStatusRow("Bucket", "Issued", AppColors.success, "Return", AppColors.ash),
                    SizedBox(height: ScreenUtilHelper.height(20)),
                    _buildInfoRow("Mayuri Shah", "21/02/25", "03/02/25"),
                    _buildStatusRow("Bucket", "Issued", AppColors.ash, "Return", AppColors.warningSecondary),
                    SizedBox(height: ScreenUtilHelper.height(20)),
                    _buildInfoRow("Mayuri Shah", "21/02/25", "03/02/25", secondColor: AppColors.ash),
                    _buildStatusRow("Bucket", "Issued", AppColors.ash, "Damaged", AppColors.error, leftPadding: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: ScreenUtilHelper.width(16),
          bottom: ScreenUtilHelper.height(70),
          child: SizedBox(
            width: ScreenUtilHelper.width(109),
            height: ScreenUtilHelper.height(30),
            child: ElevatedButton(
              onPressed: () {
                print("Button pressed!");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryContrast,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(6)),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Create",
                    style: AppStyles.bodySmall,
                  ),
                  Icon(Icons.add, size: ScreenUtilHelper.fontSize(18)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String name, String date1, String date2, {Color? secondColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: AppStyles.bodySmall,
        ),
        Text(
          date1,
          style: AppStyles.bodySmall.copyWith(color: secondColor),
        ),
        Text(
          date2,
          style: AppStyles.bodySmall,
        ),
      ],
    );
  }

  Widget _buildStatusRow(
      String label,
      String status1,
      Color color1,
      String status2,
      Color color2, {
        double leftPadding = 20,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppStyles.bodySmall.copyWith(color: AppColors.black),
        ),
        Padding(
          padding: EdgeInsets.only(left: ScreenUtilHelper.width(leftPadding)),
          child: Text(
            status1,
            style: AppStyles.bodySmall.copyWith(color: color1),
          ),
        ),
        Text(
          status2,
          style: AppStyles.bodySmall.copyWith(color: color2),
        ),
      ],
    );
  }
}
