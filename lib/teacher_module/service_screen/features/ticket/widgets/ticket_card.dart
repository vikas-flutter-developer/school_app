import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/date_formatter.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../../../models/ticket.dart';
import '../../common_widgets/status_chip.dart';
import '../bloc/ticket_list_cubit.dart';



class TicketCard extends StatelessWidget {
  final Ticket ticket;

  const TicketCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context); // <-- Added ScreenUtilHelper init

    String subtitle = '';
    if (ticket.status == TicketStatus.Pending && ticket.approvalFrom != null) {
      subtitle = 'Pending Approval From\n${ticket.approvalFrom}';
    } else if (ticket.status == TicketStatus.Approved &&
        ticket.approvalFrom != null) {
      subtitle = 'Approval From\n${ticket.approvalFrom}';
    } else if (ticket.status == TicketStatus.Rejected &&
        ticket.rejectionFrom != null) {
      subtitle = 'Rejected From\n${ticket.rejectionFrom}';
    }

    return Card(
      color: AppColors.white,
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.width(16), // ScreenUtilHelper
        vertical: ScreenUtilHelper.height(8),    // ScreenUtilHelper
      ),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)), // ScreenUtilHelper
      ),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilHelper.width(16)), // ScreenUtilHelper
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StatusChip(status: ticket.status),
                Row(
                  children: [
                    Icon(Icons.send, size: ScreenUtilHelper.width(16), color: AppColors.stone), // ScreenUtilHelper
                    SizedBox(width: ScreenUtilHelper.width(4)), // ScreenUtilHelper
                    Text(
                      DateFormatter.formatDateTime(ticket.submittedDate),
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.fontSize(AppStyles.size.small), // ScreenUtilHelper
                        color: AppColors.stone,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: ScreenUtilHelper.height(12)), // ScreenUtilHelper
            Text(
              ticket.category,
              style: TextStyle(
                fontSize: ScreenUtilHelper.fontSize(AppStyles.size.bodyMedium), // ScreenUtilHelper
                fontWeight: AppStyles.weight.heading,
                color: AppColors.blackHighEmphasis,
              ),
            ),
            SizedBox(height: ScreenUtilHelper.height(4)), // ScreenUtilHelper
            Text(
              DateFormatter.formatDateRange(ticket.startDate, ticket.endDate),
              style: TextStyle(
                fontSize: ScreenUtilHelper.fontSize(AppStyles.size.tinyPlus), // ScreenUtilHelper
                color: AppColors.blackMediumEmphasis,
              ),
            ),
            SizedBox(height: ScreenUtilHelper.height(12)), // ScreenUtilHelper
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.fontSize(AppStyles.size.tinyPlus), // ScreenUtilHelper
                        color: AppColors.blackMediumEmphasis,
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.height(8)), // ScreenUtilHelper
                    Text(
                      'Ticket Id : ${ticket.id}',
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.fontSize(AppStyles.size.tinyPlus), // ScreenUtilHelper
                        color: AppColors.blackMediumEmphasis,
                        fontWeight: AppStyles.weight.medium,
                      ),
                    ),
                  ],
                ),
                if (ticket.status == TicketStatus.Pending)
                  ElevatedButton(
                    onPressed: () {
                      // Show confirmation dialog before cancelling
                      showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return AlertDialog(
                            title: const Text('Confirm Cancellation'),
                            content: Text(
                              'Are you sure you want to cancel ticket ${ticket.id}?',
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('No'),
                                onPressed: () {
                                  GoRouter.of(ctx).pop();
                                },
                              ),
                              TextButton(
                                child: Text(
                                  'Yes',
                                  style: TextStyle(color: AppColors.error),
                                ),
                                onPressed: () {
                                  // Call the cubit method
                                  context.read<TicketListCubit>().cancelTicket(
                                    ticket.id,
                                  );
                                  GoRouter.of(ctx).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.linen,
                      foregroundColor: AppColors.stone, // Text color
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.width(16), // ScreenUtilHelper
                        vertical: ScreenUtilHelper.height(8),   // ScreenUtilHelper
                      ),
                      textStyle: TextStyle(
                        fontSize: ScreenUtilHelper.fontSize(AppStyles.size.tinyPlus), // ScreenUtilHelper
                        fontWeight: AppStyles.weight.heading,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(6)), // ScreenUtilHelper
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
