import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/student_staff_detail.dart';
part 'student_staff_details_event.dart';
part 'student_staff_details_state.dart';
// ******************************

class StudentStaffDetailsBloc extends Bloc<StudentStaffDetailsEvent, StudentStaffDetailsState> {
  // Constructor uses the initial factory from the (correctly linked) state file
  StudentStaffDetailsBloc() : super(StudentStaffDetailsState.initial()) {
    // Event handlers (keep the implementation from the previous answer)
    on<LoadInitialData>(_onLoadInitialData);
    on<TabSelected>(_onTabSelected);
    on<StudentAcademicYearSelected>(_onStudentFilterChanged);
    on<StudentTypeStatusSelected>(_onStudentFilterChanged);
    on<StudentClassSelected>(_onStudentFilterChanged);
    on<StudentFilterOptionSelected>(_onStudentFilterChanged);
    on<StaffFilterSelected>(_onStaffFilterChanged);
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<PageChanged>(_onPageChanged);
    on<BottomNavTapped>(_onBottomNavTapped);

    add(LoadInitialData());
  }

  // --- Keep the rest of the BLoC methods (_loadData, _on..., _filter...) ---
  // --- as they were in the previous correct answer. ---
  Future<void> _loadData(Emitter<StudentStaffDetailsState> emit) async { // Corrected type hint
    emit(state.copyWith(status: DataStatus.loading, clearError: true));
    try {
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate API

      // Based on selectedTab and filters, fetch appropriate data
      if (state.selectedTab == DetailTab.student) {
        final fetchedStudents = _filterStudentData(dummyStudentDetails, state); // Use dummy filtering
        emit(state.copyWith(
          status: DataStatus.success,
          studentList: fetchedStudents,
          studentTotalPages: (dummyStudentDetails.length / 10).ceil(), // Example pagination calculation
        ));
      } else {
        final fetchedStaff = _filterStaffData(dummyStaffDetails, state); // Use dummy filtering
        emit(state.copyWith(
          status: DataStatus.success,
          staffList: fetchedStaff,
          staffTotalPages: (dummyStaffDetails.length / 10).ceil(), // Example pagination calculation
        ));
      }

    } catch (e) {
      emit(state.copyWith(status: DataStatus.failure, errorMessage: e.toString()));
    }
  }


  Future<void> _onLoadInitialData(LoadInitialData event, Emitter<StudentStaffDetailsState> emit) async {
    await _loadData(emit);
  }

  Future<void> _onTabSelected(TabSelected event, Emitter<StudentStaffDetailsState> emit) async {
    if (state.selectedTab.index == event.tabIndex) return;

    emit(state.copyWith(
      selectedTab: DetailTab.values[event.tabIndex],
      generalSearchQuery: '',
      studentSpecificSearchQuery: '',
      staffSpecificSearchQuery: '',
      studentCurrentPage: 1,
      staffCurrentPage: 1,
    ));
    await _loadData(emit);
  }

  Future<void> _onStudentFilterChanged(StudentStaffDetailsEvent event, Emitter<StudentStaffDetailsState> emit) async {
    StudentStaffDetailsState newState = state;
    if (event is StudentAcademicYearSelected) {
      newState = state.copyWith(studentAcademicYear: event.year, clearStudentAcademicYear: event.year == null);
    } else if (event is StudentTypeStatusSelected) {
      newState = state.copyWith(studentTypeStatus: event.typeStatus, clearStudentTypeStatus: event.typeStatus == null);
    } else if (event is StudentClassSelected) {
      newState = state.copyWith(studentClass: event.className, clearStudentClass: event.className == null);
    } else if (event is StudentFilterOptionSelected) {
      newState = state.copyWith(studentFilterOption: event.option, clearStudentFilterOption: event.option == null);
    }
    emit(newState.copyWith(studentCurrentPage: 1));
    await _loadData(emit);
  }


  Future<void> _onStaffFilterChanged(StaffFilterSelected event, Emitter<StudentStaffDetailsState> emit) async {
    emit(state.copyWith(staffFilterValue: event.filterValue, clearStaffFilterValue: event.filterValue == null, staffCurrentPage: 1));
    await _loadData(emit);
  }

