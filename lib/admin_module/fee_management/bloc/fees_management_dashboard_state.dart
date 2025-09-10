// bloc/dashboard/fees_management_dashboard_state.dart
part of 'fees_management_dashboard_bloc.dart';

enum DashboardStatus { initial, loading, success, failure }

class FeesManagementDashboardState extends Equatable {
  final DashboardStatus status;
  final FeeDashboardData dashboardData;
  final String? selectedAcademicYear;
  final List<String> academicYearOptions; // Load or provide defaults
  final int bottomNavIndex;
  final String? errorMessage;
  // Optional: State for navigation trigger
  final String? navigationTarget; // Holds destination from NavigateRequested event

  const FeesManagementDashboardState({
    this.status = DashboardStatus.initial,
    this.dashboardData = const FeeDashboardData(), // Use const default
    this.selectedAcademicYear,
    this.academicYearOptions = const ['2024-25', '2023-24', '2022-23'], // Example
    this.bottomNavIndex = 0, // Home selected
    this.errorMessage,
    this.navigationTarget,
  });

  // Helper factory for initial state
  factory FeesManagementDashboardState.initial() {
    // Potentially set a default year if needed
    const defaultYears = ['Academic Year','2024-25', '2023-24', '2022-23'];
    return FeesManagementDashboardState(
      selectedAcademicYear: defaultYears[0], // Select first year by default
      academicYearOptions: defaultYears,
    );
  }

  FeesManagementDashboardState copyWith({
    DashboardStatus? status,
    FeeDashboardData? dashboardData,
    String? selectedAcademicYear,
    bool clearAcademicYear = false, // Allow explicitly setting to null
    List<String>? academicYearOptions,
    int? bottomNavIndex,
    String? errorMessage,
    bool clearError = false,
    String? navigationTarget,
    bool clearNavigationTarget = false, // To reset navigation state after handling
  }) {
    return FeesManagementDashboardState(
      status: status ?? this.status,
      dashboardData: dashboardData ?? this.dashboardData,
      selectedAcademicYear: clearAcademicYear ? null : selectedAcademicYear ?? this.selectedAcademicYear,
      academicYearOptions: academicYearOptions ?? this.academicYearOptions,
      bottomNavIndex: bottomNavIndex ?? this.bottomNavIndex,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      navigationTarget: clearNavigationTarget ? null : navigationTarget ?? this.navigationTarget,
    );
  }

  @override
  List<Object?> get props => [
    status, dashboardData, selectedAcademicYear, academicYearOptions,
    bottomNavIndex, errorMessage, navigationTarget,
  ];
}