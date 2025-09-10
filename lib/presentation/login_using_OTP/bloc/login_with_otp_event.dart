part of 'login_with_otp_bloc.dart';

@immutable
abstract class LoginWithOtpEvent {}

class LoginWithOtpTextChanged extends LoginWithOtpEvent {
  final String userIdMobileNo;

  LoginWithOtpTextChanged({required this.userIdMobileNo});
}

class LoginWithOtpNextPressed extends LoginWithOtpEvent {
  final String userIdMobileNo;

  LoginWithOtpNextPressed({required this.userIdMobileNo});
}