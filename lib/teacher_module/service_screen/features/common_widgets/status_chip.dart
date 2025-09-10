import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_util_helper.dart'; // ScreenUtilHelper

enum TicketStatus { Pending, Approved, Rejected }

enum ServiceRequestStatus {
  Pending,
  Approved,
  Rejected,
}

class StatusChip extends StatelessWidget {
  final dynamic status; // Can be TicketStatus or ServiceRequestStatus

  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context); // ScreenUtilHelper

    Color backgroundColor;
    String text;

    // Handle TicketStatus
    if (status is TicketStatus) {
      switch (status as TicketStatus) {
        case TicketStatus.Pending:
          backgroundColor = AppColors.pending;
          text = 'Pending';
          break;
        case TicketStatus.Approved:
          backgroundColor = AppColors.success;
          text = 'Approved';
          break;
        case TicketStatus.Rejected:
          backgroundColor = AppColors.error;
          text = 'Rejected';
          break;
      }
    }
    // Handle ServiceRequestStatus (add if different logic needed)
    else if (status is ServiceRequestStatus) {
      switch (status as ServiceRequestStatus) {
        case ServiceRequestStatus.Pending:
          backgroundColor = AppColors.pending.withOpacity(
            0.1,
          ); // Lighter for text
          text = 'Pending';
          return Text(
            text,
            style: TextStyle(
              color: AppColors.pending, // Text color matches status
              fontWeight: AppStyles.weight.heading,
              fontSize: ScreenUtilHelper.fontSize(AppStyles.size.tinyPlus), // ScreenUtilHelper
            ),
          );
        case ServiceRequestStatus.Approved:
          backgroundColor = AppColors.success.withOpacity(0.1);
          text = 'Approved';
          return Text(
            text,
            style: TextStyle(
              color: AppColors.success,
              fontWeight: AppStyles.weight.heading,
              fontSize: ScreenUtilHelper.fontSize(AppStyles.size.tinyPlus), // ScreenUtilHelper
            ),
          );
        case ServiceRequestStatus.Rejected:
          backgroundColor = AppColors.error.withOpacity(0.1);
          text = 'Rejected';
          return Text(
            text,
            style: TextStyle(
              color: AppColors.error,
              fontWeight: AppStyles.weight.heading,
              fontSize: ScreenUtilHelper.fontSize(AppStyles.size.tinyPlus), // ScreenUtilHelper
            ),
          );
      }
    }
    // Default/Error case
    else {
      backgroundColor = Colors.grey;
      text = 'Unknown';
      return Text(
        text,
        style: TextStyle(
          color: backgroundColor,
          fontWeight: AppStyles.weight.heading,
          fontSize: ScreenUtilHelper.fontSize(AppStyles.size.tinyPlus), // ScreenUtilHelper
        ),
      );
    }

    // Default Chip style (used by Ticket List)
    return Chip(
      label: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: ScreenUtilHelper.fontSize(AppStyles.size.small), // ScreenUtilHelper
          fontWeight: AppStyles.weight.heading,
        ),
      ),
      backgroundColor: backgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.width(8), // ScreenUtilHelper
        vertical: ScreenUtilHelper.height(2), // ScreenUtilHelper
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      labelPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
    );
  }
}
