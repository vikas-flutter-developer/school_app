part of 'app_tab_bloc.dart';

class AppTabState extends Equatable {
  final int mainTabIndex; // 0 = Timetable, 1 = ExamEvents
  final int examEventsTabIndex; // 0 = Upcoming Exams, 1 = Upcoming Events

  const AppTabState({
    this.mainTabIndex = 0,
    this.examEventsTabIndex = 0,
  });

  AppTabState copyWith({
    int? mainTabIndex,
    int? examEventsTabIndex,
  }) {
    return AppTabState(
      mainTabIndex: mainTabIndex ?? this.mainTabIndex,
      examEventsTabIndex: examEventsTabIndex ?? this.examEventsTabIndex,
    );
  }

  @override
  List<Object> get props => [mainTabIndex, examEventsTabIndex];
}
