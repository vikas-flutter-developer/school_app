import 'package:equatable/equatable.dart';
class SubjectScore extends Equatable {
  final int srNo;
  final String subject;
  final int score;
  final double percentage;
  final String result;
  final int total;

  const SubjectScore({
    required this.srNo,
    required this.subject,
    required this.score,
    required this.percentage,
    required this.result,
    required this.total,
  });

  @override
  List<Object?> get props => [srNo, subject, score, percentage, result, total];
}

class StudentReportModel extends Equatable {
  final int rank;
  final String totalResult;
  final List<SubjectScore> scores;
  final List<double> performanceData;

  const StudentReportModel({
    required this.rank,
    required this.totalResult,
    required this.scores,
    required this.performanceData,
  });

  @override
  List<Object?> get props => [rank, totalResult, scores, performanceData];
}