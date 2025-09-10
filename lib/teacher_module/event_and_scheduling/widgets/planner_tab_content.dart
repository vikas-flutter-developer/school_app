import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';
import '../bloc/event_schedule/event_schedule_bloc.dart'
    show
    EventScheduleBloc,
    PlannerDateSelected,
    PlannerMonthChanged,
    PlannerToggleCalendarVisibility;
import 'calendar_grid.dart';

class PlannerTabContent extends StatelessWidget {
  const PlannerTabContent({super.key});

  static const List<String> _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  static const List<String> _dayNumbers = ['?', '?', '?', '?', '?', '?'];
  static const List<String> _timeSlots = [
    '08:00',
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
  ];

  @override
  Widget build(BuildContext context) {
    final isCalendarVisible = context.select(
          (EventScheduleBloc bloc) => bloc.state.isPlannerCalendarVisible,
    );
    final focusedDay = context.select(
          (EventScheduleBloc bloc) => bloc.state.plannerFocusedDay,
    );
    final selectedDay = context.select(
          (EventScheduleBloc bloc) => bloc.state.plannerSelectedDay,
    );
    final bloc = context.read<EventScheduleBloc>();

    return Stack(
      children: [
        Visibility(
          visible: !isCalendarVisible,
          maintainState: true,
          child: _buildPlannerView(context, focusedDay, selectedDay),
        ),
        Visibility(
          visible: isCalendarVisible,
          child: Positioned(
            top: ScreenUtilHelper.scaleHeight(60),
            left: ScreenUtilHelper.scaleWidth(10),
            right: ScreenUtilHelper.scaleWidth(10),
            child: Material(
              elevation: 4.0,
              shadowColor: AppColors.pending,
              borderRadius:
              BorderRadius.circular(ScreenUtilHelper.scaleWidth(10)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CalendarGrid(
                    focusedDay: focusedDay,
                    selectedDay: selectedDay,
                    onDateTap: (date) {
                      if (date != null) {
                        bloc.add(PlannerDateSelected(date));
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      ScreenUtilHelper.scaleWidth(12),
                      0,
                      ScreenUtilHelper.scaleWidth(12),
                      ScreenUtilHelper.scaleHeight(12),
                    ),
                    child: _buildCalendarLegend(),
                  ),
                ],
              ),
            ),
          ),
        ),
        _buildMonthSelector(context, focusedDay, isCalendarVisible, bloc),
      ],
    );
  }

