// lib/models/issue_data_model.dart
import 'package:flutter/material.dart';

// This is a placeholder/example model.
// For this refactoring, to avoid changing the internal structure of existing UI widgets,
// this model might not be deeply integrated into the current static UI display logic.
// If the data were dynamic (e.g., fetched from an API), this model would be crucial.

class IssueItem {
  final String id;
  final String name;
  final String type; // e.g., 'IDCard', 'Key', 'Other'
  final String status;
  final DateTime date;

  IssueItem({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.date,
  });
}

// Example structure for items in IDCards/Keys tabs
class TabularDisplayItem {
  final String name;
  final String date;
  final String statusText;
  final Color statusColor;

  TabularDisplayItem({
    required this.name,
    required this.date,
    required this.statusText,
    required this.statusColor,
  });
}

// Example structure for items in Others tab
class OtherDisplayItem {
  final String name;
  final String itemName; // e.g. "Bucket"
  final String issueDate;
  final String returnDate;
  final String issueStatusText;
  final Color issueStatusColor;
  final String returnStatusText;
  final Color returnStatusColor;

  OtherDisplayItem({
    required this.name,
    required this.itemName,
    required this.issueDate,
    required this.returnDate,
    required this.issueStatusText,
    required this.issueStatusColor,
    required this.returnStatusText,
    required this.returnStatusColor,
  });
}
