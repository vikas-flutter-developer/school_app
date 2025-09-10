import 'package:edudibon_flutter_bloc/presentation/Forgot_password_screen/bloc/forgot_password_event.dart';
import 'package:edudibon_flutter_bloc/presentation/Forgot_password_screen/bloc/forgot_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial());

  @override
  Stream<ForgotPasswordState> mapEventToState(ForgotPasswordEvent event) async* {
    if (event is UserIdChanged) {
      // You can add validation logic here if needed
      yield state; // Simply emit the current state for now
    } else if (event is SetNewPasswordPressed) {
      yield ForgotPasswordLoading();
      try {
        // Simulate password reset logic (replace with your actual logic)
        await Future.delayed(Duration(seconds: 2)); // Simulate network delay
        yield ForgotPasswordSuccess();
      } catch (e) {
        yield ForgotPasswordFailure('Failed to reset password. Please try again.');
      }
    }
  }
}