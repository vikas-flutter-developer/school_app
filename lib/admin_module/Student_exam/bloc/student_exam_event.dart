// bloc/student_exam/student_exam_event.dart (Create folder and file)
part of 'student_exam_bloc.dart';

abstract class StudentExamEvent extends Equatable {
  const StudentExamEvent();

  @override
  List<Object?> get props => [];
}

// Event to trigger loading data
class LoadExamData extends StudentExamEvent {}

// Events for filter changes
class ClassSelected extends StudentExamEvent {
  final String? selectedClass;
  const ClassSelected(this.selectedClass);
  @override List<Object?> get props => [selectedClass];
}

class SectionSelected extends StudentExamEvent {
  final String? selectedSection;
  const SectionSelected(this.selectedSection);
  @override List<Object?> get props => [selectedSection];
}

class SemesterSelected extends StudentExamEvent {
  final String? selectedSemester;
  const SemesterSelected(this.selectedSemester);
  @override List<Object?> get props => [selectedSemester];
}

class AcademicYearSelected extends StudentExamEvent {
  final String? selectedYear;
  const AcademicYearSelected(this.selectedYear);
  @override List<Object?> get props => [selectedYear];
}

// Event for search query change
class SearchQueryChanged extends StudentExamEvent {
  final String query;
  const SearchQueryChanged(this.query);
  @override List<Object?> get props => [query];
}

// Event for bottom navigation tap
class BottomNavTapped extends StudentExamEvent {
  final int index;
  const BottomNavTapped(this.index);
  @override List<Object?> get props => [index];
}