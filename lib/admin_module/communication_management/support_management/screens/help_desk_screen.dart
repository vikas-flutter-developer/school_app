import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../bloc/help_desk_bloc.dart';
import '../widgets/help_desk_chart.dart';
import '../widgets/help_desk_survey_row.dart';
import '../widgets/help_desk_ticket_card.dart';
import '../widgets/message_app_bar.dart';

class HelpDeskScreen extends StatelessWidget {
  const HelpDeskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      HelpDeskBloc()
        ..add(LoadTickets())
        ..add(LoadSurveys()),
      child: const _HelpDeskView(),
    );
  }
}

class _HelpDeskView extends StatelessWidget {
  const _HelpDeskView();

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const MessageMainScreenAppBar(title: "Help Desk"),
          backgroundColor: AppColors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: Column(
          children: [
            TabBar(
              indicatorWeight: ScreenUtilHelper.height(2.5),
              tabs: const [
                Tab(text: 'Ticket Hub'),
                Tab(text: 'Reports & Surveys')
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildTicketHubContent(context),
                  _buildReportsSurveysContent(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketHubContent(BuildContext context) {
    return BlocBuilder<HelpDeskBloc, HelpDeskState>(
      builder: (context, state) {
        if (state.isLoading && state.tickets.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.error != null && state.tickets.isEmpty) {
          return Center(child: Text('Error: ${state.error}'));
        }

        return ListView(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.width(16.0),
            vertical: ScreenUtilHelper.height(20.0),
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ticket Lists',
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.fontSize(15),
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        _showRoleSelectionDialog(context);
                      },
                      child: Container(
                        width: ScreenUtilHelper.width(103),
                        height: ScreenUtilHelper.height(27),
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtilHelper.width(12.0)),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.ash),
                          borderRadius:
                          BorderRadius.circular(ScreenUtilHelper.radius(4.0)),
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Role',
                              style: TextStyle(
                                fontSize: ScreenUtilHelper.fontSize(16),
                                color: AppColors.graphite,
                              ),
                            ),
                            SizedBox(width: ScreenUtilHelper.width(4)),
                            Icon(
                              Icons.arrow_drop_down,
                              size: ScreenUtilHelper.scaleAll(20),
                              color: AppColors.ash,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: ScreenUtilHelper.width(8)),
                    SizedBox(
                      width: ScreenUtilHelper.width(21),
                      height: ScreenUtilHelper.height(21),
                      child: IconButton(
                        icon:  Icon(
                          Icons.import_export,
                          color: AppColors.graphite,
                        ),
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: ScreenUtilHelper.height(20)),
            ...state.tickets.map(
                  (ticket) => Column(
                children: [
                  TicketCard(ticket: ticket),
                  SizedBox(height: ScreenUtilHelper.height(15)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _showRoleSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Role'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Admin'),
                onTap: ()=>GoRouter.of(context).pop(),
              ),
              ListTile(
                title: const Text('User'),
                onTap: () {
                  GoRouter.of(context).pop();
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildReportsSurveysContent(BuildContext context) {
    return BlocBuilder<HelpDeskBloc, HelpDeskState>(
      builder: (context, state) {
        if (state.isLoading && state.surveys.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.error != null && state.surveys.isEmpty) {
          return Center(child: Text('Error: ${state.error}'));
        }

        return ListView(
          padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(20.0)),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(16.0)),
              child: Text(
                'Survey Lists',
                style: TextStyle(
                  fontSize: ScreenUtilHelper.fontSize(14),
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackHint,
                ),
              ),
            ),
            SizedBox(height: ScreenUtilHelper.height(15)),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.width(16.0),
                vertical: ScreenUtilHelper.height(10.0),
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: AppColors.ash, width: ScreenUtilHelper.width(1)),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Survey Name',
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.fontSize(14),
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Start Date',
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.fontSize(14),
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'End Date',
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.fontSize(14),
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Actions',
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.fontSize(14),
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: state.surveys
                  .map(
                    (survey) =>
                    SurveyRow(
                      survey: survey,
                      onCancel: () =>
                          context.read<HelpDeskBloc>().add(
                            CancelSurvey(survey.name),
                          ),
                    ),
              )
                  .toList(),
            ),
            SizedBox(height: ScreenUtilHelper.height(30)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(16.0)),
              child: const HelpDeskChart(),
            ),
            SizedBox(height: ScreenUtilHelper.height(20)),
          ],
        );
      },
    );
  }
}