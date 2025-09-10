// communication_state.dart
part of 'communication_bloc.dart';

abstract class CommunicationState extends Equatable {
  const CommunicationState();
  @override
  List<Object> get props => [];
}

class CommunicationInitial extends CommunicationState {}

class CommunicationLoadSuccess extends CommunicationState {
  // Add data if needed, e.g., unread counts per category
  const CommunicationLoadSuccess();
}
