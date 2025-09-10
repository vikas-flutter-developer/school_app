// lib/data/models/result.dart
import 'package:equatable/equatable.dart';

enum ResultStatus { Pass, Fail }

class StudentResultSummary extends Equatable {
  // For the first screen's table
  final String studentId;
  final String studentName;
  final String subject;
  final String examTerm;
  final ResultStatus status;

  const StudentResultSummary({
    required this.studentId,
    required this.studentName,
    required this.subject,
    required this.examTerm,
    required this.status,
  });

  @override
  List<Object?> get props => [
    studentId,
    studentName,
    subject,
    examTerm,
    status,
  ];
}

class SubjectResultDetail extends Equatable {
  // For the student report screen
  final String subject;
  final int totalMarks;
  final int score;
  final double percentage;
  final ResultStatus result;
  final int? theoryScore; // Optional break-down
  final int? practicalScore; // Optional break-down

  const SubjectResultDetail({
    required this.subject,
    required this.totalMarks,
    required this.score,
    required this.percentage,
    required this.result,
    this.theoryScore,
    this.practicalScore,
  });

  @override
  List<Object?> get props => [
    subject,
    totalMarks,
    score,
    percentage,
    result,
    theoryScore,
    practicalScore,
  ];
}
