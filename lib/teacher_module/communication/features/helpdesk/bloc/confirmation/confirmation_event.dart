// confirmation_event.dart
part of 'confirmation_bloc.dart';

abstract class ConfirmationEvent extends Equatable {
  const ConfirmationEvent();
  @override
  List<Object> get props => [];
}

class ShowConfirmation extends ConfirmationEvent {}

class DismissConfirmation extends ConfirmationEvent {} // e.g., navigate back
