// lib/data/dashboard_item.dart
import 'package:flutter/material.dart';

class DashboardItem {
  final IconData icon;
  final String title;
  final String? routeName; // Optional: Named route for navigation

  DashboardItem({
    required this.icon,
    required this.title,
    this.routeName,
  });
}