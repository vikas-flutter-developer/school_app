import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';import '../../Student_Academic/model.dart';

import '../models/student_performance.dart';
// Ensure this points to the Student model file

enum DetailStatus { initial, loading, success, failure }

class StudentDetailState extends Equatable {
  final DetailStatus status;
  final Student? student;
  final String previousScreenTitle;
  final PerformanceData performanceData;
  // ----- Ensure this type matches EXACTLY what's in student_performance.dart -----
  final List<SubjectPerformance> subjectGraphData;
  // ----------------------------------------------------------------------------
  final List<FlSpot> growthData;
  final int bottomNavIndex;
  final String? errorMessage;

  const StudentDetailState({
    this.status = DetailStatus.initial,
    this.student,
    this.previousScreenTitle = '',
    this.performanceData = const PerformanceData(),
    this.subjectGraphData = const [], // Default value
    this.growthData = const [],
    this.bottomNavIndex = 0,
    this.errorMessage,
  });

  String get breadcrumbTitle {
    if (student == null) return previousScreenTitle;
    return '$previousScreenTitle > ${student!.name}';
  }

  // ----- Verify the signature and implementation of copyWith -----
  StudentDetailState copyWith({
    DetailStatus? status,
    Student? student,
    String? previousScreenTitle,
    PerformanceData? performanceData,
    // ----- Ensure this parameter type is correct -----
    List<SubjectPerformance>? subjectGraphData,
    // ---------------------------------------------
    List<FlSpot>? growthData,
    int? bottomNavIndex,
    String? errorMessage,
    bool clearError = false,
  }) {
    return StudentDetailState(
      status: status ?? this.status,
      student: student ?? this.student,
      previousScreenTitle: previousScreenTitle ?? this.previousScreenTitle,
      performanceData: performanceData ?? this.performanceData,
      // ----- Ensure the assignment uses the parameter -----
      subjectGraphData: subjectGraphData ?? this.subjectGraphData,
      // ------------------------------------------------
      growthData: growthData ?? this.growthData,
      bottomNavIndex: bottomNavIndex ?? this.bottomNavIndex,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
  // ------------------------------------------------------------

  @override
  List<Object?> get props => [
    status,
    student,
    previousScreenTitle,
    performanceData,
    subjectGraphData, // Ensure this field is included in props
    growthData,
    bottomNavIndex,
    errorMessage,
  ];
}