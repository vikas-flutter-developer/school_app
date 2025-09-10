part of 'attendance_details_bloc.dart';

abstract class AttendanceDetailsEvent extends Equatable {
  const AttendanceDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadAttendanceDetails extends AttendanceDetailsEvent {
  final String selectedClass;
  final DateTime selectedDate;

  const LoadAttendanceDetails({
    required this.selectedClass,
    required this.selectedDate,
  });

  @override
  List<Object> get props => [selectedClass, selectedDate];
}

class SelectClass extends AttendanceDetailsEvent {
  final String selectedClass;

  const SelectClass(this.selectedClass);

  @override
  List<Object> get props => [selectedClass];
}

class SelectDate extends AttendanceDetailsEvent {
  final DateTime selectedDate;

  const SelectDate(this.selectedDate);

  @override
  List<Object> get props => [selectedDate];
}
