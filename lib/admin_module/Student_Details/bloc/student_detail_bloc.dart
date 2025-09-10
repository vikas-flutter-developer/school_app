// student_detail_bloc.dart

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../Student_Academic/model.dart';
import '../models/student_performance.dart';
import 'student_detail_state.dart';

// --- USE 'part' for the event file ---
part 'student_detail_event.dart';
// -----------------------------------


class StudentDetailBloc extends Bloc<StudentDetailEvent, StudentDetailState> {
  // Constructor uses the imported state
  StudentDetailBloc() : super(const StudentDetailState()) {
    on<LoadStudentDetails>(_onLoadStudentDetails);
    on<BottomNavTapped>(_onBottomNavTapped);
  }

  Future<void> _onLoadStudentDetails(
      LoadStudentDetails event, Emitter<StudentDetailState> emit) async {

    // State update using imported State and its copyWith
    emit(state.copyWith(
        status: DetailStatus.loading,
        student: event.student,
        previousScreenTitle: event.previousScreenTitle,
        clearError: true));

    try {
      await Future.delayed(const Duration(milliseconds: 800));

      // Create data using imported models
      final performance = PerformanceData(theory: 73, practical: 80, attendance: 67);

      // Create List<SubjectPerformance> using imported model
      final subjects = [
        SubjectPerformance(subject: '1 lang', value: 82),
        SubjectPerformance(subject: '2 lang', value: 65),
        SubjectPerformance(subject: 'Math', value: 91),
        SubjectPerformance(subject: 'Hist', value: 28, isFailure: true),
        SubjectPerformance(subject: 'Geog', value: 45),
        SubjectPerformance(subject: 'Sci', value: 88),
      ];

      // Create List<FlSpot> using imported fl_chart
      final growth = [
        const FlSpot(0, 15),
        const FlSpot(1, 45),
        const FlSpot(2, 65),
        const FlSpot(3, 75),
        const FlSpot(4, 55),
        const FlSpot(5, 30),
      ];

      // *** If error occurs here ***
      // It means the type List<SubjectPerformance> (from the 'subjects' variable)
      // is not assignable to the 'subjectGraphData' parameter in the state's 'copyWith' method.
      // This points STRONGLY to the 'part of' directive being wrong in student_detail_state.dart
      // or a conflicting definition/import of SubjectPerformance.
      emit(state.copyWith(
        status: DetailStatus.success,
        performanceData: performance,
        subjectGraphData: subjects, // <<< The problematic line
        growthData: growth,
      ));
      // *****************************

    } catch (e) {
      emit(state.copyWith(status: DetailStatus.failure, errorMessage: e.toString()));
    }
  }

  void _onBottomNavTapped(
      BottomNavTapped event, Emitter<StudentDetailState> emit) {
    // State update using imported State and its copyWith
    emit(state.copyWith(bottomNavIndex: event.index));
  }
}