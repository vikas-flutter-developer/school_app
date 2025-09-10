
// --- Events ---
abstract class NewPasswordEvent {}

class NewPasswordChanged extends NewPasswordEvent {
  final String password;
  NewPasswordChanged(this.password);
}

class ConfirmPasswordChanged extends NewPasswordEvent {
  final String confirmPassword;
  ConfirmPasswordChanged(this.confirmPassword);
}

class DonePressed extends NewPasswordEvent {}