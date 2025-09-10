part of 'student_profile_bloc.dart';

@immutable
abstract class StudentProfileEvent {}

class LoadStudentProfile extends StudentProfileEvent {
  final String studentId; // Or any identifier for the student
  LoadStudentProfile(this.studentId);
}
