part of 'timetable_bloc.dart';

abstract class TimetableEvent extends Equatable {
  const TimetableEvent();

  @override
  List<Object?> get props => [];
}

class FetchTimetable extends TimetableEvent {
  final int? dayId; // Day ID might be needed for initial fetch filtering? Or just for state?

  const FetchTimetable({this.dayId}); // Made optional if not always needed for API call

  @override
  List<Object?> get props => [dayId];
}

class ChangeDay extends TimetableEvent {
  final int dayId;

  const ChangeDay({required this.dayId});

  @override
  List<Object> get props => [dayId];
}