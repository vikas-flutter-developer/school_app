part of 'staff_screen_bloc.dart';

@immutable
abstract class StaffScreenState {}

class StaffScreenInitial extends StaffScreenState {}

class StaffScreenLoading extends StaffScreenState {}

class StaffScreenLoaded extends StaffScreenState {
  final List<StaffMember>
  originalStaffList; // To keep the full list for filtering
  final List<StaffMember> displayStaffList; // List to display (can be filtered)
  final List<AttendanceRecord> attendanceList;
  final int selectedTabIndex;
  final String searchQuery;

  StaffScreenLoaded({
    required this.originalStaffList,
    required this.displayStaffList,
    required this.attendanceList,
    required this.selectedTabIndex,
    this.searchQuery = "",
  });

  StaffScreenLoaded copyWith({
    List<StaffMember>? originalStaffList,
    List<StaffMember>? displayStaffList,
    List<AttendanceRecord>? attendanceList,
    int? selectedTabIndex,
    String? searchQuery,
  }) {
    return StaffScreenLoaded(
      originalStaffList: originalStaffList ?? this.originalStaffList,
      displayStaffList: displayStaffList ?? this.displayStaffList,
      attendanceList: attendanceList ?? this.attendanceList,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class StaffScreenError extends StaffScreenState {
  final String message;
  StaffScreenError(this.message);
}
