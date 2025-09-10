import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:edudibon_flutter_bloc/presentation/login_screen/bloc/login_event.dart';
import 'package:edudibon_flutter_bloc/presentation/login_screen/bloc/login_state.dart';
import 'package:http/http.dart' as http;
import '../../../data/local_storage/local_storage_service.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginLoading());
    try {
      final response = await http.post(
        Uri.parse('https://stage-api-edudibon.trinodepointers.com/auth/token'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'username': event.email,
          'password': event.password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final String? token = responseData['token'];

        if (token != null) {
          await LocalStorageService.setAuthToken(token);
          emit(LoginSuccess());
        } else {
          emit(LoginFailure(error: 'Token not found in response.'));
        }
      } else {
        final error = jsonDecode(response.body)['message'] ?? 'Login failed';
        emit(LoginFailure(error: error));
      }
    } catch (e) {
      emit(LoginFailure(error: 'An error occurred. Please try again.'));
    }
  }
}