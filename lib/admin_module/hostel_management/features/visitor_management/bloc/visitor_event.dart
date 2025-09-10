part of 'visitor_bloc.dart';

abstract class VisitorEvent extends Equatable {
  const VisitorEvent();

  @override
  List<Object> get props => [];
}

class LoadVisitorList extends VisitorEvent {}

class SubmitNewVisitorPass extends VisitorEvent {
  final String visitorName;
  final String studentName;
  final String studentClass;
  final String relation;
  final String purpose;
  final String? comment; // Corresponds to 'Reason' on the new request card

  const SubmitNewVisitorPass({
    required this.visitorName,
    required this.studentName,
    required this.studentClass,
    required this.relation,
    required this.purpose,
    this.comment,
  });

  @override
  List<Object> get props => [visitorName, studentName, studentClass, relation, purpose, comment ?? ''];
}

class ApproveVisitorPass extends VisitorEvent {
  final String passId;
  const ApproveVisitorPass(this.passId);
  @override
  List<Object> get props => [passId];
}

class DenyVisitorPass extends VisitorEvent {
  final String passId;
  const DenyVisitorPass(this.passId);
  @override
  List<Object> get props => [passId];
}