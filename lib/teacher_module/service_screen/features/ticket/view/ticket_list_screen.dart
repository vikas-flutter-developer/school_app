import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../../../../../routes/app_routes.dart';
import '../../common_widgets/status_chip.dart';
import '../bloc/ticket_list_cubit.dart';
import '../widgets/ticket_card.dart';

class TicketListScreen extends StatelessWidget {
  const TicketListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context); // <-- Added ScreenUtilHelper init

    return BlocProvider(
      create: (context) => TicketListCubit()..fetchTickets(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: Color(0xffBFBCEF),
          scrolledUnderElevation: 0,
          leading: Padding(
            padding: EdgeInsets.all(ScreenUtilHelper.width(8)), // ScreenUtilHelper
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: ScreenUtilHelper.width(24), // ScreenUtilHelper
                color: AppColors.blackHighEmphasis,
              ),
              onPressed: () => GoRouter.of(context).pop(),
            ),
          ),
          title: Text(
            'Raise Ticket',
            style: TextStyle(
              color: AppColors.blackHighEmphasis,
              fontWeight: AppStyles.weight.emphasis,
              fontSize: ScreenUtilHelper.fontSize(AppStyles.size.headingLarge), // ScreenUtilHelper
            ),
          ),
          // centerTitle: true, // Adjust as needed
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.width(16), // ScreenUtilHelper
                vertical: ScreenUtilHelper.height(10), // ScreenUtilHelper
              ),
              child: Text(
                'Raised Ticket',
                style: TextStyle(
                  fontSize: ScreenUtilHelper.fontSize(AppStyles.size.bodyLarge), // ScreenUtilHelper
                  fontWeight: AppStyles.weight.heading,
                  color: AppColors.primaryDarkest, // Or AppColors.blackHighEmphasis
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primaryDarkest.withOpacity(0.5),
                  decorationThickness: 2.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.width(16), // ScreenUtilHelper
                vertical: ScreenUtilHelper.height(8), // ScreenUtilHelper
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.add, size: ScreenUtilHelper.width(20)), // ScreenUtilHelper
                    label: const Text('New'),
                    onPressed: () {
                      context.push(AppRoutes.raiseTickets);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.blackHighEmphasis,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)), // ScreenUtilHelper
                        side: BorderSide(
                          color: AppColors.primaryDarkest.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                  // Filter Button (Implementation optional for now)
                  BlocBuilder<TicketListCubit, TicketListState>(
                    // To rebuild filter button state if needed
                    builder: (context, state) {
                      return IconButton(
                        icon: Icon(
                          Icons.filter_list,
                          color: AppColors.stone,
                          size: ScreenUtilHelper.width(24), // ScreenUtilHelper (optional)
                        ),
                        onPressed: () {
                          _showFilterDialog(context);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<TicketListCubit, TicketListState>(
                builder: (context, state) {
                  if (state is TicketListLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TicketListLoaded) {
                    if (state.tickets.isEmpty) {
                      return const Center(child: Text('No tickets found.'));
                    }
                    return ListView.builder(
                      itemCount: state.tickets.length,
                      itemBuilder: (context, index) {
                        return TicketCard(ticket: state.tickets[index]);
                      },
                    );
                  } else if (state is TicketListError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(
                      child: Text('Press fetch button.'),
                    ); // Initial state
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        // Access cubit from the parent context
        final cubit = BlocProvider.of<TicketListCubit>(context);
        return Padding(
          padding: EdgeInsets.all(ScreenUtilHelper.width(16)), // ScreenUtilHelper
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Filter by Status',
                style: TextStyle(
                  fontSize: ScreenUtilHelper.fontSize(AppStyles.size.bodyLarge), // ScreenUtilHelper
                  fontWeight: AppStyles.weight.heading,
                ),
              ),
              SizedBox(height: ScreenUtilHelper.height(10)), // ScreenUtilHelper
              ListTile(
                title: const Text('All'),
                onTap: () {
                  cubit.filterTickets(null); // Pass null for all
                  GoRouter.of(context).pop(ctx);
                },
              ),
              ListTile(
                title: const Text('Pending'),
                leading: CircleAvatar(
                  backgroundColor: AppColors.pending,
                  radius: ScreenUtilHelper.width(8), // ScreenUtilHelper
                ),
                onTap: () {
                  cubit.filterTickets(TicketStatus.Pending);
                  GoRouter.of(context).pop(ctx);
                },
              ),
              ListTile(
                title: const Text('Approved'),
                leading: CircleAvatar(
                  backgroundColor: AppColors.success,
                  radius: ScreenUtilHelper.width(8), // ScreenUtilHelper
                ),
                onTap: () {
                  cubit.filterTickets(TicketStatus.Approved);
                  GoRouter.of(context).pop(ctx);
                },
              ),
              ListTile(
                title: const Text('Rejected'),
                leading: CircleAvatar(
                  backgroundColor: AppColors.error,
                  radius: ScreenUtilHelper.width(8), // ScreenUtilHelper
                ),
                onTap: () {
                  cubit.filterTickets(TicketStatus.Rejected);
                  GoRouter.of(context).pop(ctx);
                },
              ),
              SizedBox(height: ScreenUtilHelper.height(10)), // ScreenUtilHelper
            ],
          ),
        );
      },
    );
  }
}
