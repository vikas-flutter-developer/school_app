import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/exam_schedule.dart';
part 'student_exam_event.dart';
part 'student_exam_state.dart';

class StudentExamBloc extends Bloc<StudentExamEvent, StudentExamState> {
  StudentExamBloc() : super(const StudentExamState(
    // Set initial selections to match the title in the image
      selectedClass: 'Class X',
      selectedSection: 'A',
      selectedAcademicYear: '2024-25',
      selectedSemester: '1st semester'
  )) {
    // Register event handlers
    on<LoadExamData>(_onLoadExamData);
    on<ClassSelected>(_onClassSelected);
    on<SectionSelected>(_onSectionSelected);
    on<SemesterSelected>(_onSemesterSelected);
    on<AcademicYearSelected>(_onAcademicYearSelected);
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<BottomNavTapped>(_onBottomNavTapped);

    // Trigger initial load
    add(LoadExamData());
  }

  Future<void> _onLoadExamData(
      LoadExamData event, Emitter<StudentExamState> emit) async {
    emit(state.copyWith(status: DataStatus.loading, clearError: true));
    try {
      // Simulate network delay or actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      // In a real app, fetch data based on initial state filters
      // (state.selectedClass, state.selectedSection, etc.)
      const fetchedExams = dummyExams; // Using dummy data for now

      emit(state.copyWith(
        status: DataStatus.success,
        allExams: fetchedExams,
        filteredExams: _filterExams(fetchedExams, state.searchQuery), // Apply initial search if any
      ));
    } catch (e) {
      emit(state.copyWith(status: DataStatus.failure, errorMessage: e.toString()));
    }
  }

  // --- Filter Handlers ---
  // In a real app, these might trigger a new data fetch (add(LoadExamData()))
  // or just update the local filter state. For this example, we just update state
  // and rely on _updateFilteredList to apply the search.

  void _onClassSelected(ClassSelected event, Emitter<StudentExamState> emit) {
    emit(state.copyWith(selectedClass: event.selectedClass, clearClass: event.selectedClass == null));
    _updateFilteredList(emit); // Re-apply search filter
  }

  void _onSectionSelected(SectionSelected event, Emitter<StudentExamState> emit) {
    emit(state.copyWith(selectedSection: event.selectedSection, clearSection: event.selectedSection == null));
    _updateFilteredList(emit);
  }

  void _onSemesterSelected(SemesterSelected event, Emitter<StudentExamState> emit) {
    emit(state.copyWith(selectedSemester: event.selectedSemester, clearSemester: event.selectedSemester == null));
    _updateFilteredList(emit);
  }

  void _onAcademicYearSelected(AcademicYearSelected event, Emitter<StudentExamState> emit) {
    emit(state.copyWith(selectedAcademicYear: event.selectedYear, clearAcademicYear: event.selectedYear == null));
    _updateFilteredList(emit);
  }

  // --- Search Handler ---
  void _onSearchQueryChanged(SearchQueryChanged event, Emitter<StudentExamState> emit) {
    // No need to update state here for the query itself,
    // just call _updateFilteredList which uses the latest query from the event
    _updateFilteredList(emit, searchQuery: event.query); // Pass the new query directly
  }

  // --- Navigation Handler ---
  void _onBottomNavTapped(BottomNavTapped event, Emitter<StudentExamState> emit) {
    emit(state.copyWith(bottomNavIndex: event.index));
  }


  // --- Helper to Apply Filters ---
  // This example only filters by search query.
  // A real app would also filter by selectedClass, section, etc. here
  // before applying the search query.
  void _updateFilteredList(Emitter<StudentExamState> emit, {String? searchQuery}) {
    final query = searchQuery ?? state.searchQuery; // Use new query or current state query
    final filtered = _filterExams(state.allExams, query);
    // Emit state with updated query AND filtered list
    emit(state.copyWith(searchQuery: query, filteredExams: filtered));
  }

  List<ExamSchedule> _filterExams(List<ExamSchedule> exams, String query) {
    if (query.isEmpty) {
      return exams; // No search query, return all
    }
    final lowerCaseQuery = query.toLowerCase();
    // Add filtering based on selected dropdowns here if needed before search
    // Example: exams = exams.where((e) => e.class == state.selectedClass).toList(); ...

    return exams.where((exam) {
      // Search across relevant fields
      return exam.subject.toLowerCase().contains(lowerCaseQuery) ||
          exam.examDate.contains(lowerCaseQuery) || // Simple date search
          exam.timing.contains(lowerCaseQuery) ||
          exam.invigilator.toLowerCase().contains(lowerCaseQuery) ||
          exam.roomNo.toLowerCase().contains(lowerCaseQuery);
    }).toList();
  }
}