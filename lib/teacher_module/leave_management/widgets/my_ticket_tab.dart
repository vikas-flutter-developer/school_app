import 'package:flutter/material.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart';

class MyTicketTab extends StatelessWidget {
  const MyTicketTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(right: ScreenUtilHelper.scaleWidth(16)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Filters", style: TextStyle(fontSize: ScreenUtilHelper.scaleText(14))),
              Icon(Icons.filter_alt_rounded, size: ScreenUtilHelper.scaleWidth(20),color: AppColors.ash),
            ],
          ),
        ),
        SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
        _buildTicketCard(
          status: "Pending",
          statusColor: AppColors.pending,
          title: "Casual leave request",
          dateRange: "Jan 21 - Jan 22, 2025",
          statusText: "Pending Approval",
        ),
        SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
        _buildTicketCard(
          status: "Approved",
          statusColor: AppColors.successDark,
          title: "Casual leave request",
          dateRange: "Jan 21 - Jan 22, 2025",
          statusText: "Approval From",
        ),
        SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
        _buildTicketCard(
          status: "Rejected",
          statusColor: AppColors.errorDark,
          title: "Casual leave request",
          dateRange: "Jan 21 - Jan 22, 2025",
          statusText: "Rejected From",
        ),
      ],
    );
  }

  Widget _buildTicketCard({
    required String status,
    required Color statusColor,
    required String title,
    required String dateRange,
    required String statusText,
  }) {
    return Container(
      width: ScreenUtilHelper.scaleWidth(354),
      height: ScreenUtilHelper.scaleHeight(150),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(7)),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Color of the shadow
            spreadRadius: 2, // How far the shadow spreads
            blurRadius: 5, // The blur intensity of the shadow
            offset: Offset(0, 2), // The position of the shadow (horizontal, vertical)
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: ScreenUtilHelper.scaleWidth(84),
                  height: ScreenUtilHelper.scaleHeight(22),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(3)),
                  ),
                  child: Center(
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: AppStyles.size.small,
                        fontWeight: AppStyles.weight.emphasis,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.send, size: ScreenUtilHelper.scaleWidth(16)),
                    SizedBox(width: ScreenUtilHelper.scaleWidth(4)),
                    Text(
                      "Jan 20, 7:40 pm",
                      style: TextStyle(
                        fontSize: AppStyles.size.tiny,
                        fontWeight: AppStyles.weight.emphasis,
                        color: AppColors.ash,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(5)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: AppStyles.size.bodySmall,
                    fontWeight: AppStyles.weight.emphasis,
                    color: AppColors.graphite,
                  ),
                ),
                Text(
                  dateRange,
                  style: TextStyle(
                    fontSize: AppStyles.size.small,
                    fontWeight: AppStyles.weight.regular,
                    color: AppColors.graphite,
                  ),
                ),
                SizedBox(height: ScreenUtilHelper.scaleHeight(11)),
                Text(
                  statusText,
                  style: TextStyle(
                    fontSize: AppStyles.size.small,
                    fontWeight: AppStyles.weight.regular,
                    color: AppColors.charcoal,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Management",
                  style: TextStyle(
                    fontSize: AppStyles.size.small,
                    fontWeight: AppStyles.weight.emphasis,
                    color: AppColors.graphite,
                  ),
                ),
                Container(
                  width: ScreenUtilHelper.scaleWidth(78),
                  height: ScreenUtilHelper.scaleHeight(24),
                  decoration: BoxDecoration(
                    color: AppColors.cloud,
                    borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(3)),
                  ),
                  child: Center(
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: AppStyles.size.body,
                        fontWeight: AppStyles.weight.emphasis,
                        color: AppColors.graphite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
