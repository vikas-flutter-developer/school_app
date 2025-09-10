// bloc/dashboard/fees_management_dashboard_event.dart
part of 'fees_management_dashboard_bloc.dart';

abstract class FeesManagementDashboardEvent extends Equatable {
  const FeesManagementDashboardEvent();
  @override List<Object?> get props => [];
}

class LoadDashboardData extends FeesManagementDashboardEvent {}

class AcademicYearSelected extends FeesManagementDashboardEvent {
  final String? year;
  const AcademicYearSelected(this.year);
  @override List<Object?> get props => [year];
}

class BottomNavTapped extends FeesManagementDashboardEvent {
  final int index;
  const BottomNavTapped(this.index);
  @override List<Object?> get props => [index];
}

// Events for Menu Navigation
class NavigateRequested extends FeesManagementDashboardEvent {
  final String destination; // e.g., 'fees_dues', 'fees_structure'
  const NavigateRequested(this.destination);
  @override List<Object?> get props => [destination];
}