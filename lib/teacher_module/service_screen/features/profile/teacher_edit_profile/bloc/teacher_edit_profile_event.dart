part of 'teacher_edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class SendProfileUpdateRequest extends EditProfileEvent {
  final Map<String, String> profileData;

  const SendProfileUpdateRequest(this.profileData);

  @override
  List<Object> get props => [profileData];
}
