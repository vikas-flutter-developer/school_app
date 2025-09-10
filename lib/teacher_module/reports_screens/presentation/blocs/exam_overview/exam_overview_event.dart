// lib/presentation/blocs/exam_overview/exam_overview_event.dart
part of 'exam_overview_bloc.dart';

abstract class ExamOverviewEvent extends Equatable {
  const ExamOverviewEvent();
  @override
  List<Object?> get props => [];
}

// Event to load initial data or refresh based on all filters
class LoadExamOverview extends ExamOverviewEvent {
  // Optionally pass initial filters, or let BLoC use its current state
  const LoadExamOverview();
}

// Event when the user selects a different class
class SelectExamClass extends ExamOverviewEvent {
  final String selectedClass;
  const SelectExamClass(this.selectedClass);
  @override
  List<Object?> get props => [selectedClass];
}

// Event when the user selects a different term
class SelectExamTerm extends ExamOverviewEvent {
  final String selectedTerm;
  const SelectExamTerm(this.selectedTerm);
  @override
  List<Object?> get props => [selectedTerm];
}

// Event when the user selects a different month (for Timetable view)
class SelectExamMonth extends ExamOverviewEvent {
  final String
  selectedMonth; // Assuming month is represented as String for simplicity
  const SelectExamMonth(this.selectedMonth);
  @override
  List<Object?> get props => [selectedMonth];
}

// Event when the user selects a different subject (for filtering)
class SelectExamSubject extends ExamOverviewEvent {
  final String? selectedSubject; // Nullable if "All Subjects" is an option
  const SelectExamSubject(this.selectedSubject);
  @override
  List<Object?> get props => [selectedSubject];
}

// Event when the user switches between "Exam Plan" and "Timetable" tabs
class SwitchExamTab extends ExamOverviewEvent {
  final int tabIndex; // 0 for Plan, 1 for Timetable
  const SwitchExamTab(this.tabIndex);
  @override
  List<Object?> get props => [tabIndex];
}
