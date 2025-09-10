part of 'login_with_otp_bloc.dart';

@immutable
abstract class LoginWithOtpState {}

class LoginWithOtpInitial extends LoginWithOtpState {}

class LoginWithOtpLoading extends LoginWithOtpState {}

class LoginWithOtpOTPSent extends LoginWithOtpState {}

class LoginWithOtpError extends LoginWithOtpState {
  final String errorMessage;

  LoginWithOtpError({required this.errorMessage});
}

/*
class LoginWithOtpTextChanged extends LoginWithOtpState {
  final String userIdMobileNo;

  LoginWithOtpTextChanged({required this.userIdMobileNo});
}*/
