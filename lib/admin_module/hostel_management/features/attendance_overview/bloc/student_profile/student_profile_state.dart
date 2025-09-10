part of 'student_profile_bloc.dart';

@immutable
abstract class StudentProfileState {}

class StudentProfileInitial extends StudentProfileState {}

class StudentProfileLoading extends StudentProfileState {}

class StudentProfileLoaded extends StudentProfileState {
  final StudentProfileModel profile;
  StudentProfileLoaded(this.profile);
}

class StudentProfileError extends StudentProfileState {
  final String message;
  StudentProfileError(this.message);
}
