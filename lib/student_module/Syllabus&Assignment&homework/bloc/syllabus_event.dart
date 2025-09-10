import 'package:equatable/equatable.dart';

abstract class SyllabusEvent extends Equatable {
  const SyllabusEvent();
  
  @override
  List<Object> get props => [];
}

class LoadInitialSyllabus extends SyllabusEvent {}

class ViewMoreSyllabus extends SyllabusEvent {
  final String syllabusItem;
  
  const ViewMoreSyllabus(this.syllabusItem);
  
  @override
  List<Object> get props => [syllabusItem];
}
