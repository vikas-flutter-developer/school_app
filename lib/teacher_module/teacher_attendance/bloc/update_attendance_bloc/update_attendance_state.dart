part of 'update_attendance_bloc.dart';

abstract class UpdateAttendanceState extends Equatable {
  const UpdateAttendanceState();

  @override
  List<Object> get props => [];
}

class UpdateAttendanceInitial extends UpdateAttendanceState {}

class UpdateAttendanceLoading extends UpdateAttendanceState {}

class UpdateAttendanceLoaded extends UpdateAttendanceState {
  final List<Students> students;
  final String selectedClass;
  final DateTime selectedDate;

  const UpdateAttendanceLoaded({
    required this.students,
    required this.selectedClass,
    required this.selectedDate,
  });

  @override
  List<Object> get props => [students, selectedClass, selectedDate];
}

class UpdateAttendanceError extends UpdateAttendanceState {
  final String message;

  const UpdateAttendanceError(this.message);

  @override
  List<Object> get props => [message];
}
