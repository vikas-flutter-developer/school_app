import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/attendance_record.dart';
import '../../models/staff_member.dart';

part 'staff_screen_event.dart';
part 'staff_screen_state.dart';

class StaffScreenBloc extends Bloc<StaffScreenEvent, StaffScreenState> {
  // Sample data - In a real app, this would come from a repository/service
  final List<StaffMember> _allStaff = [
    StaffMember.fromMap({
      'id': 'A5 335 5547',
      'department': 'Kitchen',
      'name': 'Vishu Pratap',
      'mobile': '+91 98546 64758',
      'email': 'vishu@example.com',
      'address': 'Area, 423 456',
      'type': 'Contract',
      'status': 'Pending',
      'imageUrl': 'assets/images/profileimage.png', // Ensure asset exists
      'academicYear': '2024-2025',
    }),
    StaffMember.fromMap({
      'id': 'A5 335 5548',
      'department': 'Cleaning',
      'name': 'Manoj Mishra',
      'mobile': '+91 98765 43210',
      'email': 'manoj@example.com',
      'address': 'Sector B, 789 123',
      'type': 'Permanent',
      'status': 'Verified',
      'imageUrl': 'assets/images/profileimage.png', // Ensure asset exists
      'academicYear': '2024-2025',
    }),
    StaffMember.fromMap({
      'id': 'A5 335 5549',
      'department': 'Kitchen',
      'name': 'Lakshmi Devi',
      'mobile': '+91 91234 56789',
      'email': 'lakshmi@example.com',
      'address': 'Street C, 321 654',
      'type': 'Contract',
      'status': 'Blocked',
      'imageUrl': 'assets/images/profileimage.png', // Ensure asset exists
      'academicYear': '2023-2024',
    }),
  ];

  final List<AttendanceRecord> _allAttendance = [
    AttendanceRecord(name: "Vishnu Pratap", checkInTime: "7:00am"),
    AttendanceRecord(name: "Lakshmi Devi", checkInTime: "out 9:00am"),
    AttendanceRecord(name: "Anand Desai", checkInTime: "7:00am"),
    AttendanceRecord(name: "Lakshmi Devi", checkInTime: "out 9:00am"),
    AttendanceRecord(name: "Ramesh Kumar", checkInTime: "7:30am"),
    AttendanceRecord(name: "Anand Desai", checkInTime: "9:00am"),
  ];

  StaffScreenBloc() : super(StaffScreenInitial()) {
    print("StaffScreenBloc: Initialized. Current state: ${state.runtimeType}");

    on<LoadInitialStaffData>((event, emit) async {
      print("StaffScreenBloc: Received LoadInitialStaffData event.");
      emit(StaffScreenLoading());
      print("StaffScreenBloc: Emitted StaffScreenLoading.");

      try {
        // Simulate fetching data or any complex initialization
        // In a real app, this would be an API call or database query
        await Future.delayed(
          const Duration(milliseconds: 300),
        ); // Keep a small delay for simulation

        // Ensure data is not null (though _allStaff and _allAttendance are hardcoded here)
        // If fetching from a service, you'd check the response.
        final List<StaffMember> staffList = List.from(_allStaff);
        final List<AttendanceRecord> attendanceList = List.from(_allAttendance);

        // Optional: Check if lists are unexpectedly empty
        if (staffList.isEmpty) {
          print(
            "StaffScreenBloc: Warning - Staff list is empty after loading.",
          );
        }
        if (attendanceList.isEmpty) {
          print(
            "StaffScreenBloc: Warning - Attendance list is empty after loading.",
          );
        }

        emit(
          StaffScreenLoaded(
            originalStaffList: staffList,
            displayStaffList:
                staffList, // Initially, display list is the same as original
            attendanceList: attendanceList,
            selectedTabIndex: 1, // Default to Attendance tab or your preference
            searchQuery: "",
          ),
        );
        print(
          "StaffScreenBloc: Emitted StaffScreenLoaded with ${staffList.length} staff and ${attendanceList.length} attendance records.",
        );
      } catch (e, stackTrace) {
        print("StaffScreenBloc: ERROR during LoadInitialStaffData - $e");
        print("StaffScreenBloc: StackTrace - $stackTrace");
        emit(
          StaffScreenError("Failed to load initial data. Please try again."),
        );
        print("StaffScreenBloc: Emitted StaffScreenError.");
      }
    });

    on<TabChanged>((event, emit) {
      print(
        "StaffScreenBloc: Received TabChanged event to index ${event.tabIndex}.",
      );
      if (state is StaffScreenLoaded) {
        final currentState = state as StaffScreenLoaded;
        emit(currentState.copyWith(selectedTabIndex: event.tabIndex));
        print(
          "StaffScreenBloc: Emitted StaffScreenLoaded with new tab index ${event.tabIndex}.",
        );
      } else {
        print(
          "StaffScreenBloc: Warning - TabChanged event received but state is not StaffScreenLoaded. Current state: ${state.runtimeType}",
        );
      }
    });

    on<SearchStaff>((event, emit) {
      print(
        "StaffScreenBloc: Received SearchStaff event with query '${event.query}'.",
      );
      if (state is StaffScreenLoaded) {
        final currentState = state as StaffScreenLoaded;
        final query = event.query.toLowerCase().trim();
        List<StaffMember> filteredList;

        if (query.isEmpty) {
          filteredList = List.from(currentState.originalStaffList);
        } else {
          filteredList =
              currentState.originalStaffList.where((staff) {
                return staff.name.toLowerCase().contains(query) ||
                    staff.id.toLowerCase().contains(query) ||
                    (staff.department.toLowerCase().contains(
                      query,
                    )); // Example: search department too
              }).toList();
        }
        emit(
          currentState.copyWith(
            displayStaffList: filteredList,
            searchQuery: event.query,
          ),
        );
        print(
          "StaffScreenBloc: Emitted StaffScreenLoaded with ${filteredList.length} filtered staff members.",
        );
      } else {
        print(
          "StaffScreenBloc: Warning - SearchStaff event received but state is not StaffScreenLoaded. Current state: ${state.runtimeType}",
        );
      }
    });
  }
}
