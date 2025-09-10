import 'package:flutter/material.dart';

//import '../../../../utils/app_colors.dart' show AppColors.;
//import '../../../../utils/date_formatter.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/date_formatter.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../../../models/service_request.dart';

import '../../common_widgets/status_chip.dart';

class ServiceRequestCard extends StatelessWidget {
  final ServiceRequest request;

  const ServiceRequestCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.width(16), // ScreenUtilHelper
        vertical: ScreenUtilHelper.height(8),   // ScreenUtilHelper
      ),
      elevation: 1,
      color: AppColors.primaryLightest, // Explicitly white background
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10))), // ScreenUtilHelper

      child: Padding(
        padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(16.0)), // ScreenUtilHelper

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Date, Request ID, Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormatter.formatDateSimple(request.requestDate),
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.fontSize(AppStyles.size.small), // ScreenUtilHelper

                        color: AppColors.blackMediumEmphasis,
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.height(4)), // ScreenUtilHelper

                    Text(
                      'Request ID   ${request.formattedId}', // Added spacing
                      style:  TextStyle(
                        fontSize: ScreenUtilHelper.fontSize(AppStyles.size.bodySmall), // ScreenUtilHelper

                        fontWeight:AppStyles.weight.emphasis, // Semi-bold
                        color: AppColors.blackHighEmphasis,
                      ),
                    ),
                  ],
                ),
                // Status (Using the specific text style from screenshot)
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtilHelper.height(4.0)), // ScreenUtilHelper
// Align text better
                  child: StatusChip(status: request.status),
                ),
              ],
            ),
            SizedBox(height: ScreenUtilHelper.height(12)), // ScreenUtilHelper
            Divider(
              height: ScreenUtilHelper.height(1), // ScreenUtilHelper
              thickness: ScreenUtilHelper.height(0.5), // ScreenUtilHelper
            ),
            SizedBox(height: ScreenUtilHelper.height(12)), // ScreenUtilHelper


            // Details Section
            _buildDetailRow('Product', request.productName ?? 'N/A'),
            _buildDetailRow('Quantity', request.quantity?.toString() ?? 'N/A'),
            _buildDetailRow('Service', request.serviceType ?? 'N/A'),
            _buildDetailRow(
              'Priority',
              request.priority?.name ?? 'N/A',
            ), // Display enum name
            // Comment Section
            SizedBox(height: ScreenUtilHelper.height(12)), // ScreenUtilHelper

            _buildDetailRow('Comment', ''), // Label for comment area
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(10)), // ScreenUtilHelper
              margin: EdgeInsets.only(top: ScreenUtilHelper.scaleHeight(4)), // ScreenUtilHelper
              decoration: BoxDecoration(
                color: AppColors.linen.withOpacity(0.5),
                borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(6)), // ScreenUtilHelper
                // border: Border.all(color: Colors.grey.shade300),
              ),

              child: Text(
                request.comment.isEmpty
                    ? 'No comment provided.'
                    : request.comment,
                style: TextStyle(
                  fontSize: ScreenUtilHelper.fontSize(AppStyles.size.tinyPlus), // ScreenUtilHelper
                  color: AppColors.blackMediumEmphasis,
                ),

                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtilHelper.height(3.0), // ScreenUtilHelper
      ),
      // Reduced vertical padding
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: ScreenUtilHelper.width(80), // ScreenUtilHelper
            // Fixed width for labels
            child: Text(
              label,
              style:  TextStyle(
                fontSize: ScreenUtilHelper.fontSize(AppStyles.size.bodySmall), // ScreenUtilHelper

                color: AppColors.blackMediumEmphasis,
                fontWeight: AppStyles.weight.medium,
              ),
            ),
          ),
          SizedBox(width: ScreenUtilHelper.width(10)), // ScreenUtilHelper
          // Space between label and value
          Expanded(
            child: Text(
              value,
              style:  TextStyle(
                fontSize: ScreenUtilHelper.fontSize(AppStyles.size.bodySmall), // ScreenUtilHelper

                color: AppColors.blackHighEmphasis,
                fontWeight: AppStyles.weight.medium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
