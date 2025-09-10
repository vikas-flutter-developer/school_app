import 'package:equatable/equatable.dart';

abstract class AssignmentEvent extends Equatable {
  const AssignmentEvent();

  @override
  List<Object> get props => [];
}

class LoadAssignments extends AssignmentEvent {}
