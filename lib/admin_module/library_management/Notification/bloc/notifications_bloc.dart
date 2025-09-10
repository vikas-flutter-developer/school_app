// bloc/notifications/notifications_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart'; // For groupBy
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../models/notification_item.dart';
part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  // TODO: Inject repository
  NotificationsBloc() : super(const NotificationsState()) {
    on<LoadNotifications>(_onLoadNotifications);
    on<BottomNavTapped>(_onBottomNavTapped);

    add(LoadNotifications()); // Initial load
  }

  // Helper to group notifications by formatted date string
  Map<String, List<NotificationItem>> _groupNotificationsByDate(List<NotificationItem> notifications) {
    // Define the specific format seen in the UI ("Month day(th/st/nd/rd), year")
    String formatDateWithSuffix(DateTime date) {
      String dayOfMonthSuffix(int day) {
        if (day >= 11 && day <= 13) { return 'th';}
        switch (day % 10) {
          case 1: return 'st';
          case 2: return 'nd';
          case 3: return 'rd';
          default: return 'th';
        }
      }
      // Use intl for month/year, manually add day+suffix
      final day = date.day;
      final suffix = dayOfMonthSuffix(day);
      final formattedDate = DateFormat('MMMM').format(date); // Month name
      return '$formattedDate $day$suffix, ${date.year}';
    }

    // Group by the formatted date string
    final grouped = groupBy(notifications, (item) => formatDateWithSuffix(item.date));

    // Sort groups by date descending (newest first)
    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) {
        // We need to parse the formatted string back to compare (or sort original list first)
        // Simpler: sort the original list by date first, then group.
        return b.compareTo(a); // This string comparison might not be reliable for dates
      });

    // Alternative: Sort original list first
    final sortedNotifications = List<NotificationItem>.from(notifications)
      ..sort((a, b) => b.date.compareTo(a.date)); // Descending date sort

    final reliableGrouped = groupBy(sortedNotifications, (item) => formatDateWithSuffix(item.date));

    // Return the map with keys sorted (if needed, depends on Map implementation details)
    // Or directly use reliableGrouped as groupBy often preserves insertion order from sorted list
    return reliableGrouped;
  }


  Future<void> _onLoadNotifications(LoadNotifications event, Emitter<NotificationsState> emit) async {
    emit(state.copyWith(status: NotificationStatus.loading));
    try {
      // TODO: Replace with actual data fetching
      await Future.delayed(const Duration(milliseconds: 400)); // Simulate load
      final List<NotificationItem> fetchedNotifications = dummyNotifications; // Use dummy data

      final grouped = _groupNotificationsByDate(fetchedNotifications);

      emit(state.copyWith(
        status: NotificationStatus.success,
        groupedNotifications: grouped,
      ));

    } catch (e) {
      emit(state.copyWith(status: NotificationStatus.failure, errorMessage: e.toString()));
    }
  }

  void _onBottomNavTapped(BottomNavTapped event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(bottomNavIndex: event.index));
  }
}