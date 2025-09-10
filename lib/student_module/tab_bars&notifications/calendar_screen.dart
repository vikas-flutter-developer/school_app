import 'package:edudibon_flutter_bloc/cubit/calendar_cubit.dart';
import 'package:edudibon_flutter_bloc/cubit/calendar_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_decorations.dart';
import '../../core/utils/app_styles.dart';
import '../../core/utils/screen_util_helper.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  Map<DateTime, List<String>> events = {};
  bool isEventMode = false;

  @override
  void initState() {
    super.initState();
    context.read<CalendarCubit>().fetchCalendarData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            "Calendar",
            style: TextStyle(fontSize: ScreenUtilHelper.scaleText(18)),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: AppDecorations.smallPadding,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isEventMode = !isEventMode;
                });
              },
              child: Container(
                width: ScreenUtilHelper.scaleWidth(200),
                height: ScreenUtilHelper.scaleHeight(50),
                decoration: BoxDecoration(
                  color: AppColors.parchment,
                  borderRadius: AppDecorations.circleRadius,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _toggleButton("Days", !isEventMode),
                    Text(
                      " | ",
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.scaleText(AppStyles.size.bodyLarge),
                        color: AppColors.blackMediumEmphasis,
                      ),
                    ),
                    _toggleButton("Events", isEventMode),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: BlocBuilder<CalendarCubit, CalendarState>(
              builder: (context, state) {
                if (state is CalendarLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CalendarLoaded) {
                  events = state.eventsByMonth;
                  return Column(
                    children: [
                      _buildCalendarView(),
                      SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
                      if (isEventMode) _buildEventLegend(),
                      SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
                      Expanded(
                        child: isEventMode ? _buildEventsView() : Container(),
                      ),
                    ],
                  );
                } else if (state is CalendarError) {
                  return Center(child: Text(state.message));
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggleButton(String text, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.scaleWidth(20),
        vertical: ScreenUtilHelper.scaleHeight(10),
      ),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.blackHighEmphasis : Colors.transparent,
        borderRadius: AppDecorations.circleRadius,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: ScreenUtilHelper.scaleText(13),
          color: isSelected ? AppColors.white : AppColors.blackMediumEmphasis,
          fontWeight: AppStyles.weight.heading,
        ),
      ),
    );
  }

  Widget _buildCalendarView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(16)),
      child: TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime.now().subtract(const Duration(days: 365)),
        lastDay: DateTime.now().add(const Duration(days: 365)),
        calendarFormat: _calendarFormat,
        availableCalendarFormats: const {CalendarFormat.month: 'Month'},
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
          });
        },
        eventLoader: (day) => isEventMode ? (events[day] ?? []) : [],
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: AppStyles.heading.copyWith(
            fontSize: ScreenUtilHelper.scaleText(16),
          ),
        ),
        calendarStyle: CalendarStyle(
          todayDecoration: const BoxDecoration(
            color: AppColors.tertiary,
            shape: BoxShape.circle,
          ),
          selectedDecoration: const BoxDecoration(
            color: AppColors.warning,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildEventsView() {
    return ListView(
      children: (events[_selectedDay] ?? []).map(
            (event) {
          return ListTile(
            title: Text(
              event,
              style: TextStyle(fontSize: ScreenUtilHelper.scaleText(14)),
            ),
            leading: CircleAvatar(
              backgroundColor: _getEventColor(event),
              radius: ScreenUtilHelper.scaleWidth(12),
            ),
          );
        },
      ).toList(),
    );
  }

  Color _getEventColor(String event) {
    if (event.contains("Sports Day")) return Colors.blue;
    if (event.contains("Annual Day")) return Colors.red;
    return Colors.green;
  }

  Widget _buildEventLegend() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtilHelper.scaleHeight(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _legendItem(Colors.blue, "Sports Day"),
          SizedBox(width: ScreenUtilHelper.scaleWidth(10)),
          _legendItem(Colors.red, "Annual Day"),
          SizedBox(width: ScreenUtilHelper.scaleWidth(10)),
          _legendItem(Colors.green, "Other Events"),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: ScreenUtilHelper.scaleWidth(20),
          height: ScreenUtilHelper.scaleWidth(20),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: ScreenUtilHelper.scaleWidth(5)),
        Text(label, style: TextStyle(fontSize: ScreenUtilHelper.scaleText(12))),
      ],
    );
  }
}
