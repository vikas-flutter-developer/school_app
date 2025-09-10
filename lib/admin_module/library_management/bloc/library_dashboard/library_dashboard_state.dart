// bloc/library_dashboard/library_dashboard_state.dart
part of 'library_dashboard_bloc.dart';

enum DashboardStatus { initial, loading, success, failure }

class LibraryDashboardState extends Equatable {
  final DashboardStatus status;
  final List<DashboardCardItem> items;
  final int notificationCount; // Example dynamic data
  final int bottomNavIndex;
  final String? navigationTarget; // For triggering navigation from listener
  final String? errorMessage;

  const LibraryDashboardState({
    this.status = DashboardStatus.initial,
    this.items = const [],
    this.notificationCount = 3, // Default count from image badge
    this.bottomNavIndex = 0, // Home selected
    this.navigationTarget,
    this.errorMessage,
  });

  LibraryDashboardState copyWith({
    DashboardStatus? status,
    List<DashboardCardItem>? items,
    int? notificationCount,
    int? bottomNavIndex,
    String? navigationTarget,
    bool clearNavigationTarget = false, // To reset nav state
    String? errorMessage,
    bool clearError = false,
  }) {
    return LibraryDashboardState(
      status: status ?? this.status,
      items: items ?? this.items,
      notificationCount: notificationCount ?? this.notificationCount,
      bottomNavIndex: bottomNavIndex ?? this.bottomNavIndex,
      navigationTarget: clearNavigationTarget ? null : navigationTarget ?? this.navigationTarget,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override List<Object?> get props => [status, items, notificationCount, bottomNavIndex, navigationTarget, errorMessage];
}