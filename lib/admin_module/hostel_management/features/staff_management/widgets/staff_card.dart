import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../models/staff_member.dart';

class StaffCard extends StatelessWidget {
  final StaffMember staffMember;

  const StaffCard({super.key, required this.staffMember});

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    ScreenUtilHelper.init(context);

    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtilHelper.height(2.0)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: ScreenUtilHelper.width(75),
            child: Text(
              label,
              style: AppStyles.small.copyWith(color: AppColors.black.withOpacity(0.7)),
            ),
          ),
          SizedBox(width: ScreenUtilHelper.width(8)),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: AppStyles.size.bodySmall,
                color: label == 'Staff ID'
                    ? AppColors.black
                    : AppColors.black.withOpacity(0.9),
                fontWeight:
                label == 'Staff ID' ? AppStyles.weight.emphasis : AppStyles.weight.regular,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return AppColors.errorDark;
      case 'Verified':
        return AppColors.successDark;
      case 'Blocked':
        return AppColors.warningAccent;
      default:
        return AppColors.ash;
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    String status = staffMember.status;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.width(16.0),
        vertical: ScreenUtilHelper.height(6.0),
      ),
      padding: EdgeInsets.all(ScreenUtilHelper.width(10.0)),
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            spreadRadius: ScreenUtilHelper.radius(1),
            blurRadius: ScreenUtilHelper.radius(2),
            offset: Offset(0, ScreenUtilHelper.height(1)),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(context, 'Staff ID', staffMember.id),
                SizedBox(height: ScreenUtilHelper.height(20)),
                _buildInfoRow(context, 'Department', staffMember.department),
                SizedBox(height: ScreenUtilHelper.height(5)),
                _buildInfoRow(context, 'Name', staffMember.name),
                SizedBox(height: ScreenUtilHelper.height(5)),
                _buildInfoRow(context, 'Mobile', staffMember.mobile),
                SizedBox(height: ScreenUtilHelper.height(5)),
                _buildInfoRow(context, 'Address', staffMember.address),
                SizedBox(height: ScreenUtilHelper.height(5)),
                _buildInfoRow(context, 'Type', staffMember.type),
              ],
            ),
          ),
          SizedBox(width: ScreenUtilHelper.width(12)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                status,
                style: TextStyle(
                  color: _getStatusColor(status),
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtilHelper.fontSize(10),
                ),
              ),
              SizedBox(height: ScreenUtilHelper.height(8)),
              ClipRRect(
                borderRadius:
                BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
                child: Image.asset(
                  staffMember.imageUrl,
                  height: ScreenUtilHelper.height(121),
                  width: ScreenUtilHelper.width(101),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: ScreenUtilHelper.height(121),
                    width: ScreenUtilHelper.width(101),
                    color: AppColors.cloud,
                    child: Icon(
                      Icons.person,
                      color: AppColors.white,
                      size: ScreenUtilHelper.scaleAll(30),
                    ),
                  ),
                ),
              ),
              SizedBox(height: ScreenUtilHelper.height(8)),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'More',
                  style: TextStyle(
                    color: AppColors.secondaryDarkest.withOpacity(0.8),
                    fontSize: ScreenUtilHelper.fontSize(11),
                    fontWeight: FontWeight.w500,
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