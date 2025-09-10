// --- Exam Overview Bloc ---
// lib/presentation/blocs/exam_overview/exam_overview_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart'; // For Color
import 'package:intl/intl.dart';

import '../../../data/models/exam_schedule.dart'; // For date formatting

part 'exam_overview_event.dart';
part 'exam_overview_state.dart';

class ExamOverviewBloc extends Bloc<ExamOverviewEvent, ExamOverviewState> {
  // Inject Repository here: final ExamRepository _repository;

  ExamOverviewBloc(/* required ExamRepository repository */)
    : super(const ExamOverviewState()) /* : _repository = repository */ {
    on<LoadExamOverview>(_onLoadExamOverview);
    on<SelectExamClass>(_onSelectExamClass);
    on<SelectExamTerm>(_onSelectExamTerm);
    on<SelectExamMonth>(_onSelectExamMonth);
    on<SelectExamSubject>(_onSelectExamSubject);
    on<SwitchExamTab>(_onSwitchExamTab);

    // Trigger initial load when Bloc is created
    add(const LoadExamOverview());
  }

  // Helper to fetch data based on current state filters
  Future<void> _fetchData(Emitter<ExamOverviewState> emit) async {
    emit(state.copyWith(status: ExamOverviewStatus.loading, clearError: true));
    try {
      // Simulate fetching data based on ALL current filters in the state
      await Future.delayed(const Duration(milliseconds: 500));

      final planItems = _getMockExamPlanItems(
        state.selectedClass,
        state.selectedTerm,
        state.selectedSubject,
      );
      final timetableItems = _getMockExamTimetableItems(
        state.selectedClass,
        state.selectedTerm,
        state.selectedMonth,
        state.selectedSubject,
      );
      // In a real app, fetch available filters dynamically too if needed
      // final availableFilters = await _repository.getAvailableFilters();

      emit(
        state.copyWith(
          status: ExamOverviewStatus.success,
          examPlanItems: planItems,
          examTimetableItems: timetableItems,
          // Update available filters if fetched:
          // availableClasses: availableFilters.classes, ...etc
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ExamOverviewStatus.failure,
          errorMessage: "Failed to load exam data: ${e.toString()}",
          examPlanItems: [], // Clear data on error
          examTimetableItems: [],
        ),
      );
    }
  }

  Future<void> _onLoadExamOverview(
    LoadExamOverview event,
    Emitter<ExamOverviewState> emit,
  ) async {
    await _fetchData(emit);
  }

  Future<void> _onSelectExamClass(
    SelectExamClass event,
    Emitter<ExamOverviewState> emit,
  ) async {
    if (event.selectedClass != state.selectedClass) {
      emit(
        state.copyWith(selectedClass: event.selectedClass),
      ); // Update state first
      await _fetchData(emit); // Refetch data with new filter
    }
  }

  Future<void> _onSelectExamTerm(
    SelectExamTerm event,
    Emitter<ExamOverviewState> emit,
  ) async {
    if (event.selectedTerm != state.selectedTerm) {
      emit(state.copyWith(selectedTerm: event.selectedTerm));
      await _fetchData(emit);
    }
  }

  Future<void> _onSelectExamMonth(
    SelectExamMonth event,
    Emitter<ExamOverviewState> emit,
  ) async {
    // Handle 'All' month selection - treat as null filter
    final newMonth = event.selectedMonth == 'All' ? null : event.selectedMonth;
    if (newMonth != state.selectedMonth) {
      emit(
        state.copyWith(
          selectedMonth: newMonth,
          setMonthToNull: newMonth == null,
        ),
      );
      await _fetchData(emit);
    }
  }

  Future<void> _onSelectExamSubject(
    SelectExamSubject event,
    Emitter<ExamOverviewState> emit,
  ) async {
    // Handle 'All' subject selection - treat as null filter
    final newSubject =
        event.selectedSubject == 'All' ? null : event.selectedSubject;
    if (newSubject != state.selectedSubject) {
      emit(
        state.copyWith(
          selectedSubject: newSubject,
          setSubjectToNull: newSubject == null,
        ),
      );
      await _fetchData(emit);
    }
  }

  void _onSwitchExamTab(SwitchExamTab event, Emitter<ExamOverviewState> emit) {
    // If data for both tabs is always fetched together (as implemented here),
    // just update the index. No need to refetch.
    if (event.tabIndex != state.activeTabIndex) {
      emit(state.copyWith(activeTabIndex: event.tabIndex));
    }
    // If data were fetched lazily per tab, you might trigger _fetchData here
    // if the necessary data (planItems or timetableItems) is empty.
  }

  // --- Mock Data Generation ---

