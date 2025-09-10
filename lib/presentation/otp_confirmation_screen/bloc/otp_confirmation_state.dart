abstract class ConfirmationState {}

class ConfirmationInitial extends ConfirmationState {}

class ConfirmationLoading extends ConfirmationState {}

class ConfirmationSuccess extends ConfirmationState {}

class ConfirmationFailure extends ConfirmationState {
  final String error;

  ConfirmationFailure({required this.error});
}