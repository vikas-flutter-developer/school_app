// models/notification_item.dart (Create this file)
import 'package:equatable/equatable.dart';

class NotificationItem extends Equatable {
  final String id;
  final String message;
  final String time; // e.g., "12:35"
  final DateTime date; // The actual date for grouping

  const NotificationItem({
    required this.id,
    required this.message,
    required this.time,
    required this.date,
  });

  @override
  List<Object?> get props => [id, message, time, date];
}

// --- Dummy Data ---
// Helper to create dates easily
DateTime _date(int year, int month, int day) => DateTime(year, month, day);

final List<NotificationItem> dummyNotifications = [
  // March 18th
  NotificationItem(id: 'n10', message: 'ABCD book issued to XYZ student', time: '12:35', date: _date(2025, 3, 18)),
  NotificationItem(id: 'n11', message: 'ABCD book issued to XYZ student', time: '14:35', date: _date(2025, 3, 18)),
  NotificationItem(id: 'n12', message: 'ABCD book returned by XYZ student', time: '15:35', date: _date(2025, 3, 18)),
  NotificationItem(id: 'n13', message: 'ABCD book returned by XYZ student', time: '15:45', date: _date(2025, 3, 18)), // Added one more for variety
  // March 17th
  NotificationItem(id: 'n5', message: 'ABCD book issued to XYZ student', time: '12:35', date: _date(2025, 3, 17)),
  NotificationItem(id: 'n6', message: 'ABCD book issued to XYZ student', time: '14:35', date: _date(2025, 3, 17)),
  NotificationItem(id: 'n7', message: 'ABCD book returned by XYZ student', time: '15:35', date: _date(2025, 3, 17)),
  NotificationItem(id: 'n8', message: 'ABCD book returned by XYZ student', time: '15:35', date: _date(2025, 3, 17)),
  NotificationItem(id: 'n9', message: 'ABCD book returned by XYZ student', time: '15:45', date: _date(2025, 3, 17)),
  // March 16th
  NotificationItem(id: 'n1', message: 'ABCD book issued to XYZ student', time: '12:35', date: _date(2025, 3, 16)),
  NotificationItem(id: 'n2', message: 'ABCD book issued to XYZ student', time: '14:35', date: _date(2025, 3, 16)),
  NotificationItem(id: 'n3', message: 'ABCD book returned by XYZ student', time: '15:35', date: _date(2025, 3, 16)),
  NotificationItem(id: 'n4', message: 'ABCD book returned by XYZ student', time: '15:45', date: _date(2025, 3, 16)), // Adjusted time
];