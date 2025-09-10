abstract class ForgotPasswordEvent {}

class UserIdChanged extends ForgotPasswordEvent {
  final String userId;
  UserIdChanged(this.userId);
}

class SetNewPasswordPressed extends ForgotPasswordEvent {}