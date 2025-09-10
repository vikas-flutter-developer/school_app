part of 'attendance_overview_bloc.dart';

@immutable
abstract class AttendanceOverviewEvent {}

class LoadAttendanceData extends AttendanceOverviewEvent {}

// Add other events like SearchStudents, FilterStudents if needed
