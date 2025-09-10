// bloc/notifications/notifications_state.dart
part of 'notifications_bloc.dart';

enum NotificationStatus { initial, loading, success, failure }

class NotificationsState extends Equatable {
  final NotificationStatus status;
  // Store grouped notifications directly
  final Map<String, List<NotificationItem>> groupedNotifications;
  final int bottomNavIndex;
  final String? errorMessage;

  const NotificationsState({
    this.status = NotificationStatus.initial,
    this.groupedNotifications = const {},
    this.bottomNavIndex = 0, // Home selected
    this.errorMessage,
  });

  NotificationsState copyWith({
    NotificationStatus? status,
    Map<String, List<NotificationItem>>? groupedNotifications,
    int? bottomNavIndex,
    String? errorMessage,
    bool clearError = false,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      groupedNotifications: groupedNotifications ?? this.groupedNotifications,
      bottomNavIndex: bottomNavIndex ?? this.bottomNavIndex,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override List<Object?> get props => [status, groupedNotifications, bottomNavIndex, errorMessage];
}