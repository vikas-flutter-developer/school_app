import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/app_decorations.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/screen_util_helper.dart';
import '../../widgets/time_table_widgets/custom_app_bar.dart';
import '../../widgets/time_table_widgets/sehedule_row.dart';
import '../../widgets/time_table_widgets/tab_item.dart';
import 'bloc/app_tab/app_tab_bloc.dart';
import 'bloc/timetable_bloc.dart';

class TimetableScreen1 extends StatelessWidget {
  const TimetableScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    int initialDayId = max(0, min(5, DateTime.now().weekday - 1));

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TimetableBloc()..add(FetchTimetable(dayId: initialDayId)),
        ),
        BlocProvider(create: (_) => AppTabBloc()),
      ],
      child: const HomeScreenContent(),
    );
  }
}

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    final horizontalPadding = ScreenUtilHelper.width(15);
    final verticalPadding = ScreenUtilHelper.height(12);

    Widget pageContent;
      pageContent = BlocBuilder<AppTabBloc, AppTabState>(
        builder: (context, state) {
          if (state.mainTabIndex == 0) {
            print(horizontalPadding);
            print(verticalPadding);
            return _buildTimetableScreen(context, horizontalPadding, verticalPadding);
          } else {
            return _buildExamEventsScreen(context, horizontalPadding, state.examEventsTabIndex);
          }
        },
      );

    return Scaffold(
backgroundColor: AppColors.white,
      appBar: const CustomAppBar(),
      body: pageContent,
    );
  }

  Widget _buildTimetableScreen(
      BuildContext context, double hPadding, double vPadding) {
    final smallFontSize = ScreenUtilHelper.fontSize(13);
    final normalFontSize = ScreenUtilHelper.fontSize(16);

    return Column(
      children: [
        SizedBox(height: ScreenUtilHelper.height(12)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: hPadding),
          child: Row(
            children: List.generate(6, (index) {
              final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
              return BlocBuilder<TimetableBloc, TimetableState>(
                buildWhen: (previous, current) =>
                previous.selectedDay != current.selectedDay,
                builder: (context, state) {
                  return TabItem(
                    tabName: days[index],
                    isSelected: state.selectedDay == index,
                    onTap: () {
                      context.read<TimetableBloc>().add(ChangeDay(dayId: index));
                    },
                  );
                },
              );
            }),
          ),
        ),
        SizedBox(height: ScreenUtilHelper.height(12)),
        Expanded(
          child: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  vertical: ScreenUtilHelper.height(10),
                  horizontal: ScreenUtilHelper.width(10)),
              decoration: BoxDecoration(
                color: AppColors.ivory,
                borderRadius: AppDecorations.normalRadius,
              ),
              child: BlocBuilder<TimetableBloc, TimetableState>(
                builder: (context, state) {
                  if (state.status == TimetableStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status == TimetableStatus.failure) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: hPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline,
                                color: AppColors.errorAccent,
                                size: ScreenUtilHelper.width(36)),
                            SizedBox(height: ScreenUtilHelper.height(16)),
                            Text(
                              state.errorMessage.isNotEmpty
                                  ? state.errorMessage
                                  : 'Failed to load timetable.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: normalFontSize),
                            ),
                            SizedBox(height: ScreenUtilHelper.height(16)),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.refresh),
                              label:
                              Text('Retry', style: TextStyle(fontSize: smallFontSize)),
                              onPressed: () {
                                context
                                    .read<TimetableBloc>()
                                    .add(FetchTimetable(dayId: state.selectedDay ?? 0));
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final periods =
                  _getCurrentDayPeriods(state.timetableData, state.selectedDay ?? 0);

                  return ListView(
                    children: _buildScheduleRows(periods!, context),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<dynamic>? _getCurrentDayPeriods(dynamic timetableData, int selectedDayIndex) {
    return [];
  }

  List<Widget> _buildScheduleRows(List<dynamic> periods, BuildContext context) {
    final widgets = <Widget>[];

    final List<Map<String, String>> staticPeriods = List.generate(6, (index) {
      return {
        "start": "11:00 am",
        "end": "11:50 am",
        "subject": "Subject",
        "teacher": "Teacher name",
        "assignment": "Homework/Assignment",
        "date": "20/03/2025"
      };
    });

    for (int index = 0; index < staticPeriods.length + 1; index++) {
      if (index == 4) {
        widgets.add(
            Padding(
              padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(8)),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.purple,
                      thickness: 1,
                      endIndent: 8, // space between line and text
                    ),
                  ),
                  Text(
                    "LUNCH BREAK",
                    style: TextStyle(
                      fontSize: ScreenUtilHelper.fontSize(14),
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.purple,
                      thickness: 1,
                      indent: 8, // space between text and line
                    ),
                  ),
                ],
              ),
            )
        );
        continue;
      }

      final periodIndex = index > 4 ? index - 1 : index;
      final period = staticPeriods[periodIndex];

      widgets.add(
        Container(
          margin: EdgeInsets.only(bottom: ScreenUtilHelper.height(8)),
          child: ScheduleRow(
            startTime: period["start"]!,
            endTime: period["end"]!,
            subject: period["subject"]!,
            teacher: period["teacher"]!,
            date: period["date"]!,
          ),
        ),
      );
    }

    return widgets;
  }


  Widget _buildExamEventsScreen(BuildContext context, double hPadding, int selectedTabIndex) {

    final TextStyle dateTextStyle = TextStyle(
      fontSize: ScreenUtilHelper.fontSize(14),
      fontWeight: FontWeight.w500,
    );

    final TextStyle subjectTitleStyle = TextStyle(
      fontSize: ScreenUtilHelper.fontSize(16),
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

    final TextStyle normalWhiteText = TextStyle(
      fontSize: ScreenUtilHelper.fontSize(12),
      color: Colors.white70,
    );

    final exams = [
      {
        'date': 'April 24, 2025',
        'subject': 'Exam Subject',
        'timing': 'Exam timing',
        'invigilator': 'Invigilator name',
        'marks': 'Full marks',
      },
      {
        'date': 'April 24, 2025',
        'subject': 'Exam Subject',
        'timing': 'Exam timing',
        'invigilator': 'Invigilator name',
        'marks': 'Full marks',
      },
      {
        'date': 'April 24, 2025',
        'subject': 'Exam Subject',
        'timing': 'Exam timing',
        'invigilator': 'Invigilator name',
        'marks': 'Full marks',
      },
      {
        'date': '23.4.2025',
        'subject': 'Exam Subject',
        'timing': 'Exam timing',
        'invigilator': 'Invigilator name',
        'marks': 'Full marks',
      },
    ];

    final events = [
      {
        'date': 'April 26, 2025',
        'event': 'Event Name',
        'timing': 'Event timing',
        'coordinator': 'Coordinator name',
        'location': 'Event location',
      },
      {
        'date': 'April 27, 2025',
        'event': 'Event Name',
        'timing': 'Event timing',
        'coordinator': 'Coordinator name',
        'location': 'Event location',
      },
    ];

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: hPadding),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.read<AppTabBloc>().add(const ExamEventsTabChanged(0));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(8)),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: selectedTabIndex == 0 ? AppColors.selected : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      "Upcoming exams",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: selectedTabIndex == 0 ? FontWeight.bold : FontWeight.normal,
                        color: selectedTabIndex == 0 ? AppColors.black : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.read<AppTabBloc>().add(const ExamEventsTabChanged(1));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(8)),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: selectedTabIndex == 1 ? AppColors.selected : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      "Upcoming events",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: selectedTabIndex == 1 ? FontWeight.bold : FontWeight.normal,
                        color: selectedTabIndex == 1 ? AppColors.black : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: ScreenUtilHelper.height(10)),
        // The fix is here. The Expanded is the direct child of the Column.
        Expanded(
          child: Container(
            color: AppColors.ivory,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: hPadding),
              child: ListView.separated(
                itemCount: selectedTabIndex == 0 ? exams.length : events.length,
                separatorBuilder: (context, index) => SizedBox(height: ScreenUtilHelper.height(12)),
                itemBuilder: (context, index) {
                  // The rest of the `itemBuilder` logic remains the same.
                  if (selectedTabIndex == 0) {
                    final exam = exams[index];
                    return Container(
                      padding: EdgeInsets.all(ScreenUtilHelper.width(12)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: ScreenUtilHelper.width(80),
                            padding: EdgeInsets.only(right: ScreenUtilHelper.width(12)),
                            child: Text(exam['date']!, style: dateTextStyle),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(ScreenUtilHelper.width(12)),
                              decoration: BoxDecoration(
                                color: AppColors.holidayBar,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(exam['subject']!, style: subjectTitleStyle),
                                  SizedBox(height: ScreenUtilHelper.height(4)),
                                  Text(exam['timing']!, style: normalWhiteText),
                                  SizedBox(height: ScreenUtilHelper.height(8)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(exam['invigilator']!, style: normalWhiteText),
                                      Text(exam['marks']!, style: normalWhiteText),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    final event = events[index];
                    return Container(
                      padding: EdgeInsets.all(ScreenUtilHelper.width(12)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: ScreenUtilHelper.width(80),
                            padding: EdgeInsets.only(right: ScreenUtilHelper.width(12)),
                            child: Text(event['date']!, style: dateTextStyle),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(ScreenUtilHelper.width(12)),
                              decoration: BoxDecoration(
                                color: AppColors.holidayBar,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(event['event']!, style: subjectTitleStyle),
                                  SizedBox(height: ScreenUtilHelper.height(4)),
                                  Text(event['timing']!, style: normalWhiteText),
                                  SizedBox(height: ScreenUtilHelper.height(8)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(event['coordinator']!, style: normalWhiteText),
                                      Text(event['location']!, style: normalWhiteText),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
