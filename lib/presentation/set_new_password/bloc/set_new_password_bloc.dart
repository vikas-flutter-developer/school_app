// --- Bloc ---
import 'package:edudibon_flutter_bloc/presentation/set_new_password/bloc/set_new_password_event.dart';
import 'package:edudibon_flutter_bloc/presentation/set_new_password/bloc/set_new_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPasswordBloc extends Bloc<NewPasswordEvent, NewPasswordState> {
  NewPasswordBloc() : super(NewPasswordInitial());

  String _password = '';
  String _confirmPassword = '';

  @override
  Stream<NewPasswordState> mapEventToState(NewPasswordEvent event) async* {
    if (event is NewPasswordChanged) {
      _password = event.password;
      yield state; // Simply emit the current state for now
    } else if (event is ConfirmPasswordChanged) {
      _confirmPassword = event.confirmPassword;
      yield state;
    } else if (event is DonePressed) {
      yield NewPasswordLoading();
      try {
        if (_password == _confirmPassword) {
          // Simulate password update logic (replace with your actual logic)
          await Future.delayed(Duration(seconds: 2)); // Simulate network delay
          yield NewPasswordSuccess();
        } else {
          yield NewPasswordFailure('Passwords do not match.');
        }
      } catch (e) {
        yield NewPasswordFailure('Failed to update password. Please try again.');
      }
    }
  }
}