  List<ExamPlanItem> _getMockExamPlanItems(
    String classId,
    String termId,
    String? subjectFilter,
  ) {
    List<ExamPlanItem> allItems = [
      ExamPlanItem(
        subject: 'Mathematics',
        type: 'Theory',
        date: DateTime(2025, 3, 10),
        time: const TimeOfDay(hour: 9, minute: 0),
        color: Colors.red.shade300,
      ),
      ExamPlanItem(
        subject: 'Science',
        type: 'Biology Theory',
        date: DateTime(2025, 3, 12),
        time: const TimeOfDay(hour: 9, minute: 0),
        color: Colors.blue.shade300,
      ),
      ExamPlanItem(
        subject: 'English',
        type: 'Theory',
        date: DateTime(2025, 3, 17),
        time: const TimeOfDay(hour: 9, minute: 0),
        color: Colors.orange.shade300,
      ),
      ExamPlanItem(
        subject: 'Social Studies',
        type: 'Theory',
        date: DateTime(2025, 3, 19),
        time: const TimeOfDay(hour: 9, minute: 0),
        color: Colors.green.shade300,
      ),
      ExamPlanItem(
        subject: 'Moral Science',
        type: 'Theory',
        date: DateTime(2025, 3, 20),
        time: const TimeOfDay(hour: 9, minute: 0),
        color: Colors.purple.shade300,
      ),
      ExamPlanItem(
        subject: 'Computer',
        type: 'Theory',
        date: DateTime(2025, 3, 21),
        time: const TimeOfDay(hour: 9, minute: 0),
        color: Colors.lightGreen.shade400,
      ),
      // Add more for different terms/classes if needed
    ];

    // Apply subject filter
    if (subjectFilter != null && subjectFilter != 'All') {
      return allItems.where((item) => item.subject == subjectFilter).toList();
    }
    // Apply term filter (rudimentary example: show only March for Term-I)
    if (termId == 'Term-I') {
      return allItems.where((item) => item.date.month == 3).toList();
    } else if (termId == 'Term-II') {
      // Add mock data for Term-II (e.g., September)
      return []; // Placeholder
    }

    return allItems;
  }

  List<ExamTimetableItem> _getMockExamTimetableItems(
    String classId,
    String termId,
    String? monthFilter,
    String? subjectFilter,
  ) {
    DateTime baseDate = DateTime(2025, 3, 10); // March 10, 2025

    List<ExamTimetableItem> allItems = [
      ExamTimetableItem(
        subject: 'Science',
        term: 'Term-I',
        dateTime: baseDate,
        startTime: const TimeOfDay(hour: 9, minute: 0),
        endTime: const TimeOfDay(hour: 12, minute: 0),
        teacher: 'Nirmala',
        roomNo: '101',
        status: ExamStatus.Completed,
      ),
      ExamTimetableItem(
        subject: 'Science',
        term: 'Term-I',
        dateTime: baseDate.add(const Duration(days: 1)),
        startTime: const TimeOfDay(hour: 9, minute: 0),
        endTime: const TimeOfDay(hour: 12, minute: 0),
        teacher: 'Nirmala',
        roomNo: '101',
        status: ExamStatus.Ongoing,
      ),
      ExamTimetableItem(
        subject: 'Science',
        term: 'Term-I',
        dateTime: baseDate.add(const Duration(days: 2)),
        startTime: const TimeOfDay(hour: 9, minute: 0),
        endTime: const TimeOfDay(hour: 12, minute: 0),
        teacher: 'Nirmala',
        roomNo: '101',
        status: ExamStatus.Postponed,
      ),
      ExamTimetableItem(
        subject: 'Mathematics',
        term: 'Term-I',
        dateTime: baseDate.add(const Duration(days: 3)),
        startTime: const TimeOfDay(hour: 9, minute: 0),
        endTime: const TimeOfDay(hour: 12, minute: 0),
        teacher: 'Suresh',
        roomNo: '102',
        status: ExamStatus.Completed,
      ),
      ExamTimetableItem(
        subject: 'English',
        term: 'Term-I',
        dateTime: baseDate.add(const Duration(days: 4)),
        startTime: const TimeOfDay(hour: 9, minute: 0),
        endTime: const TimeOfDay(hour: 11, minute: 0),
        teacher: 'Priya',
        roomNo: '101',
        status: ExamStatus.Upcoming,
      ), // Added Upcoming
      // Add items for different terms/months/classes
    ];

    // Apply filters
    List<ExamTimetableItem> filteredItems = allItems;

    // Term Filter (Example)
    filteredItems = filteredItems.where((item) => item.term == termId).toList();

    // Month Filter (Example - requires intl package)
    if (monthFilter != null && monthFilter != 'All') {
      filteredItems =
          filteredItems.where((item) {
            // Compare month name (case-insensitive)
            String itemMonth = DateFormat('MMMM').format(item.dateTime);
            return itemMonth.toLowerCase() == monthFilter.toLowerCase();
          }).toList();
    }

    // Subject Filter
    if (subjectFilter != null && subjectFilter != 'All') {
      filteredItems =
          filteredItems.where((item) => item.subject == subjectFilter).toList();
    }

    return filteredItems;
  }
}
