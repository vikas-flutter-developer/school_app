import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/admin_profile_data.dart';
import 'profile_event.dart';
import 'profile_state.dart';
 // Import data model

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    // Add event handler for LoadProfileData if you implement loading
    // on<LoadProfileData>(_onLoadProfileData);
    on<LogoutRequested>(_onLogoutRequested);

    // Initially load profile data (optional, depending on your flow)
    // add(LoadProfileData());
    // For this example, we'll just start in ProfileLoaded state with dummy data
    // In a real app, you'd fetch this when the screen loads.
    // If fetching, the initial state would be ProfileLoading
    emit(ProfileLoaded(profileData: dummyAdminProfileData)); // Start with data for UI
  }

  /*
  // Example of how you might handle loading data
  void _onLoadProfileData(LoadProfileData event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      // Simulate fetching data (replace with actual data fetching logic)
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
      final profileData = dummyAdminProfileData; // Replace with fetched data
      emit(ProfileLoaded(profileData: profileData));
    } catch (e) {
      emit(ProfileError(message: 'Failed to load profile data: ${e.toString()}'));
    }
  }
  */

  void _onLogoutRequested(LogoutRequested event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading()); // Optional: Show loading state during logout process
    try {
      // Simulate logout process (e.g., clearing SharedPreferences, calling API)
      SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.clear(); // Clear login/user data
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate async operation

      // If successful, emit success state
      emit(ProfileLoggedOutSuccess());
    } catch (e) {
      // If logout fails, emit error state
      emit(ProfileError(message: 'Logout failed: ${e.toString()}'));
      // Optionally return to previous state or keep loading state until retry/cancel
      // emit(ProfileLoaded(profileData: currentState.profileData)); // Example: return to loaded state
    }
  }
}