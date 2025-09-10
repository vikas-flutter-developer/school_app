// lib/bloc/profile_event.dart
import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

// Event triggered when the user requests to logout
class LogoutRequested extends ProfileEvent {}

// Add other potential events like LoadProfileData, ChangePasswordRequested etc.