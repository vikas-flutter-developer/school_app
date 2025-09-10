part of 'teacher_bloc.dart';

sealed class TeacherEvent extends Equatable {
  const TeacherEvent();
}

class TeacherFetchEvent extends TeacherEvent {
  @override
  List<Object> get props => [];
}
