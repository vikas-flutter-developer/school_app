// lib/presentation/blocs/student_report/student_report_event.dart
part of 'student_report_bloc.dart';

abstract class StudentReportEvent extends Equatable {
  const StudentReportEvent();
  @override
  List<Object?> get props => [];
}

// Event to load the initial report for a student and term
class LoadStudentReport extends StudentReportEvent {
  final String studentId;
  final String initialTermId; // The term to load initially

  const LoadStudentReport({
    required this.studentId,
    required this.initialTermId,
  });

  @override
  List<Object?> get props => [studentId, initialTermId];
}

// Event when the user selects a different term from the dropdown
class SelectStudentTerm extends StudentReportEvent {
  final String selectedTermId;

  const SelectStudentTerm({required this.selectedTermId});

  @override
  List<Object?> get props => [selectedTermId];
}

// Note: NavigateStudent event is omitted for now. Navigation logic
// would typically involve fetching the next/previous student ID externally
// and then dispatching a new LoadStudentReport event.