  Future<void> _onSearchQueryChanged(SearchQueryChanged event, Emitter<StudentStaffDetailsState> emit) async {
    if (state.selectedTab == DetailTab.student) {
      emit(state.copyWith(studentSpecificSearchQuery: event.query, studentCurrentPage: 1));
    } else {
      emit(state.copyWith(staffSpecificSearchQuery: event.query, staffCurrentPage: 1));
    }
    await _loadData(emit);
  }

  Future<void> _onPageChanged(PageChanged event, Emitter<StudentStaffDetailsState> emit) async {
    int currentPage = (state.selectedTab == DetailTab.student) ? state.studentCurrentPage : state.staffCurrentPage;
    int totalPages = (state.selectedTab == DetailTab.student) ? state.studentTotalPages : state.staffTotalPages;
    // Assuming event.page is direction (-1 or 1) for simplicity now
    int newPage = currentPage + event.page;

    if (newPage >= 1 && newPage <= totalPages) {
      if (state.selectedTab == DetailTab.student) {
        emit(state.copyWith(studentCurrentPage: newPage));
      } else {
        emit(state.copyWith(staffCurrentPage: newPage));
      }
      await _loadData(emit);
    }
  }


  void _onBottomNavTapped(BottomNavTapped event, Emitter<StudentStaffDetailsState> emit) {
    emit(state.copyWith(bottomNavIndex: event.index));
  }

  List<StudentDetailItem> _filterStudentData(List<StudentDetailItem> allStudents, StudentStaffDetailsState currentState) {
    var filtered = allStudents;
    // --- TODO: Implement actual filtering based on currentState dropdowns ---
    // Example:
    // if (currentState.studentAcademicYear != null) {
    //   filtered = filtered.where((s) => s.academicYear == currentState.studentAcademicYear).toList(); // Assuming model has academicYear
    // }
    // ... filter by type/status, class ...

    // Apply specific search
    if(currentState.studentSpecificSearchQuery!.isNotEmpty) {
      final query = currentState.studentSpecificSearchQuery?.toLowerCase();
      filtered = filtered.where((s) =>
      s.studentName.toLowerCase().contains(query as Pattern) ||
          s.admissionNo.contains(query as Pattern) ||
          s.contactNo.contains(query as Pattern) ||
          s.section.toLowerCase().contains(query as Pattern) // Added section to search
      ).toList();
    }
    // Apply pagination
    int startIndex = (currentState.studentCurrentPage - 1) * 10; // Assume 10 items/page
    int endIndex = startIndex + 10;
    if (startIndex >= filtered.length) return [];
    if (endIndex > filtered.length) endIndex = filtered.length;
    return filtered.sublist(startIndex, endIndex);
  }

  List<StaffDetailItem> _filterStaffData(List<StaffDetailItem> allStaff, StudentStaffDetailsState currentState) {
    var filtered = allStaff;
    // --- TODO: Implement actual filtering based on staffFilterValue ---
    // Example:
    // if (currentState.staffFilterValue != null) {
    //    // Use staffFilterOption from state to know which field to filter on
    //    // e.g., if (currentState.staffFilterOption == 'Department') {
    //    //   filtered = filtered.where((s) => s.department == currentState.staffFilterValue).toList();
    //    // }
    // }

    // Apply specific search
    if(currentState.staffSpecificSearchQuery!.isNotEmpty) {
      final query = currentState.staffSpecificSearchQuery!.toLowerCase();
      filtered = filtered.where((s) =>
      s.staffName.toLowerCase().contains(query) ||
          s.employeeId.contains(query) ||
          s.department.toLowerCase().contains(query) ||
          s.email.toLowerCase().contains(query) ||
          s.contactNo.contains(query) // Added contact to search
      ).toList();
    }
    // Apply pagination
    int startIndex = (currentState.staffCurrentPage - 1) * 10;
    int endIndex = startIndex + 10;
    if (startIndex >= filtered.length) return [];
    if (endIndex > filtered.length) endIndex = filtered.length;
    return filtered.sublist(startIndex, endIndex);
  }
}