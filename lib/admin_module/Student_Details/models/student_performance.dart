// models/student_performance.dart (or relevant file)
import 'package:equatable/equatable.dart'; // Import Equatable

// Make sure this class extends Equatable for proper comparison
class PerformanceData extends Equatable {
  final double theory;
  final double practical;
  final double attendance;

  // Add 'const' keyword to the constructor
  const PerformanceData({
    this.theory = 0.0,
    this.practical = 0.0,
    this.attendance = 0.0,
  });

  @override
  List<Object?> get props => [theory, practical, attendance]; // Implement props
}

class SubjectPerformance extends Equatable {
  final String subject;
  final double value;
  final bool isFailure;

  const SubjectPerformance({
    required this.subject,
    required this.value,
    this.isFailure = false, // Optional, defaults to false
  });

  @override
  List<Object?> get props => [subject, value, isFailure];
}