import 'package:equatable/equatable.dart';

abstract class SyllabusState extends Equatable {
  const SyllabusState();
  
  @override
  List<Object> get props => [];
}

class SyllabusInitial extends SyllabusState {}

class SyllabusLoaded extends SyllabusState {
  final List<String> syllabusList;

  const SyllabusLoaded(this.syllabusList);
  
  @override
  List<Object> get props => [syllabusList];
}
