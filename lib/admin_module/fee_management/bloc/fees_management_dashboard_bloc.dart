// bloc/dashboard/fees_management_dashboard_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/fee_dashboard_data.dart'; // Import FlSpot if needed directly
part 'fees_management_dashboard_event.dart';
part 'fees_management_dashboard_state.dart';

class FeesManagementDashboardBloc
    extends Bloc<FeesManagementDashboardEvent, FeesManagementDashboardState> {
  FeesManagementDashboardBloc() : super(FeesManagementDashboardState.initial()) {
    on<LoadDashboardData>(_onLoadDashboardData);
    on<AcademicYearSelected>(_onAcademicYearSelected);
    on<BottomNavTapped>(_onBottomNavTapped);
    on<NavigateRequested>(_onNavigateRequested);

    add(LoadDashboardData()); // Load data on init
  }

  Future<void> _onLoadDashboardData(
      LoadDashboardData event, Emitter<FeesManagementDashboardState> emit) async {
    emit(state.copyWith(status: DashboardStatus.loading, clearError: true));
    try {
      // Simulate fetching data based on state.selectedAcademicYear
      await Future.delayed(const Duration(milliseconds: 600));
      final data = dummyDashboardData; // Replace with actual fetch logic

      emit(state.copyWith(
        status: DashboardStatus.success,
        dashboardData: data,
      ));
    } catch (e) {
      emit(state.copyWith(status: DashboardStatus.failure, errorMessage: e.toString()));
    }
  }

  void _onAcademicYearSelected(
      AcademicYearSelected event, Emitter<FeesManagementDashboardState> emit) {
    // Update selected year and trigger data reload
    emit(state.copyWith(selectedAcademicYear: event.year, clearAcademicYear: event.year == null));
    add(LoadDashboardData()); // Reload data for the new year
  }

  void _onBottomNavTapped(
      BottomNavTapped event, Emitter<FeesManagementDashboardState> emit) {
    emit(state.copyWith(bottomNavIndex: event.index));
  }

  void _onNavigateRequested(
      NavigateRequested event, Emitter<FeesManagementDashboardState> emit) {
    // Set the navigation target. The UI layer (BlocListener) will handle the actual navigation.
    emit(state.copyWith(navigationTarget: event.destination));
    // Reset the target immediately after emitting so it doesn't trigger again on rebuild
    emit(state.copyWith(clearNavigationTarget: true));
  }
}