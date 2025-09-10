// models/feed_item.dart (Create this file)
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart'; // Import for IconData and Color

class FeedItem extends Equatable {
  final IconData iconData;
  final Color iconBgColor;
  final String title;
  final String description;

  const FeedItem({
    required this.iconData,
    required this.iconBgColor,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [iconData, iconBgColor, title, description];
}

// Define colors used in the UI
// const Color _iconBgColorHoliday = Color(0xFFB39DDB); // Example: Light purple variant
// const Color _iconBgColorAttendance = Color(0xFFB39DDB);
// const Color _iconBgColorAssignments = Color(0xFFB39DDB);
// const Color _iconBgColorTimetable = Color(0xFFB39DDB);
// const Color _iconBgColorAlert = Color(0xFFB39DDB);
// const Color _iconBgColorFees = Color(0xFFB39DDB);

// Dummy data for demonstration
final List<FeedItem> dummyFeedItems = [
  FeedItem(
    iconData: Icons.person_add_alt_sharp, // Or Icons.celebration
    iconBgColor: AppColors.primaryLight,
    title: 'Holiday Notice',
    description: 'The school will remain closed on March 14, 2025 for Holi celebration. Enjoy your break!',
  ),
  const FeedItem(
    iconData: Icons.check_circle_outline_rounded, // Or Icons.person_pin
    iconBgColor: AppColors.primaryLight,
    title: 'Attendance',
    description: 'Naveen Naveen is marked as present on Feb 25, 2025',
  ),
  const FeedItem(
    iconData: Icons.edit_note_outlined,
    iconBgColor: AppColors.primaryLight,
    title: 'Assignments & Homework',
    description: 'Mathematics: Solve Trigonometry Worksheet – Due: March 18, 2025',
  ),
  const FeedItem(
    iconData: Icons.schedule_outlined,
    iconBgColor: AppColors.primaryLight,
    title: 'Timetable',
    description: "Today's Math class is scheduled at 9:00 AM.",
  ),
  const FeedItem(
    iconData: Icons.assignment_late_outlined,
    iconBgColor: AppColors.primaryLight,
    title: 'Assignments Alert',
    description: 'Submit science project by Friday, March 24, 2025',
  ),
  const FeedItem(
    iconData: Icons.receipt_long_outlined, // Or Icons.payment
    iconBgColor: AppColors.primaryLight,
    title: 'Fees & Payments',
    description: 'Your next due payment of ₹5,000 is due by March 30, 2025',
  ),
];