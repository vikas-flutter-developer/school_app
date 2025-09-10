// lib/attendance/bloc/attendance_event.dart
import 'package:equatable/equatable.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object> get props => [];
}

class FetchAttendance extends AttendanceEvent {
  final String fromDate;
  final String toDate;

  const FetchAttendance({required this.fromDate, required this.toDate});

  @override
  List<Object> get props => [fromDate, toDate];
}