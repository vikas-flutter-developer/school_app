// bloc/student_academics/student_academics_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
 // Adjust path as needed
import 'dart:async';

import '../model.dart'; // For Future.delayed

part 'student_academics_event.dart';
part 'student_academics_state.dart';

class StudentAcademicsBloc extends Bloc<StudentAcademicsEvent, StudentAcademicsState> {
  StudentAcademicsBloc() : super(const StudentAcademicsState()) {
    on<LoadStudentData>(_onLoadStudentData);
    on<ClassSelected>(_onClassSelected);
    on<SectionSelected>(_onSectionSelected);
    on<AcademicYearSelected>(_onAcademicYearSelected);
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<BottomNavTapped>(_onBottomNavTapped);

    // Trigger initial load
    add(LoadStudentData());
  }

  Future<void> _onLoadStudentData(
      LoadStudentData event, Emitter<StudentAcademicsState> emit) async {
    emit(state.copyWith(status: DataStatus.loading));
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // In a real app, fetch data based on initial filters if any
      // For now, just load dummy data
      const allStudents = dummyStudents;

      emit(state.copyWith(
        status: DataStatus.success,
        students: allStudents,
        // Initially, filtered list is the full list
        filteredStudents: _filterStudents(allStudents, state.searchQuery),
        // Set default selections if needed, e.g. from LoadStudentData event
        selectedClass: 'Class X', // Default selection matching the image label
        selectedSection: 'A', // Default selection matching the image label
        selectedAcademicYear: '2024-25', // Default selection matching the image label
      ));

    } catch (e) {
      emit(state.copyWith(status: DataStatus.failure, errorMessage: e.toString()));
    }
  }

  void _onClassSelected(
      ClassSelected event, Emitter<StudentAcademicsState> emit) {
    emit(state.copyWith(
        selectedClass: event.selectedClass, clearClass: event.selectedClass == null));
    // Optionally re-fetch or re-filter data based on the new selection
    _updateFilteredList(emit);
  }

  void _onSectionSelected(
      SectionSelected event, Emitter<StudentAcademicsState> emit) {
    emit(state.copyWith(
        selectedSection: event.selectedSection, clearSection: event.selectedSection == null));
    _updateFilteredList(emit);
  }

  void _onAcademicYearSelected(
      AcademicYearSelected event, Emitter<StudentAcademicsState> emit) {
    emit(state.copyWith(
        selectedAcademicYear: event.selectedYear, clearAcademicYear: event.selectedYear == null));
    _updateFilteredList(emit);
  }

  void _onSearchQueryChanged(
      SearchQueryChanged event, Emitter<StudentAcademicsState> emit) {
    emit(state.copyWith(searchQuery: event.query));
    _updateFilteredList(emit);
  }

  void _onBottomNavTapped(
      BottomNavTapped event, Emitter<StudentAcademicsState> emit) {
    emit(state.copyWith(bottomNavIndex: event.index));
    // Handle navigation or actions based on index if needed within the BLoC,
    // although navigation is often handled in the UI layer based on state changes.
  }


  // Helper function to apply filters (currently only search)
  void _updateFilteredList(Emitter<StudentAcademicsState> emit) {
    // In a real app, you might re-fetch data based on selectedClass, section, year
    // For now, we just filter the existing list by search query.
    // You could add filtering logic based on dropdowns here if needed.
    final filtered = _filterStudents(state.students, state.searchQuery);
    emit(state.copyWith(filteredStudents: filtered));
  }

  List<Student> _filterStudents(List<Student> students, String query) {
    if (query.isEmpty) {
      return students;
    }
    final lowerCaseQuery = query.toLowerCase();
    return students.where((student) {
      return student.name.toLowerCase().contains(lowerCaseQuery) ||
          student.admissionNo.contains(lowerCaseQuery) || // Assuming admission no can be searched
          student.contactNo.contains(lowerCaseQuery); // Assuming contact no can be searched
    }).toList();
  }
}