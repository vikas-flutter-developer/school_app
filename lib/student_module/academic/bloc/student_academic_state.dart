import 'package:equatable/equatable.dart';
import '../model/student_report_model.dart';

abstract class StudentAcademicState extends Equatable{
  const StudentAcademicState();

  @override
  List<Object> get props => [];
}

class StudentReportInitial extends StudentAcademicState {}

class StudentReportLoading extends StudentAcademicState {}

class StudentReportLoaded extends StudentAcademicState {
  final StudentReportModel report;
  final String selectedExamType; // <-- ADD THIS

  const StudentReportLoaded(this.report, {this.selectedExamType = "All"}); // <-- UPDATE CONSTRUCTOR

  @override
  List<Object> get props => [report,selectedExamType];
}

class StudentReportError extends StudentAcademicState {
  final String message;

  const StudentReportError(this.message);

  @override
  List<Object> get props => [message];
}