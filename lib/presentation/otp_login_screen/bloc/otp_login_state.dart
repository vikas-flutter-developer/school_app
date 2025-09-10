abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {}

class OtpFailure extends OtpState {
  final String error;

  OtpFailure({required this.error});
}

class ResendOtpLoading extends OtpState {}
class ResendOtpSuccess extends OtpState {}
class ResendOtpFailure extends OtpState {
  final String error;
  ResendOtpFailure({required this.error});
}