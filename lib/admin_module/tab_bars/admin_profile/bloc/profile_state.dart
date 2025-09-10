import 'package:equatable/equatable.dart';

import '../../data/admin_profile_data.dart';
 // Import data model

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

// State emitted when profile data is loaded
class ProfileLoaded extends ProfileState {
  final AdminProfileData profileData;
  const ProfileLoaded({required this.profileData});

  @override
  List<Object> get props => [profileData];
}

// State emitted after successful logout
class ProfileLoggedOutSuccess extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError({required this.message});

  @override
  List<Object> get props => [message];
}

// Add other states like ChangePasswordSuccess, ChangePasswordError etc.