import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async'; // For Future.delayed

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordInitial()) {
    on<ChangePasswordUserIdSubmitted>(_onUserIdSubmitted);
    on<ChangePasswordNewPasswordSubmitted>(_onNewPasswordSubmitted);
    on<ChangePasswordReset>(_onReset);
  }

  Future<void> _onUserIdSubmitted(
      ChangePasswordUserIdSubmitted event,
      Emitter<ChangePasswordState> emit,
      ) async {
    emit(ChangePasswordUserIdValidationInProgress());
    await Future.delayed(const Duration(milliseconds: 800)); // Simulate API call

    // --- TODO: Replace with actual User ID validation logic ---
    if (event.userId.isEmpty) {
      emit(const ChangePasswordUserIdInvalid("User ID cannot be empty"));
    } else if (event.userId.toLowerCase() == "invalid_user") { // Simulate invalid user
      emit(const ChangePasswordUserIdInvalid("Invalid user id"));
    } else {
      // Assume valid for now
      emit(ChangePasswordShowNewPasswordScreen(event.userId));
    }
    // --- End of validation logic ---
  }

  Future<void> _onNewPasswordSubmitted(
      ChangePasswordNewPasswordSubmitted event,
      Emitter<ChangePasswordState> emit,
      ) async {
    // Basic validation
    if (event.newPassword.isEmpty || event.confirmPassword.isEmpty) {
      emit(ChangePasswordNewPasswordValidationFailure(event.userId, "Passwords cannot be empty"));
      return;
    }
    if (event.newPassword != event.confirmPassword) {
      emit(ChangePasswordNewPasswordValidationFailure(event.userId, "Passwords do not match"));
      return;
    }
    // More complex validation (length, characters) can be added here

    emit(ChangePasswordUpdateInProgress(event.userId));
    await Future.delayed(const Duration(seconds: 1)); // Simulate API call

    // --- TODO: Replace with actual Password Update API Call ---
    bool success = true; // Simulate success
    String apiError = "Network error"; // Simulate potential error

    if (success) {
      emit(ChangePasswordUpdateSuccess());
    } else {
      emit(ChangePasswordUpdateFailure(event.userId, apiError));
    }
    // --- End of API call logic ---
  }

  void _onReset(
      ChangePasswordReset event,
      Emitter<ChangePasswordState> emit,
      ) {
    emit(ChangePasswordInitial());
  }
}