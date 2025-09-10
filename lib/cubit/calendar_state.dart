import 'package:flutter/material.dart';

@immutable
abstract class CalendarState {}

class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {}

class CalendarLoaded extends CalendarState {
  final Map<DateTime, List<String>> eventsByMonth;

  CalendarLoaded(this.eventsByMonth);
}

class CalendarError extends CalendarState {
  final String message;

  CalendarError(this.message);
}
