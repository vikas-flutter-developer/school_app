import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart'; // For Colors
import 'package:intl/intl.dart';

import '../model/student_fee_record.dart';
import 'fee_event.dart';
import 'fee_state.dart'; // For date formatting if needed

class FeesBloc extends Bloc<FeesEvent, FeesState> {
  FeesBloc() : super(FeesState()) {
    on<FeesLoadInitialData>(_onLoadInitialData);
    on<FeesOverviewFilterChanged>(_onOverviewFilterChanged);
    on<FeesStudentFilterChanged>(_onStudentFilterChanged);
    on<FeesStudentSearchChanged>(_onStudentSearchChanged);
    on<FeesDownloadRequested>(_onDownloadRequested);
  }

  // --- Event Handlers ---

  Future<void> _onLoadInitialData(
    FeesLoadInitialData event,
    Emitter<FeesState> emit,
  ) async {
    emit(state.copyWith(status: FeesStatus.loading));
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      // --- Mock Data ---
      final mockStudents = generateMockStudentData();

      // Mock chart data (replace with actual calculations/fetching)
      final paymentStatus = {
        'Paid Fees': 65.0,
        'Unpaid Fees': 25.0,
        'Overdue Fees': 10.0,
      };
      final feeStructure = {
        'Total Fees': 70.0,
        'Refunded': 5.0,
        'Partial': 15.0,
        'Others': 10.0,
      };
      final overallTrack = {
        'Term- I': {'Paid': 98.0, 'Unpaid': 0.0, 'Overdue': 2.0},
        'Term- II': {'Paid': 75.0, 'Unpaid': 2.0, 'Overdue': 23.0},
        'Term- III': {'Paid': 35.0, 'Unpaid': 63.0, 'Overdue': 2.0},
        'Final Exam': {'Paid': 65.0, 'Unpaid': 0.0, 'Overdue': 35.0},
      };
      // --- End Mock Data ---

      emit(
        state.copyWith(
          status: FeesStatus.success,
          allStudents: mockStudents,
          // Initialize filtered list with all students based on initial filters
          filteredStudents: _filterStudents(
            mockStudents,
            state.selectedStudentType,
            state.selectedStudentClass,
            state.selectedStudentTerm,
            state.studentSearchQuery,
          ),
          paymentStatusData: paymentStatus,
          feeStructureData: feeStructure,
          overallTrackData: overallTrack,
          // Ensure initial filter values are set if needed
          selectedStudentClass:
              state.selectedStudentClass, // Keep existing default
          selectedStudentTerm:
              state.selectedStudentTerm, // Keep existing default
          selectedStudentType:
              state.selectedStudentType, // Keep existing default
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FeesStatus.failure,
          errorMessage: "Failed to load data: ${e.toString()}",
        ),
      );
    }
  }

  void _onOverviewFilterChanged(
    FeesOverviewFilterChanged event,
    Emitter<FeesState> emit,
  ) {
    emit(state.copyWith(status: FeesStatus.loading));
    // Simulate fetching/recalculating data based on new filters
    // In a real app, you might make an API call here or re-process data
    // For now, just update the selected filters and potentially mock-update charts if needed
    // For simplicity, we are not dynamically changing chart data based on filters in this example
    emit(
      state.copyWith(
        status: FeesStatus.success, // Assume success after filter update
        selectedOverviewClass:
            event.selectedClass ?? state.selectedOverviewClass,
        selectedOverviewTerm: event.selectedTerm ?? state.selectedOverviewTerm,
        selectedOverviewDate: event.selectedDate ?? state.selectedOverviewDate,
        // Potentially update overallTrackData here if it depends on filters
      ),
    );
  }

  void _onStudentFilterChanged(
    FeesStudentFilterChanged event,
    Emitter<FeesState> emit,
  ) {
    // Update selected filters immediately for responsive UI
    final newType = event.selectedType ?? state.selectedStudentType;
    final newClass = event.selectedClass ?? state.selectedStudentClass;
    final newTerm = event.selectedTerm ?? state.selectedStudentTerm;

    emit(
      state.copyWith(
        selectedStudentType: newType,
        selectedStudentClass: newClass,
        selectedStudentTerm: newTerm,
        // Re-filter the list based on the *new* filter values
        filteredStudents: _filterStudents(
          state.allStudents,
          newType,
          newClass,
          newTerm,
          state.studentSearchQuery,
        ),
      ),
    );
  }

  void _onStudentSearchChanged(
    FeesStudentSearchChanged event,
    Emitter<FeesState> emit,
  ) {
    emit(
      state.copyWith(
        studentSearchQuery: event.query,
        // Re-filter based on the new query and existing filters
        filteredStudents: _filterStudents(
          state.allStudents,
          state.selectedStudentType,
          state.selectedStudentClass,
          state.selectedStudentTerm,
          event.query, // Use the new query
        ),
      ),
    );
  }

  void _onDownloadRequested(
    FeesDownloadRequested event,
    Emitter<FeesState> emit,
  ) {
    // Implement download logic here
    // e.g., generate CSV/PDF from state.filteredStudents
    print("Download requested for ${state.filteredStudents.length} students.");
    // You might want to emit a state to show a confirmation or progress
  }

  // --- Helper Methods ---

  List<StudentFeeRecord> _filterStudents(
    List<StudentFeeRecord> allStudents,
    String type,
    String className,
    String term,
    String query,
  ) {
    // In a real app, filtering logic might be more complex or done server-side
    // This is a basic client-side filter example
    return allStudents.where((student) {
      // Apply filters (add type/class filtering if needed)
      bool termMatch = student.term == term; // Simple term match for now
      // bool classMatch = student.class == className; // Need class field in model
      // bool typeMatch = ... // Need type field in model

      bool queryMatch = true;
      if (query.isNotEmpty) {
        queryMatch =
            student.name.toLowerCase().contains(query.toLowerCase()) ||
            student.rollNo.contains(query);
      }

      // Combine filter conditions
      return termMatch &&
          queryMatch; // Add other matches here: && classMatch && typeMatch
    }).toList();
  }
}
