// bloc/library_dashboard/library_dashboard_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart'; // For IconData
import '../../models/dashboard_card_item.dart'; // Adjust path

part 'library_dashboard_event.dart';
part 'library_dashboard_state.dart';

class LibraryDashboardBloc extends Bloc<LibraryDashboardEvent, LibraryDashboardState> {
  LibraryDashboardBloc() : super(const LibraryDashboardState()) {
    on<LoadDashboard>(_onLoadDashboard);
    on<BottomNavTapped>(_onBottomNavTapped);
    on<CardTapped>(_onCardTapped);

    add(LoadDashboard()); // Load initial data
  }

  Future<void> _onLoadDashboard(LoadDashboard event, Emitter<LibraryDashboardState> emit) async {
    emit(state.copyWith(status: DashboardStatus.loading));
    try {
      // Simulate fetching data
      await Future.delayed(const Duration(milliseconds: 300));
      // TODO: Replace dummyDashboardItems with actual data from repository/API
      // Potentially update notificationCount based on fetched data
      emit(state.copyWith(
        status: DashboardStatus.success,
        items: dummyDashboardItems,
        // notificationCount: fetchedNotificationCount, // If fetched
      ));
    } catch (e) {
      emit(state.copyWith(status: DashboardStatus.failure, errorMessage: e.toString()));
    }
  }

  void _onBottomNavTapped(BottomNavTapped event, Emitter<LibraryDashboardState> emit) {
    emit(state.copyWith(bottomNavIndex: event.index));
  }

  void _onCardTapped(CardTapped event, Emitter<LibraryDashboardState> emit) {
    // Emit state to trigger navigation via BlocListener in UI
    emit(state.copyWith(navigationTarget: event.route));
    // Reset navigation target immediately so it doesn't trigger again
    emit(state.copyWith(clearNavigationTarget: true));
  }
}