part of 'student_detail_bloc.dart';

abstract class StudentDetailEvent extends Equatable {
  const StudentDetailEvent();

  @override
  List<Object?> get props => [];
}

// Event to load details, passing the basic student info
class LoadStudentDetails extends StudentDetailEvent {
  final Student student; // Student model from previous screen
  final String previousScreenTitle; // e.g., "Class X-A (2024-25)"

  const LoadStudentDetails(this.student, this.previousScreenTitle);

  @override
  List<Object?> get props => [student, previousScreenTitle];
}

class BottomNavTapped extends StudentDetailEvent {
  final int index;
  const BottomNavTapped(this.index);
  @override
  List<Object?> get props => [index];
}