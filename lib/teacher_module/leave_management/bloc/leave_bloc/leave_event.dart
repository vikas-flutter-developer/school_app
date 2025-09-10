part of 'leave_bloc.dart';

abstract class LeaveEvent extends Equatable {
  const LeaveEvent();

  @override
  List<Object> get props => [];
}

class LoadLeaves extends LeaveEvent {}

class ApplyLeave extends LeaveEvent {
  final Leave leave;

  const ApplyLeave(this.leave);

  @override
  List<Object> get props => [leave];
}

class ChangeLeaveTab extends LeaveEvent {
  final int tabIndex;

  const ChangeLeaveTab(this.tabIndex);

  @override
  List<Object> get props => [tabIndex];
}
