import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http; // Import http
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

part 'teacher_edit_profile_event.dart';
part 'teacher_edit_profile_state.dart';

class TeacherEditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  TeacherEditProfileBloc() : super(EditProfileInitial()) {
    on<SendProfileUpdateRequest>(_onSendProfileUpdateRequest);
  }

  // Future<String?> _getToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('authToken'); // Replace 'authToken' with your key
  // }

  Future<void> _onSendProfileUpdateRequest(
    SendProfileUpdateRequest event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(EditProfileLoading());
    final String updateApiUrl =
        'YOUR_PROFILE_UPDATE_API_ENDPOINT'; // Replace with your actual API endpoint
    // final String? token = await _getToken();
    //
    // if (token == null) {
    //   emit(const EditProfileFailure('Authentication token not found.'));
    //   return;
    // }

    try {
      final response = await http.post(
        // Or http.put depending on your API
        Uri.parse(updateApiUrl),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJuczEyNWF6MjdtZ3UiLCJuYW1lIjoiQXpoYWdpIEsiLCJ0eiI6IkFzaWEvS29sa2F0YSIsImlhdCI6MTc0NTQ4MDM5NCwiZXhwIjoxNzQ1NTEzOTk0LCJhdWQiOiJlZHVESUJPTiIsImlzcyI6Imh0dHBzOi8vc3RhZ2UtZWR1ZGlib24udHJpbm9kZXBvaW50ZXJzLmNvbSIsImRhdGEiOiJnQUFBQUFCb0NlckswV2lQeDhYTnlDQlVXdWRRSXZzV0dDdFNoa3haSEdaWXpNNWx1NlROa1I3QVpOS1UxYkZLS09qWVR0bEw3bmpfVVVqNlEyZDBUUDZNcDVrTXhyNWdZMFN1bmstcnZMdDM0TUQ3aDRqbkY1RGFlMVBzNjlOa0s5bUJ2b0NTRWxrdl9nWklkdUNXbVRXOWs2TjQwQmNrd0gwT0VFZjJ6U1BUT0U4dE5ScGVzZTJ3LWNILWxUU21nNDJMbk81OS1HRE0ifQ.X1kL72b25GCjWTX_gY-BjGRhiH1V9CaxqywTV3XvwH0',
          'Content-Type': 'application/json', // Adjust content type if needed
        },
        body: json.encode(event.profileData), // Encode profile data to JSON
      );

      if (response.statusCode == 200) {
        emit(EditProfileSuccess());
      } else {
        final responseBody = json.decode(response.body);
        final errorMessage =
            responseBody['message'] ??
            'Failed to update profile.'; // Adjust based on your API response
        emit(EditProfileFailure(errorMessage));
      }
    } catch (e) {
      emit(EditProfileFailure('Failed to connect to the server.'));
    }
  }
}
