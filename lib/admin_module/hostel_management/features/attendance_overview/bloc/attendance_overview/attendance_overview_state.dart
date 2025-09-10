part of 'attendance_overview_bloc.dart';

@immutable
abstract class AttendanceOverviewState {}

class AttendanceOverviewInitial extends AttendanceOverviewState {}

class AttendanceOverviewLoading extends AttendanceOverviewState {}

class AttendanceOverviewLoaded extends AttendanceOverviewState {
  final List<RoomModel> rooms;
  AttendanceOverviewLoaded(this.rooms);
}

class AttendanceOverviewError extends AttendanceOverviewState {
  final String message;
  AttendanceOverviewError(this.message);
}
