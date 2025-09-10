abstract class OtpEvent {}

class OtpCodeEntered extends OtpEvent {
  final String otp;

  OtpCodeEntered({required this.otp});
}

class ResendOtpPressed extends OtpEvent {}