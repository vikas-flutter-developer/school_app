part of 'teacher_bloc.dart';

sealed class TeacherState extends Equatable {
  const TeacherState();
}

final class TeacherInitial extends TeacherState {
  @override
  List<Object> get props => [];
}

class TeacherLoadingState extends TeacherState {
  @override
  List<Object> get props => [];
}

class TeacherLoadedState extends TeacherState {
  final TeacherModels teacherModel;
  const TeacherLoadedState(this.teacherModel);

  @override
  List<Object> get props => [teacherModel];
}

class TeacherErrorState extends TeacherState {
  final String errorMassage;
  const TeacherErrorState(this.errorMassage);
  @override
  List<Object> get props => [errorMassage];
}
