part of 'visitor_bloc.dart';

abstract class VisitorState extends Equatable {
  const VisitorState();

  @override
  List<Object> get props => [];
}

class VisitorInitial extends VisitorState {}

class VisitorLoading extends VisitorState {}

class VisitorListLoadSuccess extends VisitorState {
  final List<VisitorPass> visitorPasses;
  const VisitorListLoadSuccess(this.visitorPasses);

  @override
  List<Object> get props => [visitorPasses];
}

class VisitorFormSubmissionSuccess extends VisitorState {
  final String message;
  const VisitorFormSubmissionSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class VisitorActionSuccess extends VisitorState { // For approve/deny
  final String message;
  const VisitorActionSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class VisitorError extends VisitorState {
  final String message;
  const VisitorError(this.message);
  @override
  List<Object> get props => [message];
}