// models/dashboard_card_item.dart (Create this file)
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../routes/app_routes.dart';

class DashboardCardItem extends Equatable {
  final String? value; // Large number (optional)
  final IconData? iconData; // Icon (optional, use only if value is null)
  final String label; // Main label text
  final String? secondaryLabel; // Smaller label below (e.g., count, amount)
  final Color? secondaryColor; // Color for the secondary label (e.g., red for notification count)
  final String navigationRoute; // Route name or identifier for navigation

  const DashboardCardItem({
    this.value,
    this.iconData,
    required this.label,
    this.secondaryLabel,
    this.secondaryColor,
    required this.navigationRoute, // Make navigation target required
  }) : assert(value != null || iconData != null, 'Either value or iconData must be provided'); // Ensure one is present

  @override
  List<Object?> get props => [value, iconData, label, secondaryLabel, secondaryColor, navigationRoute];
}

// --- Define Colors and Icons ---
// const Color _cardIconColor = Color(0xFF4A44B6); // Main purple for icons
// const Color _cardValueColor = Color(0xFF4A44B6); // Main purple for numbers
// const Color _cardLabelColor = Color(0xFF555555); // Dark grey for labels
// const Color _cardSecondaryLabelColor = Color(0xFF777777);
// const Color AppColors.ivory = Color(0xFFF8F7FF); // Very light lavender/off-white
// const Color _cardBorderColor = Color(0xFFE8E6F3); // Subtle border color

// --- Dummy Data (Replace IconData with actual icons matching UI) ---
final List<DashboardCardItem> dummyDashboardItems = [
  const DashboardCardItem(value: '11', label: 'Today Issued', navigationRoute: AppRoutes.libraryTodayIssued), // Example route
  const DashboardCardItem(value: '5', label: 'Today Received', navigationRoute: AppRoutes.libraryTodayReceived),
  const DashboardCardItem(value: '2', label: 'Due Books', navigationRoute: AppRoutes.libraryDueBooks),
  const DashboardCardItem(iconData: Icons.notifications, label: 'Notifications', secondaryLabel: '7', secondaryColor: AppColors.error, navigationRoute: AppRoutes.libraryNotifications),
  const DashboardCardItem(iconData: Icons.gavel_rounded, label: 'Fine managment', secondaryLabel: '₹1800', navigationRoute: AppRoutes.libraryFineManagement), // Note typo in image "managment"
  const DashboardCardItem(iconData: Icons.inventory_2_outlined, label: 'Total stock', secondaryLabel: '1200', navigationRoute: AppRoutes.libraryTotalStock),
  const DashboardCardItem(iconData: Icons.upload_file_rounded, label: 'Book issueing', navigationRoute: AppRoutes.libraryBookIssuing), // Note typo in image "issueing"
];