import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart'; // Your scaling class
import '../bloc/event_schedule/event_schedule_bloc.dart';
import '../widgets/event_list.dart';
import '../widgets/notification_icon.dart';
import '../widgets/planner_tab_content.dart';
import '../widgets/schedule_list.dart';
import '../widgets/search_filter_bar.dart';
import '../widgets/tab_switcher.dart';
import 'package:go_router/go_router.dart';

class EventScheduleScreen extends StatelessWidget {
  const EventScheduleScreen({super.key});

  final List<String> _tabs = const ['Event', 'Schedules', 'Planner'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: [
            Container(
              width: ScreenUtilHelper.scaleWidth(153),
              height: ScreenUtilHelper.scaleHeight(39),
              margin: EdgeInsets.only(left: ScreenUtilHelper.scaleWidth(16)),
              child: Image.asset(
                'assets/images/edudibon.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Text(
                    'Logo',
                    style: TextStyle(
                      fontSize: ScreenUtilHelper.scaleText(AppStyles.size.tiny),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
        actions: [
          BlocSelector<EventScheduleBloc, EventScheduleState, int>(
            selector: (state) => state.notificationCount,
            builder: (context, notificationCount) {
              return NotificationIcon(
                count: notificationCount,
                onPressed: () {
                  context.push(AppRoutes.notifications);
                },
              );
            },
          ),
          SizedBox(width: ScreenUtilHelper.scaleWidth(8)),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.scaleWidth(16),
            vertical: ScreenUtilHelper.scaleHeight(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: <Widget>[
                  SizedBox(
                    width: ScreenUtilHelper.scaleWidth(40),
                    height: ScreenUtilHelper.scaleWidth(40),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: ScreenUtilHelper.scaleWidth(20),
                      ),
                      tooltip: 'Back',
                      padding: EdgeInsets.zero,
                      onPressed: ()=> GoRouter.of(context).pop(),
                    ),
                  ),
                  Expanded(
                    child: BlocSelector<EventScheduleBloc, EventScheduleState, int>(
                      selector: (state) => state.selectedIndex,
                      builder: (context, selectedIndex) {
                        return TabSwitcher(
                          selectedIndex: selectedIndex,
                          tabs: _tabs,
                          onTabSelected: (index) {
                            context.read<EventScheduleBloc>().add(TabChanged(index));
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
              const SearchFilterBar(),
              SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
              Expanded(
                child: BlocBuilder<EventScheduleBloc, EventScheduleState>(
                  builder: (context, state) {
                    if (state.status == DataStatus.loading &&
                        state.events.isEmpty &&
                        state.schedules.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.status == DataStatus.failure) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)),
                          child: Text(
                            'Error loading data: ${state.errorMessage ?? "Unknown error"}',
                            style: TextStyle(
                              color: AppColors.error,
                              fontSize: ScreenUtilHelper.scaleText(14),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }

                    return IndexedStack(
                      index: state.selectedIndex,
                      children: const [
                        EventListWrapper(key: PageStorageKey('eventList')),
                        ScheduleListWrapper(key: PageStorageKey('scheduleList')),
                        PlannerTabContent(key: PageStorageKey('plannerTab')),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventListWrapper extends StatelessWidget {
  const EventListWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final events = context.select((EventScheduleBloc bloc) => bloc.state.events);
    return EventList(events: events);
  }
}

class ScheduleListWrapper extends StatelessWidget {
  const ScheduleListWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final schedules = context.select((EventScheduleBloc bloc) => bloc.state.schedules);
    return ScheduleList(schedules: schedules);
  }
}
