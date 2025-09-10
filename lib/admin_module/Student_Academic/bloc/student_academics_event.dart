// bloc/student_academics/student_academics_event.dart
part of 'student_academics_bloc.dart';

abstract class StudentAcademicsEvent extends Equatable {
  const StudentAcademicsEvent();

  @override
  List<Object?> get props => [];
}

class LoadStudentData extends StudentAcademicsEvent {
  // Optional: Pass initial filter values if needed
}

class ClassSelected extends StudentAcademicsEvent {
  final String? selectedClass;
  const ClassSelected(this.selectedClass);

  @override
  List<Object?> get props => [selectedClass];
}

class SectionSelected extends StudentAcademicsEvent {
  final String? selectedSection;
  const SectionSelected(this.selectedSection);

  @override
  List<Object?> get props => [selectedSection];
}

class AcademicYearSelected extends StudentAcademicsEvent {
  final String? selectedYear;
  const AcademicYearSelected(this.selectedYear);

  @override
  List<Object?> get props => [selectedYear];
}

class SearchQueryChanged extends StudentAcademicsEvent {
  final String query;
  const SearchQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class BottomNavTapped extends StudentAcademicsEvent {
  final int index;
  const BottomNavTapped(this.index);
  @override
  List<Object?> get props => [index];
}