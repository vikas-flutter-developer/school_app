import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// --- Bloc and Events ---
part 'login_with_otp_event.dart';
part 'login_with_otp_state.dart';

class LoginWithOtpBloc extends Bloc<LoginWithOtpEvent, LoginWithOtpState> {
  LoginWithOtpBloc() : super(LoginWithOtpInitial()) {
    on<LoginWithOtpNextPressed>(_onNextPressed);
  }

  void _onNextPressed(
      LoginWithOtpNextPressed event,
      Emitter<LoginWithOtpState> emit,
      ) async {
    emit(LoginWithOtpLoading());
    // Simulate API call or OTP sending process
    await Future.delayed(const Duration(seconds: 2));
    // In a real app, you would check if the user ID/Mobile No is valid
    if (event.userIdMobileNo.isNotEmpty) {
      emit(LoginWithOtpOTPSent());
      // In a real app, you would navigate to the OTP verification screen
    } else {
      emit(LoginWithOtpError(errorMessage: 'Please enter User ID or Mobile number.'));
    }
  }
}