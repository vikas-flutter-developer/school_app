import 'package:equatable/equatable.dart';

abstract class StudentAcademicEvent extends Equatable{
  const StudentAcademicEvent();

  @override
  List<Object> get props => [];
}

class FetchStudentReport extends StudentAcademicEvent {
  final String examType; // <-- ADD THIS

  const FetchStudentReport({required this.examType}); // <-- UPDATE CONSTRUCTOR

  @override
  List<Object> get props => [examType]; // <-- ADD TO PROPS
}