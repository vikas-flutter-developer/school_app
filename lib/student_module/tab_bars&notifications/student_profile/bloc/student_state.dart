part of 'student_bloc.dart';

sealed class StudentState extends Equatable {
  const StudentState();
}

final class StudentInitial extends StudentState {
  @override
  List<Object> get props => [];
}

class StudentLoadingState extends StudentState {
  @override
  List<Object> get props => [];
}

class StudentLoadedState extends StudentState {
  final StudentModels studentModel;
  const StudentLoadedState(this.studentModel);

  @override
  List<Object> get props => [studentModel];
}

class StudentErrorState extends StudentState {
  final String errorMassage;
  const StudentErrorState(this.errorMassage);
  @override
  List<Object> get props => [errorMassage];
}
