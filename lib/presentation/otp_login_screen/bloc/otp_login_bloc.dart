import 'package:edudibon_flutter_bloc/presentation/otp_login_screen/bloc/otp_login_event.dart';
import 'package:edudibon_flutter_bloc/presentation/otp_login_screen/bloc/otp_login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInitial()) {
    on<OtpCodeEntered>((event, emit) async {
      emit(OtpLoading());
      try {
        // Replace with your actual OTP verification logic
        await Future.delayed(Duration(seconds: 1)); // Simulate delay
        if (event.otp == '1234') { // Replace with your logic
          emit(OtpSuccess());
        } else {
          emit(OtpFailure(error: 'Invalid OTP'));
        }
      } catch (e) {
        emit(OtpFailure(error: e.toString()));
      }
    });

    on<ResendOtpPressed>((event, emit) async {
      emit(ResendOtpLoading());
      try{
        await Future.delayed(Duration(seconds: 1));
        emit(ResendOtpSuccess());
      } catch(e){
        emit(ResendOtpFailure(error: e.toString()));
      }
    });
  }
}