part of 'change_password_bloc.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object?> get props => [];
}

// Initial state: Show Enter User ID screen
class ChangePasswordInitial extends ChangePasswordState {}

// State while validating User ID
class ChangePasswordUserIdValidationInProgress extends ChangePasswordState {}

// State when User ID is invalid
class ChangePasswordUserIdInvalid extends ChangePasswordState {
  final String error;
  const ChangePasswordUserIdInvalid(this.error);

  @override
  List<Object?> get props => [error];
}

// State when User ID is valid, ready for next step (holds the validated ID)
// We transition *to* the next screen based on this state.
class ChangePasswordShowNewPasswordScreen extends ChangePasswordState {
  final String userId;
  const ChangePasswordShowNewPasswordScreen(this.userId);

  @override
  List<Object?> get props => [userId];
}

// State while updating the password
class ChangePasswordUpdateInProgress extends ChangePasswordState {
  final String userId; // Keep userId for potential retries? Maybe not needed.
  const ChangePasswordUpdateInProgress(this.userId);
  @override
  List<Object?> get props => [userId];
}

// State when new password validation fails (e.g., mismatch)
class ChangePasswordNewPasswordValidationFailure extends ChangePasswordState {
  final String userId; // Keep userId to stay on the correct screen
  final String error;
  const ChangePasswordNewPasswordValidationFailure(this.userId, this.error);

  @override
  List<Object?> get props => [userId, error];
}

// State when password update succeeds
class ChangePasswordUpdateSuccess extends ChangePasswordState {}

// State when password update fails (API error, etc.)
class ChangePasswordUpdateFailure extends ChangePasswordState {
  final String userId; // Keep userId to stay on the correct screen
  final String error;
  const ChangePasswordUpdateFailure(this.userId, this.error);

  @override
  List<Object?> get props => [userId, error];
}