

import 'package:edudibon_flutter_bloc/presentation/otp_confirmation_screen/bloc/otp_confirmation_event.dart';
import 'package:edudibon_flutter_bloc/presentation/otp_confirmation_screen/bloc/otp_confirmation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  ConfirmationBloc() : super(ConfirmationInitial()) {
    on<ContinueButtonPressed>((event, emit) async {
      emit(ConfirmationLoading());
      try {
        // Replace with your actual confirmation logic
        await Future.delayed(Duration(seconds: 1)); // Simulate delay
        emit(ConfirmationSuccess());
      } catch (e) {
        emit(ConfirmationFailure(error: e.toString()));
      }
    });
  }
}