part of 'syllabus_bloc.dart';

abstract class SyllabusEvent extends Equatable {
  const SyllabusEvent();

  @override
  List<Object> get props => [];
}

class LoadSyllabus extends SyllabusEvent {}

class FilterSyllabus extends SyllabusEvent {
  final String filter;

  const FilterSyllabus(this.filter);

  @override
  List<Object> get props => [filter];
}
