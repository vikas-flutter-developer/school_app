import 'package:equatable/equatable.dart';

abstract class AttendanceEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class LoadAttendance extends AttendanceEvent {}

