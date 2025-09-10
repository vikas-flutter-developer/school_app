import 'package:equatable/equatable.dart';

import '../model/Attendance_model.dart';

abstract class AttendanceState extends Equatable {
  @override
  List<Object> get props => [];
}
class AttendanceLoading extends AttendanceState {}
class AttendanceLoaded extends AttendanceState {
  final List<AttendanceRecord> attendanceList;

  AttendanceLoaded(this.attendanceList);

  @override
  List<Object> get props => [attendanceList];
}