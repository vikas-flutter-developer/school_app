import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../models/help_desk_models.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;
  const TicketCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    const cardBackgroundColor = Color(0xFFFEFBF3);
    const textColor = AppColors.ash;
    const labelColor = AppColors.ash;

    return Container(
      width: ScreenUtilHelper.width(364),
      height: ScreenUtilHelper.height(252),
      padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
        border: Border.all(
          color: AppColors.secondaryDivider,
          width: ScreenUtilHelper.width(0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.ash.withOpacity(0.1),
            spreadRadius: ScreenUtilHelper.radius(1),
            blurRadius: ScreenUtilHelper.radius(3),
            offset: Offset(0, ScreenUtilHelper.height(1)),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ticket : ${ticket.title}',
            style: TextStyle(
              fontSize: ScreenUtilHelper.fontSize(11),
              fontWeight: FontWeight.w600,
              color: AppColors.blackHighEmphasis,
            ),
          ),
          const Divider(
            indent: 0,
            endIndent: 0,
            color: AppColors.secondaryDivider,
          ),
          SizedBox(height: ScreenUtilHelper.height(5)),
          _buildDetailRow('Ticket ID', ticket.id, labelColor, textColor),
          _buildDetailRow('Status', ticket.status, labelColor, textColor),
          _buildDetailRow('Category', ticket.category, labelColor, textColor),
          _buildDetailRow('Raised By', ticket.raisedBy, labelColor, textColor),
          _buildDetailRow('Date', ticket.date, labelColor, textColor),
          _buildDetailRow('Issue', ticket.issue, labelColor, textColor),
          _buildDetailRowActions('Actions', labelColor, context),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
      String label,
      String value,
      Color? labelColor,
      Color? valueColor,
      ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(3.0)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: ScreenUtilHelper.width(80),
            child: Text(
              label,
              style: TextStyle(
                fontSize: ScreenUtilHelper.fontSize(10),
                color: labelColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Text(':',
              style: TextStyle(
                  fontSize: ScreenUtilHelper.fontSize(13), color: labelColor)),
          SizedBox(width: ScreenUtilHelper.width(10)),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: ScreenUtilHelper.fontSize(9),
                color: valueColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRowActions(
      String label, Color? labelColor, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(2.0)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: ScreenUtilHelper.width(80),
            child: Text(
              label,
              style: TextStyle(
                fontSize: ScreenUtilHelper.fontSize(13),
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(':',
              style: TextStyle(
                  fontSize: ScreenUtilHelper.fontSize(13), color: labelColor)),
          SizedBox(width: ScreenUtilHelper.width(10)),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Icon(Icons.check_circle,
                    color: AppColors.success,
                    size: ScreenUtilHelper.scaleAll(18)),
                SizedBox(width: ScreenUtilHelper.width(4)),
                Text(
                  'Approve',
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.fontSize(13),
                    color: AppColors.success,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: ScreenUtilHelper.width(15)),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Icon(Icons.cancel,
                    color: AppColors.error,
                    size: ScreenUtilHelper.scaleAll(18)),
                SizedBox(width: ScreenUtilHelper.width(4)),
                Text(
                  'Reject',
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.fontSize(13),
                    color: AppColors.error,
                    fontWeight: FontWeight.w500,
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