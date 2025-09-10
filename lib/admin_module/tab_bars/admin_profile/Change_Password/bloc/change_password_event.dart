part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object?> get props => [];
}

// Event when User ID screen's button is pressed
class ChangePasswordUserIdSubmitted extends ChangePasswordEvent {
  final String userId;
  const ChangePasswordUserIdSubmitted(this.userId);

  @override
  List<Object?> get props => [userId];
}

// Event when New Password screen's button is pressed
class ChangePasswordNewPasswordSubmitted extends ChangePasswordEvent {
  final String userId; // Need userId obtained from previous step
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordNewPasswordSubmitted({
    required this.userId,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [userId, newPassword, confirmPassword];
}

// Event when user navigates back or cancels (optional reset)
class ChangePasswordReset extends ChangePasswordEvent {}