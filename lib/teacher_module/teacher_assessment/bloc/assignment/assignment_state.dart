import 'package:equatable/equatable.dart';

import '../../models/assignment_model.dart' show Assignment;

abstract class AssignmentState extends Equatable {
  const AssignmentState();

  @override
  List<Object> get props => [];
}

class AssignmentInitial extends AssignmentState {}

class AssignmentLoading extends AssignmentState {}

class AssignmentLoaded extends AssignmentState {
  final List<Assignment> submittedAssignments;
  final List<Assignment> assignedAssignments;

  const AssignmentLoaded({
    required this.submittedAssignments,
    required this.assignedAssignments,
  });

  @override
  List<Object> get props => [submittedAssignments, assignedAssignments];
}

class AssignmentError extends AssignmentState {
  final String message;

  const AssignmentError({required this.message});

  @override
  List<Object> get props => [message];
}
