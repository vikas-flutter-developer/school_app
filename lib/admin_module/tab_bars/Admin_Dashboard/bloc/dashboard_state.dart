/*
// lib/admin_dashboard_bloc/dashboard_state.dart
import 'package:equatable/equatable.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

// State emitted when a card is tapped and triggers navigation
class DashboardNavigating extends DashboardState {
  final String routeName;

  const DashboardNavigating({required this.routeName});

  @override
  List<Object> get props => [routeName];
}

// Add other states like DashboardLoading, DashboardLoaded, DashboardError if you fetch data*/
import 'package:equatable/equatable.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

// Initial state
class DashboardInitial extends DashboardState {}

// State emitted to trigger navigation in the UI
class DashboardNavigating extends DashboardState {
  final String routeName;

  const DashboardNavigating({required this.routeName});

  @override
  List<Object> get props => [routeName];
}