  Widget _buildMonthSelector(
      BuildContext context,
      DateTime focusedDay,
      bool isCalendarVisible,
      EventScheduleBloc bloc,
      ) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        color: AppColors.white,
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtilHelper.scaleWidth(8),
          vertical: ScreenUtilHelper.scaleHeight(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              iconSize: ScreenUtilHelper.scaleWidth(18),
              onPressed: () =>
                  bloc.add(const PlannerMonthChanged(isNext: false)),
            ),
            Row(
              children: [
                Text(
                  DateFormat('MMMM yyyy').format(focusedDay),
                  style: TextStyle(
                    fontSize:
                    ScreenUtilHelper.scaleText(AppStyles.size.bodyLarge),
                    fontWeight: AppStyles.weight.heading,
                  ),
                ),
                SizedBox(width: ScreenUtilHelper.scaleWidth(4)),
                IconButton(
                  iconSize: ScreenUtilHelper.scaleWidth(20),
                  padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(4)),
                  constraints: const BoxConstraints(),
                  tooltip:
                  isCalendarVisible ? 'Hide Calendar' : 'Show Calendar',
                  onPressed: () =>
                      bloc.add(PlannerToggleCalendarVisibility()),
                  icon: Icon(
                    isCalendarVisible
                        ? Icons.calendar_month
                        : Icons.calendar_today_outlined,
                    color: isCalendarVisible
                        ? Theme.of(context).primaryColor
                        : AppColors.slate,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              iconSize: ScreenUtilHelper.scaleWidth(18),
              onPressed: () =>
                  bloc.add(const PlannerMonthChanged(isNext: true)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlannerView(
      BuildContext context,
      DateTime focusedDay,
      DateTime? selectedDay,
      ) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: ScreenUtilHelper.scaleHeight(70),
        bottom: ScreenUtilHelper.scaleHeight(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMiniCalendar(context, focusedDay, selectedDay),
          SizedBox(height: ScreenUtilHelper.scaleHeight(25)),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.scaleWidth(16)),
            child: Text(
              selectedDay != null
                  ? (DateUtils.isSameDay(selectedDay, DateTime.now())
                  ? 'Today'
                  : DateFormat('EEEE, MMM d').format(selectedDay))
                  : (DateUtils.isSameDay(focusedDay, DateTime.now())
                  ? 'Today'
                  : DateFormat('EEEE, MMM d').format(focusedDay)),
              style: TextStyle(
                fontSize:
                ScreenUtilHelper.scaleText(AppStyles.size.heading),
                fontWeight: AppStyles.weight.emphasis,
              ),
            ),
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(15)),
          _buildTimeSlotsAndEvents(
              context, selectedDay ?? focusedDay),
        ],
      ),
    );
  }

  Widget _buildMiniCalendar(
      BuildContext context,
      DateTime focusedDay,
      DateTime? selectedDay,
      ) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtilHelper.scaleWidth(12)),
      child: SizedBox(
        height: ScreenUtilHelper.scaleHeight(75),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 7,
          itemBuilder: (context, index) {
            final dayNumber = _dayNumbers[index % _dayNumbers.length];
            final dayName = _days[index % _days.length];
            bool isSelected = false;

            return Container(
              width: ScreenUtilHelper.scaleWidth(52),
              margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.scaleWidth(4)),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).primaryColorLight.withOpacity(0.5)
                    : AppColors.white,
                borderRadius:
                BorderRadius.circular(ScreenUtilHelper.scaleWidth(8)),
                border: isSelected
                    ? Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 1.5,
                )
                    : null,
              ),
              child: Material(
                color: AppColors.transparent,
                child: InkWell(
                  onTap: () {
                    // TODO: Handle day tap
                  },
                  borderRadius:
                  BorderRadius.circular(ScreenUtilHelper.scaleWidth(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        dayNumber,
                        style: TextStyle(
                          fontSize: ScreenUtilHelper
                              .scaleText(AppStyles.size.body),
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected
                              ? Theme.of(context).primaryColorDark
                              : AppColors.blackHighEmphasis,
                        ),
                      ),
                      SizedBox(height: ScreenUtilHelper.scaleHeight(4)),
                      Text(
                        dayName,
                        style: TextStyle(
                          fontSize: ScreenUtilHelper
                              .scaleText(AppStyles.size.small),
                          color: isSelected
                              ? Theme.of(context).primaryColorDark
                              : AppColors.slate,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTimeSlotsAndEvents(
      BuildContext context,
      DateTime dayToShowEventsFor,
      ) {
    final double hourSlotHeight = ScreenUtilHelper.scaleHeight(60);
    double timeLabelWidth = ScreenUtilHelper.scaleWidth(55);
    double horizontalPadding = ScreenUtilHelper.scaleWidth(16 * 2);
    double eventLeftMargin = ScreenUtilHelper.scaleWidth(5);
    double availableEventWidth =
        MediaQuery.of(context).size.width -
            timeLabelWidth -
            horizontalPadding -
            eventLeftMargin;

    final exampleEventStartHour = 9.5;
    final exampleEventDurationHours = 2.0;

    return Container(
      height: hourSlotHeight * _timeSlots.length,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.scaleWidth(16),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: timeLabelWidth,
            child: Column(
              children: _timeSlots
                  .map((time) => SizedBox(
                height: hourSlotHeight,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding:
                    EdgeInsets.only(top: ScreenUtilHelper.scaleHeight(0)),
                    child: Text(
                      time,
                      style: TextStyle(
                        color: AppColors.stone,
                        fontSize: ScreenUtilHelper
                            .scaleText(AppStyles.size.small),
                      ),
                    ),
                  ),
                ),
              ))
                  .toList(),
            ),
          ),
          Positioned.fill(
            left: timeLabelWidth,
            child: Column(
              children: List.generate(
                _timeSlots.length,
                    (index) => Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            color: AppColors.white, width: 1),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: (exampleEventStartHour - 8) * hourSlotHeight,
            left: timeLabelWidth + eventLeftMargin,
            width: availableEventWidth,
            height: exampleEventDurationHours * hourSlotHeight - 4,
            child: Material(
              borderRadius: BorderRadius.circular(
                  ScreenUtilHelper.scaleWidth(6)),
              color: AppColors.pending,
              child: InkWell(
                onTap: () {},
                borderRadius:
                BorderRadius.circular(ScreenUtilHelper.scaleWidth(6)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilHelper.scaleWidth(8),
                    vertical: ScreenUtilHelper.scaleHeight(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Teacher's Meeting",
                        style: TextStyle(
                          fontSize: ScreenUtilHelper.scaleText(13),
                          color: AppColors.white,
                          fontWeight: AppStyles.weight.emphasis,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "09:30 - 11:30 AM",
                          style: TextStyle(
                            fontSize: ScreenUtilHelper
                                .scaleText(AppStyles.size.tiny),
                            color: AppColors.ash,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarLegend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _legendItem(AppColors.paymentLeadingBg, "Meetings"),
        _legendItem(AppColors.stone, "Holidays"),
        _legendItem(AppColors.pendingLight, "Visit"),
      ],
    );
  }

  Widget _legendItem(Color color, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtilHelper.scaleHeight(5)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: ScreenUtilHelper.scaleWidth(15),
            height: ScreenUtilHelper.scaleWidth(15),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(
                  ScreenUtilHelper.scaleWidth(3)),
            ),
          ),
          SizedBox(width: ScreenUtilHelper.scaleWidth(8)),
          Text(
            text,
            style: TextStyle(
              fontSize:
              ScreenUtilHelper.scaleText(AppStyles.size.tiny),
              color: AppColors.blackHighEmphasis,
            ),
          ),
        ],
      ),
    );
  }
}
