part of 'attendance_report_bloc.dart';

abstract class AttendanceReportState extends Equatable {
  const AttendanceReportState();

  @override
  List<Object> get props => [];
}

class AttendanceReportInitial extends AttendanceReportState {}

class AttendanceReportLoading extends AttendanceReportState {}

class AttendanceReportLoaded extends AttendanceReportState {
  final List<AttendanceReport> reports;
  final String selectedClass;
  final DateTime fromDate;
  final DateTime toDate;
  final int tabIndex;
  final String searchQuery;

  const AttendanceReportLoaded({
    required this.reports,
    required this.selectedClass,
    required this.fromDate,
    required this.toDate,
    required this.tabIndex,
    this.searchQuery = '',
  });

  List<AttendanceReport> get filteredReports {
    if (searchQuery.isEmpty) return reports;
    return reports.where((report) {
      return report.studentName.toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
          report.studentId.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  List<Object> get props => [
    reports,
    selectedClass,
    fromDate,
    toDate,
    tabIndex,
    searchQuery,
  ];
}

class AttendanceReportError extends AttendanceReportState {
  final String message;

  const AttendanceReportError(this.message);

  @override
  List<Object> get props => [message];
}
