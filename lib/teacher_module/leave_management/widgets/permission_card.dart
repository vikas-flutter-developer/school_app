import 'package:flutter/material.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart';

class PermissionCard extends StatelessWidget {
  final String hours;
  final String dateRange;
  final String reason;
  final String status;
  final Color statusColor;
  final IconData statusIcon;
  final Color iconColor;

  const PermissionCard({
    super.key,
    required this.hours,
    required this.dateRange,
    required this.reason,
    required this.status,
    required this.statusColor,
    required this.statusIcon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtilHelper.scaleHeight(25)),
      child: Stack(
        children: [
          Container(
            width: ScreenUtilHelper.scaleWidth(331),
            height: ScreenUtilHelper.scaleHeight(100),
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(12)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.ash.withOpacity(0.5),
                  spreadRadius: ScreenUtilHelper.scaleWidth(2),
                  blurRadius: ScreenUtilHelper.scaleWidth(5),
                  offset: Offset(0, ScreenUtilHelper.scaleHeight(3)),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.topRight,
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: ScreenUtilHelper.scaleWidth(325),
                  height: ScreenUtilHelper.scaleHeight(100),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(7)),
                    color: AppColors.white,
                  ),
                  padding: EdgeInsets.only(left: ScreenUtilHelper.scaleWidth(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        hours,
                        style: TextStyle(
                          fontSize: ScreenUtilHelper.scaleText(AppStyles.size.medium),
                          fontWeight: AppStyles.weight.emphasis,
                          color: AppColors.primaryBright,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            dateRange,
                            style: TextStyle(
                              fontSize: ScreenUtilHelper.scaleText(AppStyles.size.medium),
                              fontWeight: AppStyles.weight.regular,
                              color: AppColors.graphite,
                            ),
                          ),
                          SizedBox(width: ScreenUtilHelper.scaleWidth(25)),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward_ios),
                            iconSize: ScreenUtilHelper.scaleWidth(18),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Text(
                        reason,
                        style: TextStyle(
                          fontSize: ScreenUtilHelper.scaleText(AppStyles.size.body),
                          fontWeight: AppStyles.weight.regular,
                          color: AppColors.graphite,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: ScreenUtilHelper.scaleHeight(-10),
                  right: ScreenUtilHelper.scaleWidth(50),
                  child: Container(
                    width: ScreenUtilHelper.scaleWidth(81),
                    height: ScreenUtilHelper.scaleHeight(22),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(5)),
                    ),
                    padding: EdgeInsets.only(left: ScreenUtilHelper.scaleWidth(4)),
                    child: Row(
                      children: [
                        Container(
                          width: ScreenUtilHelper.scaleWidth(16),
                          height: ScreenUtilHelper.scaleHeight(16),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: iconColor,
                          ),
                          child: Center(
                            child: Icon(
                              statusIcon,
                              size: ScreenUtilHelper.scaleWidth(10),
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: ScreenUtilHelper.scaleWidth(2)),
                        Text(
                          status,
                          style: TextStyle(
                            fontSize: ScreenUtilHelper.scaleText(AppStyles.size.small),
                            fontWeight: AppStyles.weight.emphasis,
                            color: iconColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
