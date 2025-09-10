// bloc/student_staff/student_staff_details_event.dart
part of 'student_staff_details_bloc.dart';

abstract class StudentStaffDetailsEvent extends Equatable {
  const StudentStaffDetailsEvent();
  @override List<Object?> get props => [];
}

class LoadInitialData extends StudentStaffDetailsEvent {}

class TabSelected extends StudentStaffDetailsEvent {
  final int tabIndex; // 0 for Student, 1 for Staff
  const TabSelected(this.tabIndex);
  @override List<Object?> get props => [tabIndex];
}

// Student Filter Events
class StudentAcademicYearSelected extends StudentStaffDetailsEvent {
  final String? year; const StudentAcademicYearSelected(this.year);
  @override List<Object?> get props => [year];
}
class StudentTypeStatusSelected extends StudentStaffDetailsEvent {
  final String? typeStatus; const StudentTypeStatusSelected(this.typeStatus);
  @override List<Object?> get props => [typeStatus];
}
class StudentClassSelected extends StudentStaffDetailsEvent {
  final String? className; const StudentClassSelected(this.className);
  @override List<Object?> get props => [className];
}
class StudentFilterOptionSelected extends StudentStaffDetailsEvent {
  final String? option; const StudentFilterOptionSelected(this.option);
  @override List<Object?> get props => [option];
}


// Staff Filter Events
class StaffFilterSelected extends StudentStaffDetailsEvent {
  final String? filterValue; const StaffFilterSelected(this.filterValue);
  @override List<Object?> get props => [filterValue];
}

// Common Events
class SearchQueryChanged extends StudentStaffDetailsEvent {
  final String query; const SearchQueryChanged(this.query);
  @override List<Object?> get props => [query];
}
class PageChanged extends StudentStaffDetailsEvent {
  final int page; const PageChanged(this.page); // Can be direction (-1, 1) or absolute page
  @override List<Object?> get props => [page];
}
class BottomNavTapped extends StudentStaffDetailsEvent {
  final int index; const BottomNavTapped(this.index);
  @override List<Object?> get props => [index];
}