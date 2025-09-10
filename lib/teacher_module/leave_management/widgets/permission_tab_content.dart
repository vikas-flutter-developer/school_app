import 'package:edudibon_flutter_bloc/teacher_module/leave_management//widgets/permission_card.dart' show PermissionCard;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:go_router/go_router.dart';
import '../../../routes/app_routes.dart';
import '../bloc/permission_bloc/permission_bloc.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart';

class PermissionTabContent extends StatelessWidget {
  const PermissionTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PermissionBloc, PermissionState>(
      builder: (context, state) {
        return Column(
          children: [
            _buildMonthSelector(),
            SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
            ...state.permissions.map(
                  (permission) => PermissionCard(
                hours: permission.hours,
                dateRange: permission.dateRange,
                reason: permission.reason,
                status: permission.status,
                statusColor: permission.statusColor,
                statusIcon: permission.statusIcon,
                iconColor: permission.iconColor,
              ),
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
            _buildNewPermissionButton(context),
            SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
          ],
        );
      },
    );
  }

  Widget _buildMonthSelector() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(16.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "March 2025",
            style: TextStyle(
              fontSize: ScreenUtilHelper.scaleText(AppStyles.size.display),
              fontWeight: AppStyles.weight.regular,
              color: AppColors.blackHint,
            ),
          ),
          Container(
            width: ScreenUtilHelper.scaleWidth(124),
            height: ScreenUtilHelper.scaleHeight(37),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(6)),
              border: Border.all(
                color: AppColors.cloud,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: ScreenUtilHelper.scaleWidth(8.0)),
                  child: Text(
                    "Months",
                    style: TextStyle(
                      fontSize: ScreenUtilHelper.scaleText(AppStyles.size.medium),
                      fontWeight: AppStyles.weight.regular,
                      color: AppColors.primaryMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: ScreenUtilHelper.scaleWidth(8.0)),
                  child: Icon(
                    Icons.calendar_month,
                    color: AppColors.primaryMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewPermissionButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(16.0)),
      child: SizedBox(
        width: ScreenUtilHelper.scaleWidth(397),
        height: ScreenUtilHelper.scaleHeight(50),
        child: ElevatedButton(
          onPressed: ()=>context.push(AppRoutes.applyPermission),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryDarkest,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(6)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle_outlined,
                size: ScreenUtilHelper.scaleWidth(24),
                color: AppColors.white,
              ),
              SizedBox(width: ScreenUtilHelper.scaleWidth(5)),
              Text(
                "New Permission",
                style: TextStyle(
                  fontSize: ScreenUtilHelper.scaleText(AppStyles.size.heading),
                  fontWeight: AppStyles.weight.emphasis,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
