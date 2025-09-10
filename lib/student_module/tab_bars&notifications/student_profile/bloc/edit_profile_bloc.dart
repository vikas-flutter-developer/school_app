

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<SendProfileUpdateRequest>(_onSendProfileUpdateRequest);
  }

  Future<void> _onSendProfileUpdateRequest(
      SendProfileUpdateRequest event,
      Emitter<EditProfileState> emit,
      ) async {
    // API call removed. We will simulate success.

    // 1. Show loading state
    emit(EditProfileLoading());

    // 2. Wait for 2 seconds to simulate a network request
    await Future.delayed(const Duration(seconds: 2));

    // 3. Emit success state
    emit(EditProfileSuccess());
  }
}