part of 'attendance_details_bloc.dart';

abstract class AttendanceDetailsState extends Equatable {
  const AttendanceDetailsState();

  @override
  List<Object> get props => [];
}

class AttendanceDetailsInitial extends AttendanceDetailsState {}

class AttendanceDetailsLoading extends AttendanceDetailsState {}

class AttendanceDetailsLoaded extends AttendanceDetailsState {
  final List<Students> students;
  final String selectedClass;
  final DateTime selectedDate;

  const AttendanceDetailsLoaded({
    required this.students,
    required this.selectedClass,
    required this.selectedDate,
  });

  @override
  List<Object> get props => [students, selectedClass, selectedDate];
}

class AttendanceDetailsError extends AttendanceDetailsState {
  final String message;

  const AttendanceDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
