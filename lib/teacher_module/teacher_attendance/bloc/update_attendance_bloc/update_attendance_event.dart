part of 'update_attendance_bloc.dart';

abstract class UpdateAttendanceEvent extends Equatable {
  const UpdateAttendanceEvent();

  @override
  List<Object> get props => [];
}

class LoadStudents extends UpdateAttendanceEvent {
  final String selectedClass;
  final DateTime selectedDate;

  const LoadStudents({required this.selectedClass, required this.selectedDate});

  @override
  List<Object> get props => [selectedClass, selectedDate];
}

class UpdateStudentStatus extends UpdateAttendanceEvent {
  final String studentId;
  final String status;

  const UpdateStudentStatus({required this.studentId, required this.status});

  @override
  List<Object> get props => [studentId, status];
}

class BulkUpdateStatus extends UpdateAttendanceEvent {
  final String status;

  const BulkUpdateStatus(this.status);

  @override
  List<Object> get props => [status];
}

class SelectClass extends UpdateAttendanceEvent {
  final String selectedClass;

  const SelectClass(this.selectedClass);

  @override
  List<Object> get props => [selectedClass];
}

class SelectDate extends UpdateAttendanceEvent {
  final DateTime selectedDate;

  const SelectDate(this.selectedDate);

  @override
  List<Object> get props => [selectedDate];
}
