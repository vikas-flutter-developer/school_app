part of 'complaint_form_bloc.dart';

abstract class ComplaintFormEvent extends Equatable {
  const ComplaintFormEvent();

  @override
  List<Object?> get props => [];
}

class LoadComplaintFormData extends ComplaintFormEvent {
  // Pass initial data if needed, e.g., when editing a complaint
  // final ComplaintModel? complaint;
  // const LoadComplaintFormData({this.complaint});

  // @override
  // List<Object?> get props => [complaint];
}

class ActionChanged extends ComplaintFormEvent {
  final String? action;
  const ActionChanged(this.action);

  @override
  List<Object?> get props => [action];
}

class StatusChanged extends ComplaintFormEvent {
  final String? status;
  const StatusChanged(this.status);

  @override
  List<Object?> get props => [status];
}

class ResolvedDateChanged extends ComplaintFormEvent {
  final String? date;
  const ResolvedDateChanged(this.date);

  @override
  List<Object?> get props => [date];
}

class CommentChanged extends ComplaintFormEvent {
  final String comment;
  const CommentChanged(this.comment);

  @override
  List<Object?> get props => [comment];
}

class SubmitComplaintForm extends ComplaintFormEvent {}
