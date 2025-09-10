import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edudibon_flutter_bloc/presentation/password_success_screen/bloc/password_success_event.dart';
import 'package:edudibon_flutter_bloc/presentation/password_success_screen/bloc/password_success_state.dart';

class PasswordSuccessBloc extends Bloc<PasswordSuccessEvent, PasswordSuccessState> {
  PasswordSuccessBloc() : super(PasswordSuccessInitial()) {
    on<LogInButtonPressed>((event, emit) {
      emit(NavigateToLogin());
    });
  }
}