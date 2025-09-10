import 'package:flutter/material.dart';

class Permission {
  final String hours;
  final String dateRange;
  final String reason;
  final String status;
  final Color statusColor;
  final IconData statusIcon;
  final Color iconColor;

  Permission({
    required this.hours,
    required this.dateRange,
    required this.reason,
    required this.status,
    required this.statusColor,
    required this.statusIcon,
    required this.iconColor,
  });
}
