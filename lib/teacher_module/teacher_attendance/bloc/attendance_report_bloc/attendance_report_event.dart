part of 'attendance_report_bloc.dart';

abstract class AttendanceReportEvent extends Equatable {
  const AttendanceReportEvent();

  @override
  List<Object> get props => [];
}

class LoadAttendanceReport extends AttendanceReportEvent {
  final String selectedClass;
  final DateTime fromDate;
  final DateTime toDate;
  final int tabIndex;

  const LoadAttendanceReport({
    required this.selectedClass,
    required this.fromDate,
    required this.toDate,
    required this.tabIndex,
  });

  @override
  List<Object> get props => [selectedClass, fromDate, toDate, tabIndex];
}

class SearchStudents extends AttendanceReportEvent {
  final String query;

  const SearchStudents(this.query);

  @override
  List<Object> get props => [query];
}

class ChangeTab extends AttendanceReportEvent {
  final int tabIndex;

  const ChangeTab(this.tabIndex);

  @override
  List<Object> get props => [tabIndex];
}
