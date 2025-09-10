import 'package:equatable/equatable.dart';

import '../model/attendance_model.dart';


abstract class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final List<CalendarEvent> calendarEvents;

  const AttendanceLoaded({required this.calendarEvents});

  @override
  List<Object> get props => [calendarEvents];
}

class AttendanceError extends AttendanceState {
  final String message;

  const AttendanceError({required this.message});

  @override
  List<Object> get props => [message];
}